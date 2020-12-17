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
local gridset = function(x, y, w, h)
  return function()
    cur_window = hs.window.focusedWindow()
    hs.grid.set(
      cur_window,
      {x=x, y=y, w=w, h=h},
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
hs.hotkey.bind({"ctrl", "alt", "cmd"}, "F", gridset(0,0,12,12))
hs.hotkey.bind({"ctrl", "alt", "cmd"}, "UP", gridset(1,1,10,10))

-- Half Bindings
hs.hotkey.bind({"ctrl","cmd"}, 'h', gridset(0,0,6,12))
hs.hotkey.bind({"ctrl","cmd"}, 'k', gridset(0,0,12,6))
hs.hotkey.bind({"ctrl","cmd"}, 'j', gridset(0,6,12,6))
hs.hotkey.bind({"ctrl","cmd"}, 'l', gridset(6,0,6,12))

-- Third Bindings
hs.hotkey.bind({"ctrl", "alt"}, "h", gridset(0,0,4,12))
hs.hotkey.bind({"ctrl", "alt"}, "l", gridset(8,0,4,12))
hs.hotkey.bind({"ctrl", "alt"}, "k", gridset(4,0,4,12))
hs.hotkey.bind({"ctrl", "alt"}, "j", gridset(4,0,4,12))

-- Quarter Bindings
hs.hotkey.bind(optcmd, '1', gridset(0,0,6,6))
hs.hotkey.bind(optcmd, '2', gridset(6,0,6,6))
hs.hotkey.bind(optcmd, '3', gridset(6,6,6,6))
hs.hotkey.bind(optcmd, '4', gridset(0,6,6,6))

-- -- Move between screens
hs.hotkey.bind({"ctrl", "alt", "cmd"}, "Left",  hs.fnutils.partial(winmovescreen, "left"))
hs.hotkey.bind({"ctrl", "alt", "cmd"}, "Right", hs.fnutils.partial(winmovescreen, "right"))
