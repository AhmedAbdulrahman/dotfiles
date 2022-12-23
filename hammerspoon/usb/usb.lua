-- luacheck: globals hs, no unused
local function usbDeviceCallback(data)
  print('usbDeviceCallback: ' .. hs.inspect(data))
end

local usbWatcher = hs.usb.watcher.new(usbDeviceCallback)
usbWatcher:start()
