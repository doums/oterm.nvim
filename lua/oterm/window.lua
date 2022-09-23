--[[ This Source Code Form is subject to the terms of the Mozilla Public
License, v. 2.0. If a copy of the MPL was not distributed with this
file, You can obtain one at https://mozilla.org/MPL/2.0/. ]]

local api = vim.api
local get_floating_layout = require('oterm.layout').get_floating_layout
local layout_map = require('oterm.layout').layout_map

local M = {}

function M.open_win(config)
  local buffer
  local window
  if config.floating then
    buffer = api.nvim_create_buf(true, false)
    local win_options = config.win_api
    if config.layout then
      win_options = vim.tbl_deep_extend(
        'force',
        config.win_api,
        get_floating_layout(config)
      )
    end
    window = api.nvim_open_win(buffer, true, win_options)
  else
    for layout, command in pairs(layout_map) do
      if config.layout == layout then
        vim.cmd(command)
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
