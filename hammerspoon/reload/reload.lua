-- luacheck: globals hs, no unused
local function reloadConfig(paths)
  local doReload = false
  for _, file in pairs(paths) do
    if file:sub(-4) == '.lua' then
      print('A lua config file changed, reload')
      doReload = true
    end
  end
  if not doReload then
    print('No lua file changed, skipping reload')
    return
  end

  hs.reload()
end

local configFileWatcher =
  hs.pathwatcher.new(os.getenv('HOME') .. '/.hammerspoon/', reloadConfig)
configFileWatcher:start()
