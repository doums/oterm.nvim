-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.

local api = vim.api
local get_floating_layout = require('oterm.layout').get_floating_layout
local layout_map = require('oterm.layout').layout_map
local is_floating = require('oterm.layout').is_floating

local M = {}

function M.open_win(config)
  local buffer
  local window
  local layout = config.layout or 'vsplit'
  if is_floating(layout) then
    buffer = api.nvim_create_buf(true, false)
    local win_options = config.win_api
    win_options =
      vim.tbl_deep_extend('force', config.win_api, get_floating_layout(config))
    window = api.nvim_open_win(buffer, true, win_options)
  else
    for l, command in pairs(layout_map) do
      if layout == l then
        vim.cmd(command)
        vim.wo.winfixheight = true
        break
      end
    end
    vim.wo.number = false
    vim.wo.relativenumber = false
    vim.wo.signcolumn = 'no'
    window = api.nvim_get_current_win()
    buffer = api.nvim_get_current_buf()
  end
  return { window, buffer }
end

return M
