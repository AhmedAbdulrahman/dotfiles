local modalKey = {'alt'}
local apps = {
  -- [g]oogle chrome
  g='Google Chrome',
  -- [b]rowser
  b='Firefox Developer Edition',
  -- [d]iscord
  d='Discord',
  -- S[a]fari
  a='Safari',
  -- [s]lack
  s='Slack',
  -- [t]erminal
  t='iTerm',
  -- [t]p = "Spotify",
  p="Spotify",
  -- [f]finder
  f="Finder",
  -- i[m]essage
  m='Messages',
}

for key in pairs(apps) do
  hs.hotkey.bind(modalKey, key, function()
    modalKey.triggered = true
    hs.application.launchOrFocus(apps[key])
  end)
end

hs.hotkey.bind({}, 'f10', hs.openConsole)

hs.hotkey.bind(modalKey, 'r', function()
  hs.reload()
end)
