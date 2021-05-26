-- Window management

-- Uncomment if you want to disable Animation
-- hs.window.animationDuration = 0

-- Hotkeys
local opt = {"alt"}
local optcmd = {"alt", "cmd"}
local shftopt = {"shift", "alt"}
local shftcmd = {"shift", "cmd"}

hs.grid.MARGINX = 10
hs.grid.MARGINY = 10
hs.grid.GRIDWIDTH = 12
hs.grid.GRIDHEIGHT = 12

-- Grid Helper Function
local gridset = function(cell)
  return function()
    cur_window = hs.window.focusedWindow()
    hs.grid.set(
      cur_window,
      cell,
      cur_window:screen()
    )
  end
end

-- Window Movement Helper Function
function winmovescreen(how)
   local win = hs.window.focusedWindow()
   if how == "left" then
      win:moveOneScreenWest()
   elseif how == "right" then
      win:moveOneScreenEast()
   end
end

-- Full Bindings
hs.hotkey.bind({"ctrl", "alt", "cmd"}, "F", gridset('0,0 12x12'))

-- Half Bindings
-- Vertical halves
hs.hotkey.bind({"ctrl","cmd"}, 'h', gridset('0,0 6x12'))
hs.hotkey.bind({"ctrl","cmd"}, 'l', gridset('6,0 6x12'))
-- Horizontal halves
hs.hotkey.bind({"ctrl","cmd"}, 'k', gridset('0,0 12x6'))
hs.hotkey.bind({"ctrl","cmd"}, 'j', gridset('0,6 12x6'))

-- Third Bindings
-- Vertical thirds
hs.hotkey.bind({"ctrl", "alt"}, "h", gridset('0,0 4x12'))
hs.hotkey.bind({"ctrl", "alt"}, "k", gridset('4,0 4x12'))
hs.hotkey.bind({"ctrl", "alt"}, "l", gridset('8,0 4x12'))
-- Horizontal thirds
hs.hotkey.bind({"ctrl", "alt"}, "j", gridset('0,0 8x12'))
hs.hotkey.bind({"ctrl", "alt"}, ";", gridset('4,0 8x12'))

-- Quarter Bindings
hs.hotkey.bind(optcmd, '-', gridset('0,0 6x6'))
hs.hotkey.bind(optcmd, '=', gridset('6,0 6x6'))
hs.hotkey.bind(optcmd, '[', gridset('0,6 6x6'))
hs.hotkey.bind(optcmd, ']', gridset('6,6 6x6'))

-- -- Move between screens
hs.hotkey.bind({"ctrl", "alt", "cmd"}, "Left",  hs.fnutils.partial(winmovescreen, "left"))
hs.hotkey.bind({"ctrl", "alt", "cmd"}, "Right", hs.fnutils.partial(winmovescreen, "right"))

-- grid gui
hs.hotkey.bind({'shift', 'cmd'}, 'g', hs.grid.show)
