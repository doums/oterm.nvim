-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this
-- file, You can obtain one at https://mozilla.org/MPL/2.0/.

local M = {}

function M.win_hl_override(window, hl_group, value)
  local new_value = string.format('%s:%s', hl_group, value)
  local opt = vim.api.nvim_win_get_option(window, 'winhighlight')
  if #opt > 0 then
    new_value = string.format('%s,%s', opt, new_value)
  end
  vim.api.nvim_win_set_option(window, 'winhighlight', new_value)
end

function M.hl_exists(name)
  return not vim.tbl_isempty(vim.api.nvim_get_hl(0, { name = name }))
end

return M
