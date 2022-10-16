-- luacheck: globals hs spoon trueR Install CURR_SCREEN_WINFILTER CURR_SPACE_WINFILTER, no unused

---init
local alert = require('hs.alert')
local buf = {}
local log = hs.logger.new('main', 'info')
local wm = hs.webview.windowMasks

hs.loadSpoon('SpoonInstall')
spoon.SpoonInstall.use_syncinstall = trueR
Install = spoon.SpoonInstall

if hs.wasLoaded == nil then
  hs.wasLoaded = true
  table.insert(buf, 'Hammerspoon loaded.')
else
  table.insert(buf, 'Hammerspoon re-loaded. ')
end

alert.show(table.concat(buf))

--- Window filters
CURR_SPACE_WINFILTER = hs.window.filter.new():setCurrentSpace(true)
CURR_SCREEN_WINFILTER = hs.window.filter.new(function(w)
  return w:screen() == hs.screen.mainScreen()
    and CURR_SPACE_WINFILTER:isWindowAllowed(w)
end)

local function appWatcherFunction(appName, eventType, appObject)
  if eventType == hs.application.watcher.activated then
    if appName == 'Finder' then
      -- Bring all Finder windows forward when one gets activated
      appObject:selectMenuItem({ 'Window', 'Bring All to Front' })
    end
  end
end
local appWatcher = hs.application.watcher.new(appWatcherFunction)

appWatcher:start()
print('Application Watcher started.')

print('==================================================')
require('application.application')
require('amphetamine.amphetamine')
require('battery.battery')
require('brightness.brightness')
require('clipboard.clipboard')
require('corners.corners')
require('console.console')
require('health.health')
require('hotkey.hotkey')
require('ime.ime')
require('keycastr.keycastr')
require('mouse.mouse')
require('reload.reload')
require('speaker.speaker')
require('system.system')
require('teams.teams')
require('text.text')
require('timer.timer')
require('translation.translation')
require('usb.usb')
require('volume.volume')
require('window.window')
require('wifi.wifi')
