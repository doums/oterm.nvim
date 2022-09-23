--[[ This Source Code Form is subject to the terms of the Mozilla Public
License, v. 2.0. If a copy of the MPL was not distributed with this
file, You can obtain one at https://mozilla.org/MPL/2.0/. ]]

-- default configuration
local _config = {
  -- The command to run as a job, if nil run the 'shell'.
  command = nil, -- string or list of string
  -- Terminal buffer name
  name = 'oterm',
  -- Spawn terminal in a floating window (floating mode)
  floating = false,
  -- The placement in the editor of the new terminal window.
  -- hsplit, split horizontally the current window
  -- vsplit, split vertically the current window
  -- tab, open in a new tab
  -- For floating mode: center | bottom | top | left | right
  layout = 'hsplit',
  -- Some mapping, exit: close the job and the window
  -- normal: switch to normal mode
  keymaps = { exit = '<A-q>', normal = '<A-n>' },
  -- Terminal highlight group, default Normal
  -- With it you can customize the background and default
  -- foreground color since `{g,b}:terminal_color_x` will be used
  -- as well for foreground, based on ANSI sequences
  -- (see :h terminal TERMINAL COLORS)
  terminal_hl = nil,
  -- Custom VertSplit highlight group
  split_hl = nil,

  -- `on_exit` a optional function to call when the terminal's job
  -- exits. It will receive the job ID and exit code as argument.

  ----------------------------------------------------------------
  -- ** The rest of the config is for floating mode only. **
  -- The width/height of the window. Must be a value between 0.1
  -- and 1, 1 corresponds to 100% of the editor width/height.
  width = 0.8,
  height = 0.8,
  -- Offset in character cells of the window, relative to the
  -- layout.
  row = 0,
  col = 0,
  -- Options passed to nvim_open_win (:h nvim_open_win())
  -- You can use it to customize various things like border etc.
  win_api = { style = 'minimal', relative = 'editor' },
  -- Border highlight group, default FloatBorder
  border_hl = nil,
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
