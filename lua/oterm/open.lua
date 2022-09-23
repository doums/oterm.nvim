--[[ This Source Code Form is subject to the terms of the Mozilla Public
License, v. 2.0. If a copy of the MPL was not distributed with this
file, You can obtain one at https://mozilla.org/MPL/2.0/. ]]

local api = vim.api
local fn = vim.fn
local cmd = vim.cmd
local opt = vim.opt
local uv = vim.loop

local _config = require('oterm.config')
local open_win = require('oterm.window').open_win

local terms = {}

local function on_exit(id, code)
  if api.nvim_win_is_valid(terms[id].window) then
    api.nvim_win_close(terms[id].window, true)
  end
  if api.nvim_buf_is_valid(terms[id].buffer) then
    api.nvim_buf_delete(terms[id].buffer, { force = true })
  end
  if type(terms[id].on_exit) == 'function' then
    terms[id].on_exit(id, code)
  end
  terms[id] = nil
end

local function create_keymaps(buffer, mapping)
  for lhs, rhs in pairs(mapping) do
    vim.keymap.set({ 'n', 't' }, lhs, rhs, { buffer = buffer })
  end
end

local function set_hl(config)
  local hl_map = {
    floating = {
      ['NormalFloat'] = config.terminal_hl,
      ['FloatBorder'] = config.border_hl,
    },
    normal = {
      ['Normal'] = config.terminal_hl,
      ['VertSplit'] = config.split_hl,
    },
  }
  local hls = config.floating and hl_map.floating or hl_map.normal
  for hl, value in pairs(hls) do
    vim.opt_local.winhighlight:prepend(string.format('%s:%s,', hl, value))
  end
end

local function open(config)
  config = vim.tbl_deep_extend(
    'force',
    vim.deepcopy(_config.get_config()),
    config or {}
  )
  local term = { on_exit = config.on_exit }
  term.window, term.buffer = unpack(open_win(config))
  set_hl(config)
  config.on_exit = on_exit
  if type(config.command) == 'string' and #config.command == 0 then
    config.command = nil
  end
  local job_id = fn.termopen(config.command or { opt.shell:get() }, config)
  create_keymaps(term.buffer, {
    [config.keymaps.exit] = '<Cmd>call jobstop(' .. job_id .. ')<CR>',
    [config.keymaps.normal] = '<C-\\><C-N>',
  })
  api.nvim_buf_set_name(
    term.buffer,
    string.format('%s‹%s›', config.name, uv.random(2))
  )
  if job_id == 0 then
    api.nvim_err_writeln(
      '[oterm] termopen() failed, invalid argument (or job table is full)'
    )
    return
  elseif job_id == -1 then
    api.nvim_err_writeln(
      '[oterm] termopen() failed, command or shell is not executable'
    )
    return
  end
  term.job_id = job_id
  terms[job_id] = term
  cmd('startinsert')
  return term
end

local M = { open = open }

return M
