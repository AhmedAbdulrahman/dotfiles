-- A global variable for the Hyper Mode
k = hs.hotkey.modal.new({}, "F17")

-- HYPER+L: Open news.google.com in the default browser
-- lfun = function()
--   news = "app = Application.currentApplication(); app.includeStandardAdditions = true; app.doShellScript('open http://news.google.com')"
--   hs.osascript.javascript(news)
--   k.triggered = true
-- end
-- k:bind('', 'l', nil, lfun)

k:bind('', 'space', function() hs.application.launchOrFocus("iTerm") end)
k:bind('', 't', function() hs.application.launchOrFocus("iTerm") end)
k:bind('', 's', function() hs.application.launchOrFocus("Slack") end)
k:bind('', 'w', function() hs.application.launchOrFocus("Google Chrome") end)
k:bind('shift', 'w', function() hs.application.launchOrFocus("FirefoxDeveloperEdition") end)
k:bind('', 'd', function() hs.application.launchOrFocus("Discord") end)
k:bind('', 'f', function() hs.application.launchOrFocus("Finder") end)
k:bind('', '1', function() hs.application.launchOrFocus("Sketch") end)
k:bind('', '2', function() hs.application.launchOrFocus("Preview") end)

-- require('keyboard')
-- require('watcher')
-- require('position')

-- Enter Hyper Mode when F18 (Hyper/Capslock) is pressed
pressedF18 = function()
  k.triggered = false
  k:enter()
end

-- Leave Hyper Mode when F18 (Hyper/Capslock) is pressed,
--   send ESCAPE if no other keys are pressed.
releasedF18 = function()
  k:exit()
  if not k.triggered then
    hs.eventtap.keyStroke({}, 'ESCAPE')
  end
end

-- Bind the Hyper key
f18 = hs.hotkey.bind({}, 'F18', pressedF18, releasedF18)