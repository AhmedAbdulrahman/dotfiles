-- ultra bindings
local ultra = { 'ctrl', 'alt', 'cmd' }

local utils        = require('utils')
local template          = require('template')


function isDarkModeEnabled()
  local _, res = hs.osascript.javascript([[
    Application("System Events").appearancePreferences.darkMode()
  ]])

  return res
end

function setTheme(theme)
  hs.osascript.javascript(template([[
    var systemEvents = Application("System Events");
    var alfredApp = Application("Alfred 5");

    ObjC.import("stdlib");

    systemEvents.appearancePreferences.darkMode = {DARK_MODE};

    // has to be done this way so template function works, lol
    alfredApp && alfredApp.setTheme("{ALFRED_THEME}");
  ]], {
    ALFRED_THEME = 'Mojave ' .. utils.capitalize(theme),
    DARK_MODE = theme == 'dark' and 'true' or 'false',
  }))
end

function toggleTheme()
  setTheme(isDarkModeEnabled() and 'light' or 'dark')
end

function isDNDEnabled()
    local _, _, _, rc = hs.execute('do-not-disturb status | grep -q "on"', true)
    return rc == 0
end

function toggleDND()
    local imagePath = os.getenv('HOME') .. '/.hammerspoon/assets/notification-center.png'

    local isEnabled = isDNDEnabled()
    local afterTime = isEnabled and 0.0 or 6.0

    -- is not enabled, will be enabled
    if not isEnabled then
      hs.notify.new({
        title        = 'Do Not Disturb',
        subTitle     = 'Enabled',
        contentImage = imagePath
      }):send()
    end

    -- toggle, wait a bit if we've send notification
    hs.timer.doAfter(afterTime, function()
      hs.execute('do-not-disturb ' .. (isEnabled == true and 'off' or 'on'), true)

      -- is enabled, was disabled
      if isEnabled then
        hs.notify.new({
          title        = 'Do Not Disturb',
          subTitle     = 'Disabled',
          contentImage = imagePath
        }):send()
      end
    end)
end

function toggleWiFi()
    local newStatus = not hs.wifi.interfaceDetails().power

    hs.wifi.setPower(newStatus)

    local imagePath = os.getenv('HOME') .. '/.hammerspoon/assets/airport.png'

    hs.notify.new({
      title        = 'Wi-Fi',
      subTitle     = 'Power: ' .. (newStatus and 'On' or 'Off'),
      contentImage = imagePath
    }):send()
end

function displaySleep()
    hs.task.new('/usr/bin/pmset', nil, { 'displaysleepnow' }):start()
end

  -- toggles
hs.fnutils.each({
  { key = 't', fn = toggleTheme     },
  { key = 'd', fn = toggleDND       },
  { key = 'w', fn = toggleWiFi      },
  { key = 'q', fn = displaySleep    },
}, function(object)
    hs.hotkey.bind(ultra, object.key, object.fn)
end)
