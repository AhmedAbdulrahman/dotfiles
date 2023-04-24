-- luacheck: globals hs, no unused

local utils = require('utils')
local template = require('template')

local iconAscii = 'ASCII:'
  .. '. . . . . . . . . . . . . . . . . . . . .\n'
  .. '. . . . . . . . . . . . . . . . . . . . .\n'
  .. '. . . . . . . . . . . . . . . . . . . . .\n'
  .. '. . . 1 # # # # # # # # # # # # # 1 . . .\n'
  .. '. . . 4 . . . . . . . . . . . . . 2 . . .\n'
  .. '. . . # 5 = = = = = = = = = = = 5 # . . .\n'
  .. '. . . # . . . . . . . . . . . . . # . . .\n'
  .. '. . . # 6 = = = = = = = = = = = 6 # . . .\n'
  .. '. . . # . . . . . . . . . . . . . # . . .\n'
  .. '. . . # 7 = = = = = = = = = = = 7 # . . .\n'
  .. '. . . # . . . . . . . . . . . . . # . . .\n'
  .. '. . . # 8 = = = = = = = = = = = 8 # . . .\n'
  .. '. . . # . . . . . . . . . . . . . # . . .\n'
  .. '. . . # 9 = = = = = = = = = = = 9 # . . .\n'
  .. '. . . # . . . . . . . . . . . . . # . . .\n'
  .. '. . . # a = = = = = = = = = = = a # . . .\n'
  .. '. . . 4 . . . . . . . . . . . . . # . . .\n'
  .. '. . . 3 # # # # # # # # # # # # 3 2 . . .\n'
  .. '. . . . . . . . . . . . . . . . . . . . .\n'
  .. '. . . . . . . . . . . . . . . . . . . . .\n'
  .. '. . . . . . . . . . . . . . . . . . . . .'

--  ╭──────────────────────────────────────────────────────────╮
--  │ Dark Mode                                                │
--  ╰──────────────────────────────────────────────────────────╯

local function darkModeStatus()
  -- return the status of Dark Mode
  local _, darkModeState = hs.osascript.javascript(
    'Application("System Events").appearancePreferences.darkMode()'
  )
  return darkModeState
end

local function setDarkMode(state)
  -- Function for setting Dark Mode on/off.
  -- Argument should be either 'true' or 'false'.
  return hs.osascript.javascript(
    string.format(
      "Application('System Events').appearancePreferences.darkMode.set(%s)",
      state
    )
  )
end

local function toggleDarkMode()
  -- Toggle Dark Mode status
  if darkModeStatus() then
    setDarkMode(false)
  else
    setDarkMode(true)
  end
end

local darkmode = hs.menubar.new()
-- Toggle dark mode from menu bar
local function systemSetDm(state)
  return hs.osascript.javascript(
    string.format(
      "Application('System Events').appearancePreferences.darkMode.set(%s)",
      state
    )
  )
end

local function dmIsOn()
  local _, darkModeState = hs.osascript.javascript(
    'Application("System Events").appearancePreferences.darkMode()'
  )
  return darkModeState
end

local function setDm(state)
  systemSetDm(state)
  if state then
    darkmode:setTitle('☾')
  else
    darkmode:setTitle('☀')
  end
end

local function darkmodeClicked()
  setDm(not dmIsOn())
end

if darkmode then
  darkmode:setClickCallback(darkmodeClicked)
  setDm(dmIsOn())
end

--  ╭──────────────────────────────────────────────────────────╮
--  │ Wifi                                                     │
--  ╰──────────────────────────────────────────────────────────╯

local function toggleWiFi()
  if hs.network.interfaceDetails() == nil then
    hs.wifi.setPower(true)
  else
    hs.wifi.setPower(false)
  end
end

--  ╭──────────────────────────────────────────────────────────╮
--  │ Notification Center                                      │
--  ╰──────────────────────────────────────────────────────────╯

local function isDNDEnabled()
  return hs.execute('~/bin/do-not-disturb status'):gsub('\n$', '')
end

local function toggleDND()
  local imagePath = os.getenv('HOME')
    .. '/.hammerspoon/assets/notification-center.png'
  local isEnabled = isDNDEnabled()
  local afterTime = isEnabled and 0.0 or 6.0

  -- is not enabled, will be enabled
  if isEnabled == 'off' then
    hs.notify
      .new({
        title = 'Do Not Disturb',
        subTitle = 'Enabled',
        contentImage = imagePath,
      })
      :send()
  end

  -- toggle, wait a bit if we've send notification
  hs.timer.doAfter(afterTime, function()
    hs.execute(
      '~/bin/do-not-disturb ' .. (isEnabled == 'off' and 'on' or 'off')
    )
    print('~/bin/do-not-disturb ' .. (isEnabled == 'off' and 'on' or 'off'))

    -- is enabled, was disabled
    if isEnabled == 'on' then
      hs.notify
        .new({
          title = 'Do Not Disturb',
          subTitle = 'Disabled',
          contentImage = imagePath,
        })
        :send()
    end
  end)

  print(isEnabled)
end

local watcherMenu = hs.menubar.new()
watcherMenu:setIcon(utils.iconFromASCII(iconAscii))

local function watcherMenuItem()
  local menuTable = {
    { title = 'Toggle WiFi', fn = toggleWiFi },
    { title = 'Toggle DND', fn = toggleDND },
  }
  watcherMenu:setMenu(menuTable)
end

watcherMenuItem()
