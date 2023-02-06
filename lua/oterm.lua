-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.

local _config = require('oterm.config')
local open = require('oterm.open').open
local api = vim.api

api.nvim_create_user_command('Oterm', function(args)
  open({ command = args.args })
end, {
  nargs = '*',
})

api.nvim_create_user_command('Otferm', function(args)
  open({ command = args.args, floating = true, layout = 'center' })
end, {
  nargs = '*',
})

local function setup(config)
  _config.init(config)
end

local M = {
  setup = setup,
  open = open,
}

return M
