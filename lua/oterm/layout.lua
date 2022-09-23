--[[ This Source Code Form is subject to the terms of the Mozilla Public
License, v. 2.0. If a copy of the MPL was not distributed with this
file, You can obtain one at https://mozilla.org/MPL/2.0/. ]]

local opt = vim.opt

local M = {}

function M.get_floating_layout(config)
  local screen_w = opt.columns:get()
  local screen_h = opt.lines:get() - opt.cmdheight:get()
  local _width = screen_w * config.width
  local _height = screen_h * config.height
  local width = math.floor(_width)
  local height = math.floor(_height)
  local center_y = (opt.lines:get() - _height) / 2
  local center_x = (screen_w - _width) / 2
  local layouts = {
    center = {
      anchor = 'NW',
      row = center_y + config.row,
      col = center_x + config.col,
      width = width,
      height = height,
    },
    bottom = {
      anchor = 'SW',
      row = screen_h - config.row,
      col = center_x + config.col,
      width = width,
      height = height,
    },
    top = {
      anchor = 'NW',
      row = 0 + config.row,
      col = center_x + config.col,
      width = width,
      height = height,
    },
    left = {
      anchor = 'NW',
      row = center_y + config.row,
      col = 0 + config.col,
      width = width,
      height = height,
    },
    right = {
      anchor = 'NE',
      row = center_y + config.row,
      col = screen_w - config.col,
      width = width,
      height = height,
    },
  }
  return layouts[config.layout]
end

M.layout_map = {
  tab = 'tabnew',
  hsplit = 'new',
  vsplit = 'vnew',
}

return M
