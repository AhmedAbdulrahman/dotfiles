KEYSTROKE_DURATION = 1 -- A one-microsecond delay worked for me YMMV
PUSH_TO_TALK_KEY = "space"

-- Microsoft Teams Push-to-Talk
function toggleMute()
    teamsApps = hs.application.applicationsForBundleID('com.microsoft.teams')
    teamsApp = teamsApps[1]
    teamsApp:activate()
    hs.eventtap.keyStroke({"shift", "cmd"}, "m", KEYSTROKE_DURATION)
end

hs.hotkey.bind({"cmd", "shift", "ctrl"}, PUSH_TO_TALK_KEY, toggleMute)
