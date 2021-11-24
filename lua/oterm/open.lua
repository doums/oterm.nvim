--[[ This Source Code Form is subject to the terms of the Mozilla Public
License, v. 2.0. If a copy of the MPL was not distributed with this
file, You can obtain one at https://mozilla.org/MPL/2.0/. ]]

local api = vim.api
local fn = vim.fn
local cmd = vim.cmd
local opt = vim.opt

local _config = require('oterm.config')

local terms = {}

local function on_exit(id, code)
  api.nvim_win_close(terms[id].window, true)
  api.nvim_buf_delete(terms[id].buffer, { force = true })
  if type(terms[id].on_exit) == 'function' then
    terms[id].on_exit(id, code)
  end
  terms[id] = nil
end

local layout_map = {
  tab = 'tabnew',
  hsplit = 'new',
  vsplit = 'vnew',
}

local function create_window(config)
  for layout, command in pairs(layout_map) do
    if config.layout == layout then
      cmd(command)
      break
    end
  end
  local win = api.nvim_get_current_win()
  api.nvim_win_set_option(win, 'number', false)
  api.nvim_win_set_option(win, 'relativenumber', false)
  api.nvim_win_set_option(win, 'signcolumn', 'no')
  return api.nvim_get_current_win()
end

local function create_keymaps(buffer, mapping)
  for lhs, rhs in pairs(mapping) do
    api.nvim_buf_set_keymap(buffer, 'n', lhs, rhs, { noremap = true })
    api.nvim_buf_set_keymap(buffer, 't', lhs, rhs, { noremap = true })
  end
end

local function set_hl(config)
  if config.bg_color then
    -- TODO use api.nvim_set_hl instead
    cmd('hi! otermWin guibg=' .. config.bg_color)
    opt.winhighlight:prepend('Normal:otermWin,')
  end
  if config.split_hl then
    opt.winhighlight:prepend(string.format('VertSplit:%s,', config.split_hl))
  end
end

local function open(config)
  config = vim.tbl_deep_extend(
    'force',
    vim.deepcopy(_config.get_config()),
    config or {}
  )
  local term = { on_exit = config.on_exit }
  term.window = create_window(config)
  term.buffer = api.nvim_get_current_buf()
  set_hl(config)
  config.on_exit = on_exit
  local job_id = fn.termopen(config.command or { opt.shell:get() }, config)
  create_keymaps(term.buffer, {
    [config.keymaps.exit] = '<Cmd>call jobstop(' .. job_id .. ')<CR>',
    [config.keymaps.normal] = '<C-\\><C-N>',
  })
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
