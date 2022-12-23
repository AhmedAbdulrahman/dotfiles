-- luacheck: globals hs, no unused
local speaker = hs.speech.new()
speaker:speak('Hammerspoon is online')
hs.notify
  .new({ title = 'Hammerspoon launch', informativeText = 'Boss, at your service' })
  :send()
