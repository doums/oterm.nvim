## oterm.nvim

A [neovim](https://neovim.io/) plugin to open terminal quickly and
nicely.

### Install

Use your plugin manager

```lua
require('paq')({
  -- ...
  'doums/oterm.nvim',
})
```

Or use the native packages (`:h packages`).

### Configuration

You can configure Oterm globally via the `setup` function:

```lua
require('oterm').setup({
  terminal_color = 'oterm',
  split_hl = 'otermSplit',
})
```

All default values are listed
[here](https://github.com/doums/oterm.nvim/blob/main/lua/oterm/config.lua).

```lua
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
  -- The rest of the config is related to floating mode only.

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
```

NOTE: You can add more custom options in the config to configure
the spawned job as the config table is passed down to the
`termopen` function (`:h termopen`, `:h jobstart`).

### Usage

You can create the mappings you want to spawn shell or commands in
different ways and using different layouts:

```lua
local open = require('oterm').open

vim.keymap.set.map('n', '<M-t>', function() open() end)
vim.keymap.set.map('n', '<M-v>', function() open({layout='vsplit'}) end)
vim.keymap.set.map('n', '<M-f>', function() open({floating=true,layout='center'}) end)

-- spawn nnn in a floating window
vim.keymap.set('n', '<M-n>', function()
  open({
    floating = true,
    name = 'nnn',
    layout = 'center',
    height = 0.7,
    width = 0.6,
    command = 'nnn',
  })
end)
```

You can also use the commands `:Oterm [command]` and `:Ot [command]`.

### License

Mozilla Public License 2.0
