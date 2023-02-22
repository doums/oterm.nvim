-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.

local M = {}

-- default configuration
local _config = {
  -- The command to run as a job, if nil run the 'shell'.
  command = nil, -- string or list of string
  -- Terminal buffer name
  name = 'oterm',
  -- The placement in the editor of the new terminal window.
  -- hsplit, vsplit split horizontally/vertically the current window
  -- tab, open in a new tab
  -- Floating layouts: center | bottom | top | left | right
  layout = 'hsplit',
  -- Some mapping, exit: close the job and the window
  -- normal: switch to normal mode
  keymaps = { exit = '<A-q>', normal = '<A-n>' },
  -- Highlight group for the terminal window,
  -- links to NormalFloat by default
  -- Use it to customize the background and default foreground 
  -- colors.
  -- Note that `g:terminal_color_x` will be used
  -- (see :h terminal - TERMINAL COLORS)
  hl_win = 'otermWin',
  -- Highlight group for horizontal and vertical splits
  -- links to WinSeparator by default
  hl_split = 'otermSplit',

  -- `on_exit` a optional function to call when the terminal's job
  -- exits. It will receive the job ID and exit code as argument.

  ----------------------------------------------------------------
  -- The rest of the config is related to floating layouts.

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
  -- Highlight group for borders, links to FloatBorder by default
  hl_border = 'otermBorder',
}

M._default_hls = {
  hl_win = 'NormalFloat',
  hl_split = 'WinSeparator',
  hl_border = 'FloatBorder',
}

function M.init(config)
  _config = vim.tbl_deep_extend('force', _config, config or {})
  return _config
end

function M.get_config()
  return _config
end

return M
