--[[ This Source Code Form is subject to the terms of the Mozilla Public
License, v. 2.0. If a copy of the MPL was not distributed with this
file, You can obtain one at https://mozilla.org/MPL/2.0/. ]]

local charset = {}
do -- [0-9a-zA-Z]
  for c = 48, 57 do
    table.insert(charset, string.char(c))
  end
  for c = 65, 90 do
    table.insert(charset, string.char(c))
  end
  for c = 97, 122 do
    table.insert(charset, string.char(c))
  end
end

local function random_str(length)
  if not length or length <= 0 then
    return ''
  end
  math.randomseed(os.clock() ^ 5)
  return random_str(length - 1) .. charset[math.random(1, #charset)]
end

local M = {
  random_str = random_str,
}

return M
