--[[ This Source Code Form is subject to the terms of the Mozilla Public
License, v. 2.0. If a copy of the MPL was not distributed with this
file, You can obtain one at https://mozilla.org/MPL/2.0/. ]]

-- default configuration
local _config = {
  -- The command to run as a job, if nil run the 'shell'.
  command = nil, -- string or list of string
  -- Terminal buffer name
  name = 'oterm',
  -- The placement in the editor of the new terminal window.
  -- hsplit, split horizontally the current window
  -- vsplit, split vertically the current window
  layout = 'hsplit',
  -- Some mapping, exit: close the job and the window, normal:
  -- switch to normal mode
  keymaps = { exit = '<A-q>', normal = '<A-n>' },
  -- Terminal highlight group, default Normal
  -- With it you can customize the background and default
  -- foreground color since `{g,b}:terminal_color_x` will be used
  -- as well for foreground, based on ANSI sequences
  -- (see :h terminal TERMINAL COLORS)
  terminal_hl = nil,
  -- Custom VertSplit highlight group
  split_hl = nil,
}

local function init(config)
  if config then
    _config = vim.tbl_deep_extend('force', _config, config)
  end
end

local function get_config()
  return _config
end

local M = { get_config = get_config, init = init }
return M
