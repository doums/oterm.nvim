--[[ This Source Code Form is subject to the terms of the Mozilla Public
License, v. 2.0. If a copy of the MPL was not distributed with this
file, You can obtain one at https://mozilla.org/MPL/2.0/. ]]

local _config = require('oterm.config')
local open = require('oterm.open')

vim.cmd(
  [[command -nargs=* -complete=shellcmd Oterm lua require('oterm').open({mods=<q-mods>,command=<q-args>})]]
)
vim.cmd(
  [[command -nargs=* -complete=shellcmd Ot lua require('oterm').open({mods=<q-mods>,command=<q-args>})]]
)

local function setup(config)
  _config.init(config)
end

local M = {
  setup = setup,
  open = open.open,
}

return M
