-- luacheck: globals hs

local function English()
  hs.keycodes.currentSourceID('com.apple.keylayout.ABC')
end

-- app to expected ime config
local app2Ime = {
  { '/Applications/Kitty.app', 'English' },
  { '/Applications/Xcode.app', 'English' },
  { '/Applications/Google Chrome.app', 'English' },
  { '/Applications/System Preferences.app', 'English' },
}

local function updateFocusAppInputMethod()
  local focusAppPath = hs.window.frontmostWindow():application():path()
  for _, app in pairs(app2Ime) do
    local appPath = app[1]
    local expectedIme = app[2]

    if focusAppPath == appPath then
      if expectedIme == 'English' then
        English()
      end
      break
    end
  end
end

-- helper hotkey to figure out the app path and name of current focused window
hs.hotkey.bind({ 'ctrl', 'cmd' }, '.', function()
  hs.alert.show(
    'App path:        '
      .. hs.window.focusedWindow():application():path()
      .. '\n'
      .. 'App name:      '
      .. hs.window.focusedWindow():application():name()
      .. '\n'
      .. 'IM source id:  '
      .. hs.keycodes.currentSourceID()
  )
end)

-- Handle cursor focus and application's screen manage.
local function applicationWatcher(_, eventType, _)
  if eventType == hs.application.watcher.activated then
    updateFocusAppInputMethod()
  end
end

local appWatcher = hs.application.watcher.new(applicationWatcher)
appWatcher:start()
