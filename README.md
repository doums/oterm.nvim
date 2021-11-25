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
  bg_color = '#211a16',
  split_hl = 'otermSplit',
})
```

All default values are listed
[here](https://github.com/doums/oterm.nvim/blob/main/lua/oterm/config.lua).

```lua
local _config = {
  -- The command to run as a job, if nil run the 'shell'.
  command = nil, -- string or list of string
  -- The placement in the editor of the new terminal window.
  -- hsplit, split horizontally the current window
  -- vsplit, split vertically the current window
  layout = 'hsplit',
  -- Some mapping, exit: close the job and the window, normal:
  -- switch to normal mode
  keymaps = { exit = '<A-q>', normal = '<A-n>' },
  -- Custom background color, default use the color from Normal
  -- highlight group
  bg_color = nil, -- as hex color string eg. #212121
  -- Custom VertSplit highlight group
  split_hl = nil,
}
```

And you can override it by call:

```lua
map('n', '<M-t>', [[<cmd>lua require'oterm'.open()<cr>]])
map('n', '<M-v>', [[<cmd>lua require'oterm'.open({layout='vsplit'})<cr>]])
```

NOTE: You can add more custom options in the config to configure
the spawned job as the config table is passed down to the
`termopen` function (`:h termopen`, `:h jobstart`).

### Usage

You can create the mappings you want to spawn shell or commands in
different ways:

```lua
map('n', '<M-t>', [[<cmd>Ot<cr>]])
map('n', '<M-v>', [[<cmd>lua require'oterm'.open({layout='vsplit'})<cr>]])
```

You can also use the commands `:Oterm [command]` and `:Ot [command]`.

### License

Mozilla Public License 2.0
