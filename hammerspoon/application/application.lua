-- luacheck: globals hs mousepoint, no unused
local utils = require('utils')

-- creates callback function to select application windows by application name
local function mkFocusByPreferredApplicationTitle(stopOnFirst, ...)
  local arguments = { ... } -- create table to close over variadic args
  return function()
    local nowFocused = hs.window.focusedWindow()
    local appFound = false
    for _, app in ipairs(arguments) do
      if stopOnFirst and appFound then
        break
      end
      log:d('Searching for app ', app)
      local application = hs.application.get(app)
      if application ~= nil then
        log:d('Found app', application)
        local window = application:mainWindow()
        if window ~= nil then
          log:d('Found main window', window)
          if window == nowFocused then
            log:d('Already focused, moving on', application)
          else
            window:focus()
            appFound = true
          end
        end
      end
    end
    return appFound
  end
end

local function appActivation(application)
  hs.application.launchOrFocus(application)
  hs.application.enableSpotlightForNameSearches(true)
  local app = hs.appfinder.appFromName(application)
  if app then
    app:activate()
    app:unhide()
  end
end

-- focus applications
local function focusOrOpen(app)
  local focus = mkFocusByPreferredApplicationTitle(true, app)
  return (focus() or appActivation(app))
end

-- launch applications
local function hyperFocusOrOpen(key, app)
  hs.hotkey.bind({ 'ctrl' }, key, function()
    focusOrOpen(app)
  end)
end

local applicationHotkeys = {
  -- [a]ctivity monitor
  a = 'Activity monitor',
  -- [g]oogle chrome
  g = 'Google Chrome',
  -- -- Visual Studio [c]ode
  -- c = 'Visual Studio Code',
  -- [k]itty
  k = 'Kitty',
  -- [d]iscord
  d = 'Discord',
  -- [m]icrosoft teams
  t = 'Microsoft Teams',
  -- [p]ostman
  p = 'Postman',
  -- [i]nsomnia
  i = 'Insomnia',
  -- [h]ammerspoon
  -- h = 'Hammerspoon',
  -- [s]slack
  s = 'Slack',
}

for key, app in pairs(applicationHotkeys) do
  hyperFocusOrOpen(tostring(key), app)
end

-- Remapped browser hotkeys (for both Brave and Google Chrome).
local browserHotkeys = {
  -- Assign [cmd + 1] to toggle the developer tools.
  hs.hotkey.new('cmd', 'd', function()
    hs.eventtap.keyStroke('alt+cmd', 'i', 0)
  end),
  -- Assign [cmd + 4] to toggle full screen mode.
  hs.hotkey.new('cmd', '4', function()
    hs.eventtap.keyStroke('cmd+ctrl', 'f', 0)
  end),
}

local function enableBrowserHotkeys()
  for _, hotkey in ipairs(browserHotkeys) do
    hotkey:enable()
  end
end

local function disableBrowserHotkeys()
  for _, hotkey in ipairs(browserHotkeys) do
    hotkey:disable()
  end
end

local browserWindowFilter =
  hs.window.filter.new({ 'Brave Browser', 'Google Chrome' })
browserWindowFilter:subscribe(
  hs.window.filter.windowFocused,
  enableBrowserHotkeys
)
browserWindowFilter:subscribe(
  hs.window.filter.windowUnfocused,
  disableBrowserHotkeys
)

if
  hs.window.focusedWindow()
  and (
    hs.window.focusedWindow():application():name() == 'Brave Browser'
    or hs.window.focusedWindow():application():name() == 'Google Chrome'
  )
then
  -- If this script is initialized with a Brave or Google window already in
  -- focus, enable the hotkeys.
  enableBrowserHotkeys()
end

--- reload Hammerspoon config
hs.hotkey.bind({ 'cmd', 'shift', 'ctrl' }, 'r', function()
  hs.reload()
end)

utils.notify('Config loaded.')
