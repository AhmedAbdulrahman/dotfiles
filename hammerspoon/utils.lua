-- luacheck: globals hs, no unused

local module = {}

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

module.getAllValidWindows = function(...)
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
  local menubar = hs.menubar:new(false):setIcon(ascii)
  local icon = menubar:icon() -- hs.image object
  menubar:delete()
  return icon
end

return module
