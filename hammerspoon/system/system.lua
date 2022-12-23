-- luacheck: globals hs, no unused
-- ultra bindings
local ultra = { 'ctrl', 'alt', 'cmd' }

local utils = require('utils')

-- --- My monitors
-- print(hs.inspect(hs.screen.allScreens()))
-- SCREEN1 = hs.screen.allScreens()[1]:name()
-- if hs.screen.allScreens()[2] then
--   SCREEN2 = hs.screen.allScreens()[2]:name()
-- end

-- --- Window filters
-- CURR_SPACE_WINFILTER = hs.window.filter.new():setCurrentSpace(true)
-- CURR_SCREEN_WINFILTER = hs.window.filter.new(function(w)
--   return w:screen() == hs.screen.mainScreen() and CURR_SPACE_WINFILTER:isWindowAllowed(w)
-- end)

-- function displaySleep()
--     hs.task.new('/usr/bin/pmset', nil, { 'displaysleepnow' }):start()
-- end

--   -- toggles
-- hs.fnutils.each({
--   { key = 't', fn = toggleTheme     },
--   { key = 'd', fn = toggleDND       },
--   { key = 'w', fn = toggleWiFi      },
--   { key = 'q', fn = displaySleep    },
-- }, function(object)
--     hs.hotkey.bind(ultra, object.key, object.fn)
-- end)

-- Menubar Item
-- ----------------------------------------------

-- local function getScreenWindows()
-- 	local windowsOnScreenByName = {}
--   hs.fnutils.each(CURR_SCREEN_WINFILTER:getWindows(), function(win)
--     if win:application() and win:application():name() then
--       windowsOnScreenByName[win:application():name()]=win
--     end
--   end)

--   print("Windows on screen:\n"..hs.inspect(windowsOnScreenByName))
--   -- hs.alert.show("getScreenWindows: "..dumpObj(windowsOnScreenByName))
--   return hs.screen.mainScreen(), windowsOnScreenByName
-- end

-- local function getWindowTitle(winByName, appName)
-- 	if not winByName[appName] then return nil else return winByName[appName]:title() end
-- end

-- local function notesSlackMailLayout()
-- 	local focusedScreen, winByName = getScreenWindows()
-- 	hs.layout.apply({
-- 	  {nil, getWindowTitle(winByName, "Google Chrome"), focusedScreen, {x=0, y=0, w=0.8, h=1}, nil, nil},
-- 	  {"Slack", nil, SCREEN1, {x=0, y=0.3, w=1, h=0.7}, nil, nil},
-- 	})
-- end

-- local function readingSublimeFirefoxSafariLayout()
-- 	local focusedScreen, winByName = getScreenWindows()
-- 	hs.layout.apply({
-- 	  {nil, getWindowTitle(winByName, "Google Chrome"), focusedScreen, {x=0, y=0.1, w=0.5, h=0.8}, nil, nil},
-- 	  {nil, getWindowTitle(winByName, "Visual Studio Code"), focusedScreen, {x=0, y=0.5, w=0.5, h=0.5}, nil, nil},
-- 	  {nil, getWindowTitle(winByName, "kitty"), focusedScreen, {x=0.5, y=0.5, w=0.5, h=0.5}, nil, nil},
-- 	})
-- end

-- local layoutMapping = {
-- 	Slack = notesSlackMailLayout,
-- 	Safari = readingSublimeFirefoxSafariLayout,
-- }

-- local function tileWindows()
--     local wins = hs.window.filter.new():setCurrentSpace(true):getWindows()
--     local screen = hs.screen.mainScreen():currentMode()
--     local rect = hs.geometry(0, 0, screen['w'], screen['h'])
--     hs.window.tiling.tileWindows(wins, rect)
-- end

-- local function layoutCurrentScreen()
-- 	local windows=CURR_SCREEN_WINFILTER:getWindows()
-- 	local foundWin=hs.fnutils.find(windows, function(win)
-- 	  return win:application() and layoutMapping[win:application():name()] ~= nil
-- 	end)
-- 	local appName=foundWin:application():name()
-- 	if foundWin then
-- 	  hs.alert.show("Arranging windows for "..appName)
-- 	  layoutMapping[appName]()
-- 	else
-- 	  print("Cannot determine desired layout: "..hs.inspect(windows))
-- 	end
-- end
