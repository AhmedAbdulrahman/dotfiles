-- luacheck: globals hs, no unused

local module = {}

---trims whitespace from string
---@param str string
---@return string
local function trim(str)
  if not str then
    return ''
  end
  return (str:gsub('^%s*(.-)%s*$', '%1'))
end

---returns current date in ISO 8601 format
---@return string|osdate
local function isodate()
  return os.date('!%Y-%m-%d')
end

---@param str string
---@param separator string uses Lua Pattern, so requires escaping
---@return table
local function split(str, separator)
  str = str .. separator
  local output = {}
  -- https://www.lua.org/manual/5.4/manual.html#pdf-string.gmatch
  for i in str:gmatch('(.-)' .. separator) do
    table.insert(output, i)
  end
  return output
end

---key_stroke types a keystroke with no delay, and optionally accepts modifiers
module.key_stroke = function(mods_or_key, key)
  if type(mods_or_key) == 'string' then
    return hs.eventtap.keyStroke({}, mods_or_key, 0)
  end
  return hs.eventtap.keyStroke(mods_or_key, key, 0)
end

-- capitalize string
module.capitalize = function(str)
  return str:gsub('^%l', string.upper)
end

-- split a string
module.split = function(str, pat)
  local t = {} -- NOTE: use {n = 0} in Lua-5.0
  local fpat = '(.-)' .. pat
  local lastEnd = 1
  local s, e, cap = str:find(fpat, 1)
  while s do
    if s ~= 1 or cap ~= '' then
      table.insert(t, cap)
    end
    lastEnd = e + 1
    s, e, cap = str:find(fpat, lastEnd)
  end
  if lastEnd <= #str then
    cap = str:sub(lastEnd)
    table.insert(t, cap)
  end
  return t
end

-- Return a string that converts a number of minutes into MM:SS format.
module.prettyMinutes = function(minutes)
  return string.format('%02d:%02d', math.floor(minutes / 60), minutes % 60)
end

-- Create a new counter with the given name and first value.
-- If the first value is 0 (default), the counter will count upward,
-- otherwise the counter will count downward.
module.new = function(name, begin)
  local first = begin or 0
  local amt = first == 0 and 1 or -1
  local i = first
  local repr = 'counter (' .. (name or 'unnamed') .. '): '

  return {
    -- increment/decrement the counter (depending on first value == 0 or not)
    incr = function()
      i = i + amt
    end,
    -- reset the counter to the first value
    reset = function()
      i = first
    end,
    -- get the current count
    get = function()
      return i
    end,
    -- get a string representation of the counter (useful for debugging)
    asString = function()
      return repr .. i
    end,
  }
end

-- Takes a list of path parts, returns a string with the parts delimited by '/'
module.toPath = function(...)
  return table.concat({ ... }, '/')
end

module.getAllValidWindows = function()
  local allWindows = hs.window.allWindows()
  local windows = {}
  local index = 1
  for i = 1, #allWindows do
    local w = allWindows[i]
    if w:screen() then
      windows[index] = w
      index = index + 1
    end
  end
  return windows
end

-- Move a window a number of pixels in x and y
module.nudge = function(xpos, ypos)
  local win = hs.window.focusedWindow()
  local f = win:frame()
  f.x = f.x + xpos
  f.y = f.y + ypos
  win:setFrame(f)
end

-- Hacky workaround: make Hammerspoon render the icon by creating
-- a menubar object, grabbing the icon and deleting the menubar
-- object.
module.iconFromASCII = function(ascii)
  local menubar = hs.menubar.new(false):setIcon(ascii)
  local icon = menubar:icon() -- hs.image object or nil, if there isn't one.
  menubar:delete()
  return icon
end

---@return boolean
module.isProjector = function()
  local mainDisplayName = hs.screen.primaryScreen():name()
  local projectorHelmholtz = mainDisplayName == 'ViewSonic PJ'
  local tvLeuthinger = mainDisplayName == 'TV_MONITOR'
  return projectorHelmholtz or tvLeuthinger
end

---@return boolean
module.isAtOffice = function()
  local mainDisplayName = hs.screen.primaryScreen():name()
  local screenOne = mainDisplayName == 'HP E223'
  local screenTwo = mainDisplayName == 'Acer CB241HY'
  return screenOne or screenTwo
end

---@return boolean
module.screenIsUnlocked = function()
  local _, success = hs.execute(
    '[[ "$(/usr/libexec/PlistBuddy -c "print :IOConsoleUsers:0:CGSSessionScreenIsLocked" /dev/stdin 2>/dev/null <<< "$(ioreg -n Root -d1 -a)")" != "true" ]] && exit 0 || exit 1'
  )
  return success ---@diagnostic disable-line: return-type-mismatch
end

---@return string
module.deviceName = function()
  -- similar to `scutil --get ComputerName`, only native to hammerspoon and therefore a bit more reliable
  local name, _ = hs.host.localizedName():gsub('.- ', '', 1)
  return name
end

---@return boolean
module.isAtMother = function()
  if module.deviceName():find('Mother') then
    return true
  end
  return false
end

---@return boolean
module.isIMacAtHome = function()
  if module.deviceName():find('iMac') and module.deviceName():find('Home') then
    return true
  end
  return false
end

---Send Notification
---@param text string
module.notify = function(text)
  if text then
    text = trim(text)
  else
    text = 'empty string'
  end
  hs.notify.new({ title = 'Hammerspoon', informativeText = text }):send()
  print('notify: ' .. text) -- for the console
end

return module
