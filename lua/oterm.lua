-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.

local init_config = require('oterm.config').init
local default_hls = require('oterm.config')._default_hls
local utils = require('oterm.utils')
local open = require('oterm.open').open

vim.api.nvim_create_user_command('Oterm', function(args)
  open({ command = args.args })
end, {
  nargs = '*',
})

vim.api.nvim_create_user_command('Otferm', function(args)
  open({ command = args.args, layout = 'center' })
end, {
  nargs = '*',
})

local function init_hls(config)
  for k_hl, default in pairs(default_hls) do
    local hl = config[k_hl]
    if not utils.hl_exists(hl) then
      vim.api.nvim_set_hl(0, hl, { link = default })
    end
  end
end

local function setup(config)
  local cfg = init_config(config)
  init_hls(cfg)
end

local M = {
  setup = setup,
  open = open,
}

return M
