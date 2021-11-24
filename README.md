## floaterm.nvim

A [neovim](https://neovim.io/) plugin to open terminal in floating
window.

### Install

Use your plugin manager

```lua
require('paq')({
  -- ...
  'doums/floaterm.nvim',
})
```

Or use the native packages (`:h packages`).

### Configuration

You can configure Floaterm globally via the `setup` function:

```lua
require('floaterm').setup({
  layout = 'bottom',
  width = 1,
  height = 0.4,
  bg_color = '#211a16',
})
```

All default values are listed
[here](https://github.com/doums/floaterm.nvim/blob/main/lua/floaterm/config.lua).

```lua
local _config = {
  -- The command to run as a job, if nil run the 'shell'.
  command = nil, -- string or list of string
  -- The placement in the editor of the floating window.
  layout = 'center', -- center | bottom | top | left | right
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
  -- Some mapping, exit: close the job and the window, normal:
  -- switch to normal mode
  keymaps = { exit = '<A-q>', normal = '<A-n>' },
  -- Terminal buffer name
  name = 'fterm',
  -- Background color, default use the color from NormalFloat
  bg_color = nil, -- as hex color string eg. #212121
  -- Border highlight group, default FloatBorder
  border_hl = nil,
}
```

And you can override it by call:

```lua
map(
  'n',
  '<M-n>',
  [[<cmd>lua require'floaterm'.open({name='nnn',layout='center',height=0.7,width=0.6,command='nnn'})<cr>]]
)
```

NOTE: You can add more custom options in the config to configure
the spawned job as the config table is passed down to the
`termopen` function (`:h termopen`, `:h jobstart`).

### Usage

You can create the mappings you want to spawn shell or commands in
different ways:

```lua
map('n', '<M-t>', [[<cmd>lua require'floaterm'.open({row=1})<cr>]])
map(
  'n',
  '<M-n>',
  [[<cmd>lua require'floaterm'.open({name='nnn',layout='center',height=0.7,width=0.6,command='nnn'})<cr>]]
)
```

You can also use the command `:Fterm` to spawn a shell/command
using the global config.

### License

Mozilla Public License 2.0

