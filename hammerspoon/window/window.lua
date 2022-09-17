-- Window management
local utils        = require('utils')

-- Uncomment if you want to disable Animation
-- hs.window.animationDuration = 0

-- Hotkeys
local hints = hs.hints
-- Hints
hints.fontName = "Helvetica-Bold"
hints.fontSize = 18
hints.showTitleThresh = 0
-- hints.style           = "vimperator" -- Buggy, gets slow after a while


local opt = { '⌥' }
local optcmd = { '⌥', '⌘' }
local shftopt = { '⇧', '⌥' }
local shftcmd = { '⇧', '⌘' }

hs.grid.MARGINX = 10
hs.grid.MARGINY = 10
hs.grid.GRIDWIDTH = 12
hs.grid.GRIDHEIGHT = 12

-- Grid Helper Function
local gridset = function(cell)
  return function()
    cur_window = hs.window.focusedWindow()
    hs.grid.set(cur_window, cell, cur_window:screen())
  end
end

-- Window Movement Helper Function
function winmovescreen(how)
  local win = hs.window.focusedWindow()
  if how == 'left' then
    win:moveOneScreenWest()
  elseif how == 'right' then
    win:moveOneScreenEast()
  end
end

-- Full Bindings
hs.hotkey.bind({ '⌃', '⌥', '⌘' }, 'F', gridset('0,0 12x12'))

-- Half Bindings
-- Vertical halves
hs.hotkey.bind({ '⌃', '⌘' }, 'h', gridset('0,0 6x12'))
hs.hotkey.bind({ '⌃', '⌘' }, 'l', gridset('6,0 6x12'))
-- Horizontal halves
hs.hotkey.bind({ '⌃', '⌘' }, 'k', gridset('0,0 12x6'))
hs.hotkey.bind({ '⌃', '⌘' }, 'j', gridset('0,6 12x6'))

-- Third Bindings
-- Vertical thirds
hs.hotkey.bind({ '⌃', '⌥' }, 'h', gridset('0,0 4x12'))
hs.hotkey.bind({ '⌃', '⌥' }, 'k', gridset('4,0 4x12'))
hs.hotkey.bind({ '⌃', '⌥' }, 'l', gridset('8,0 4x12'))
-- Horizontal thirds
hs.hotkey.bind({ '⌃', '⌥' }, 'j', gridset('0,0 8x12'))
hs.hotkey.bind({ '⌃', '⌥' }, ';', gridset('4,0 8x12'))

-- Quarter Bindings
hs.hotkey.bind(optcmd, '-', gridset('0,0 6x6'))
hs.hotkey.bind(optcmd, '=', gridset('6,0 6x6'))
hs.hotkey.bind(optcmd, '[', gridset('0,6 6x6'))
hs.hotkey.bind(optcmd, ']', gridset('6,6 6x6'))

-- Centered Big
hs.hotkey.bind({ '⌃', '⌘' }, 'c', gridset('2,0 8x12'))

-- Centered Small
hs.hotkey.bind({ '⌃', '⌥', '⌘' }, 'c', gridset('3,0 6x12'))

-- -- Move between screens
hs.hotkey.bind({ '⌃', '⌘' }, 'p', hs.fnutils.partial(winmovescreen, 'left'))
hs.hotkey.bind({ '⌃', '⌘' }, 'n', hs.fnutils.partial(winmovescreen, 'right'))

-- grid gui
hs.hotkey.bind({ '⇧', '⌘' }, 'g', hs.grid.show)

-- Movement hotkeys (Moved to Raycast -- keep for later)
hs.hotkey.bind({ "⌥", "⌘" }, "down",  function() utils.nudge(0, 100) end)
hs.hotkey.bind({ "⌥", "⌘" }, "up",    function() utils.nudge(0, -100) end)
hs.hotkey.bind({ "⌥", "⌘" }, "right", function() utils.nudge(100, 0) end)
hs.hotkey.bind({ "⌥", "⌘" }, "left",  function() utils.nudge(-100, 0) end)

-- Hints
hs.hotkey.bind({ "⌃", "⌥", "⌘" }, "space", function()
	hints.windowHints(utils.getAllValidWindows())
end)
