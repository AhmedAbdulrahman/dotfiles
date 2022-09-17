---init
alert = require('hs.alert')
buf = {}
log = hs.logger.new('main', 'info')
wm = hs.webview.windowMasks

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

print('==================================================')
require('application.application')
require('battery.battery')
require('brightness.brightness')
require('clipboard.clipboard')
require('corners.corners')
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
