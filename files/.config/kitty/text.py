import subprocess
import sys
import os

# Expand the tilde to the full path
GET_WEATHER_SCRIPT = [os.path.expanduser('~/.config/zsh/bin/weather_current')]

def get_prayer_from_script():
    """Call the next-prayer binary and return its output."""
    try:
        result = subprocess.run(
            GET_WEATHER_SCRIPT,  # Pass as a list
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True,
            check=True,
        )
        output = result.stdout.strip()
        output = output.replace("%", "")
        output = output.replace("format=", "")
        return output
    except Exception as e:
        print(f"Error fetching prayer time: {e}", file=sys.stderr)
        return "N/A"

print(get_prayer_from_script())
