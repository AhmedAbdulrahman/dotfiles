-- A global variable for the Hyper Mode
k = hs.hotkey.modal.new({}, "F17")

-- HYPER+L: Open news.google.com in the default browser
lfun = function()
  news = "app = Application.currentApplication(); app.includeStandardAdditions = true; app.doShellScript('open http://news.google.com')"
  hs.osascript.javascript(news)
  k.triggered = true
end
k:bind('', 'n', nil, lfun)

local focusKeys = {
  S='Slack',
  s='Sketch',
  c='Google Chrome',
  shift='iTerm',
  e='Simulator',
  m='Spark',
  d='Discord',
  f='Finder',
  m='Spark',
}

for key in pairs(focusKeys) do
  k:bind('', key, function()
    hs.application.launchOrFocus(focusKeys[key])
  end)
end

k:bind('', "r", function()
  hs.reload()
end)

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