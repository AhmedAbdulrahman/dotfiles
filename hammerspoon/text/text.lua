--Copycat: https://github.com/babarrett/hammerspoon/blob/master/editSelection.lua

-- getTextSelection()
-- 	Gets currently selected text using Cmd+C
--	Saves and restores the current pasteboard
--	Imperfect, perhaps. May not work well on large selections.
--	Taken from: https://github.com/Hammerspoon/hammerspoon/issues/634
function getTextSelection()	-- returns text or nil while leaving pasteboard undisturbed.
    local oldText = hs.pasteboard.getContents()
    hs.eventtap.keyStroke({"cmd"}, "c")
    hs.timer.usleep(25000)
    local text = hs.pasteboard.getContents()	-- if nothing is selected this is unchanged
    hs.pasteboard.setContents(oldText)
    if text ~= oldText then
        return text
    else
        return ""
    end
end

function toUppercase()
    sel = getTextSelection()
    if sel then hs.eventtap.keyStrokes(string.upper(sel)) end
end

function toLowercase()
    sel = getTextSelection()
    if sel then hs.eventtap.keystrokes(string.lower(sel)) end
end

hs.hotkey.bind({"cmd", "shift", "ctrl"}, "u", toUppercase)
hs.hotkey.bind({"cmd", "shift", "ctrl"}, "i", toLowercase)
