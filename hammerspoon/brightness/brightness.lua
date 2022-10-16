-- luacheck: globals hs

local function changeBrightness(diff)
  return function()
    local current = hs.brightness.get()
    local new = math.min(100, math.max(0, math.floor(current + diff)))
    hs.alert.closeAll(0.0)
    hs.alert.show('Brightness ' .. new .. '%', {}, 0.5)
    hs.brightness.set(new)
  end
end

hs.hotkey.bind({ 'cmd' }, 'Left', changeBrightness(-3))
hs.hotkey.bind({ 'cmd' }, 'Right', changeBrightness(3))
