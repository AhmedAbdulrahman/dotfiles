-- luacheck: globals hs Install
local wm = hs.webview.windowMasks

Install:andUse('PopupTranslateSelection', {
  config = {
    popup_style = wm.utility | wm.HUD | wm.titled | wm.closable | wm.resizable,
  },
  hotkeys = {
    translate_to_en = { { 'cmd', 'shift', 'ctrl' }, 'z' },
  },
})
