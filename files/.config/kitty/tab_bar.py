import subprocess
import sys
import asyncio
import time
from os import getlogin, uname, path
from pathlib import Path
from kitty.boss import get_boss
from kitty.fast_data_types import Screen, get_options
from kitty.utils import color_as_int
from kitty.tab_bar import (
    DrawData,
    ExtraData,
    Formatter,
    TabBarData,
    as_rgb,
    draw_attributed_string,
    draw_title,
)
# import urllib3
# urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)


opts = get_options()  # --------------------------------------------⮯
# --------------------------------------------------------------\
# black  |  red     green    blue     magenta  cyan     white   | color
# color0 |  color1  color2   color4   color5   color6   color7  | normal
# color8 |  color9  color10  color12  color13  color14  color15 | bright
# --------------------------------------------------------------/
if opts.tab_bar_background is None:
    tab_background = 0
else:
    tab_background = opts.tab_bar_background
GET_WEATHER_SCRIPT = [path.expanduser('~/.config/zsh/bin/weather_current')]
GET_PRAYER_SCRIPT = ["/usr/local/bin/next-prayer", "aladhan"]

# Cache and refresh intervals
weather_cache = {"data": None, "last_updated": 0}
prayer_cache = {"data": None, "last_updated": 0}
CACHE_REFRESH_INTERVAL = 600  # 10 minutes


FG = as_rgb(color_as_int(opts.background))
BG = as_rgb(color_as_int(opts.color4))
ACCENT = as_rgb(color_as_int(opts.selection_background))
BAR_BG = as_rgb(color_as_int(tab_background))
ACTIVE_BG = as_rgb(color_as_int(opts.active_tab_background))
SEPARATOR_SYMBOL, SOFT_SEPARATOR_SYMBOL = ("", "")
SEPARATOR_SYMBOL_RIGHT = ""
TRUNCATION_SYMBOL = " ⽙"
ICON, ICON_HOST, ICON_USER, = (
    "   ",
    " ⾥ ",
    "⼈",
)
RIGHT_MARGIN = 1
REFRESH_TIME = 1
right_status_length = -10

async def fetch_weather():
    """Fetch weather data asynchronously."""
    try:
        process = await asyncio.create_subprocess_exec(
            *GET_WEATHER_SCRIPT,
            stdout=asyncio.subprocess.PIPE,
            stderr=asyncio.subprocess.PIPE,
        )
        stdout, _ = await process.communicate()
        return stdout.decode().strip().replace("%", "").replace("format=", "")
    except Exception as e:
        return "N/A"
async def fetch_prayer():
    """Fetch prayer data asynchronously."""
    try:
        process = await asyncio.create_subprocess_exec(
            *GET_PRAYER_SCRIPT,
            stdout=asyncio.subprocess.PIPE,
            stderr=asyncio.subprocess.PIPE,
        )
        stdout, _ = await process.communicate()
        return stdout.decode().strip()
    except Exception as e:
        return "N/A"

async def get_weather():
    """Get weather data with caching."""
    current_time = time.time()
    if weather_cache["data"] is None or current_time - weather_cache["last_updated"] > CACHE_REFRESH_INTERVAL:
        weather_cache["data"] = await fetch_weather()
        weather_cache["last_updated"] = current_time
    return weather_cache["data"]

async def get_prayer():
    """Get prayer data with caching."""
    current_time = time.time()
    if prayer_cache["data"] is None or current_time - prayer_cache["last_updated"] > CACHE_REFRESH_INTERVAL:
        prayer_cache["data"] = await fetch_prayer()
        prayer_cache["last_updated"] = current_time
    return prayer_cache["data"]

def _draw_icon(screen: Screen, index: int) -> int:
    if index != 1:
        return 0
    fg, bg = screen.cursor.fg, screen.cursor.bg
    screen.cursor.fg, screen.cursor.bg = FG, BG
    screen.draw(ICON)
    screen.cursor.fg, screen.cursor.bg = BG, bg
    screen.draw(SEPARATOR_SYMBOL)
    screen.cursor.fg, screen.cursor.bg = fg, bg
    screen.cursor.x = len(ICON + SEPARATOR_SYMBOL)
    return screen.cursor.x


def get_cwd():
    cwd = ""
    tab_manager = get_boss().active_tab_manager
    if tab_manager is not None:
        window = tab_manager.active_window
        if window is not None:
            cwd = window.cwd_of_child

    cwd_parts = list(Path(cwd).parts)
    if len(cwd_parts) > 1:
        if cwd_parts[1] == "home":
            cwd_parts[0] = " ⾕"
            cwd_parts[1:3] = []
        else:
            cwd_parts[0] = "  "  # root descended
    else:
        cwd_parts[0] = "  "  # root base

    if len("/".join(cwd_parts)) < 15:
        cwd = cwd_parts[0] + "/".join(cwd_parts[1:])
    else:
        cwd = TRUNCATION_SYMBOL + cwd_parts[-1]

    return cwd


def _draw_cwd(screen: Screen, index: int) -> int:
    if index != 1:
        return 0
    fg, bg = screen.cursor.fg, screen.cursor.bg
    screen.cursor.fg, screen.cursor.bg = BG, ACTIVE_BG
    cwd = get_cwd()
    screen.draw(cwd)
    screen.cursor.fg, screen.cursor.bg = ACTIVE_BG, BAR_BG
    screen.draw(SEPARATOR_SYMBOL)
    screen.draw("⽡")
    screen.cursor.fg, screen.cursor.bg = fg, bg
    screen.cursor.x = len(cwd) + 9
    return screen.cursor.x


def _draw_left_status(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    index: int,
    extra_data: ExtraData,
) -> int:
    if screen.cursor.x >= screen.columns - right_status_length:
        return screen.cursor.x
    tab_bg, tab_fg = screen.cursor.bg, screen.cursor.fg
    if index == 1:
        screen.cursor.fg, screen.cursor.bg = tab_bg, BAR_BG
        screen.draw(SEPARATOR_SYMBOL_RIGHT)
        screen.cursor.bg = tab_bg
    default_bg = as_rgb(int(draw_data.default_bg))
    if extra_data.next_tab:
        next_tab_bg = as_rgb(draw_data.tab_bg(extra_data.next_tab))
        needs_soft_separator = next_tab_bg == tab_bg
    else:
        next_tab_bg = default_bg
        needs_soft_separator = False
    if screen.cursor.x <= len(ICON):
        screen.cursor.x = len(ICON)
    screen.draw(" ")
    screen.cursor.bg = tab_bg
    draw_title(draw_data, screen, tab, index)
    if not needs_soft_separator:
        screen.draw(" ")
        screen.cursor.fg = tab_bg
        screen.cursor.bg = next_tab_bg
        screen.draw(SEPARATOR_SYMBOL)
    else:
        prev_fg = screen.cursor.fg
        if tab_bg == tab_fg:
            screen.cursor.fg = default_bg
        elif tab_bg != default_bg:
            c1 = draw_data.inactive_bg.contrast(draw_data.default_bg)
            c2 = draw_data.inactive_bg.contrast(draw_data.inactive_fg)
            if c1 < c2:
                screen.cursor.fg = default_bg
        screen.draw(" " + SOFT_SEPARATOR_SYMBOL)
        screen.cursor.fg = prev_fg
    end = screen.cursor.x
    return end


def _draw_right_status(screen: Screen, is_last: bool, cells: list) -> int:
    if not is_last:
        screen.cursor.bg = FG
        return screen.cursor.x
    draw_attributed_string(Formatter.reset, screen)
    screen.cursor.x = screen.columns - 55
    # screen.cursor.x = screen.columns - 55
    screen.cursor.fg = 0
    screen.cursor.bg = 0
    for color_fg, color_bg, status in cells:
        screen.cursor.fg = color_fg
        screen.cursor.bg = color_bg
        screen.draw(status)
    return screen.cursor.x


def draw_tab(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,  # Not accessed, but things break without it?
    max_title_length: int,  # Not accessed, but things break without it?
    index: int,
    is_last: bool,
    extra_data: ExtraData,
) -> int:
    global right_status_length
    app = ICON_USER + getlogin() + " " + SEPARATOR_SYMBOL_RIGHT
    host = 'Panda' + ICON_HOST
    # host = uname()[1] + ICON_HOST
    # github_status = get_github_status()  # Fetch GitHub status
    weather = asyncio.run(get_weather())
    prayer = asyncio.run(get_prayer())
    cells = []
    cells = [
        (ACTIVE_BG, BAR_BG, SEPARATOR_SYMBOL_RIGHT),
        (BG, ACTIVE_BG, app),
        (FG, BG, host),
        (FG, BG, prayer),
        (FG, BG, weather),
    ]
    right_status_length = RIGHT_MARGIN + 2
    for cell in cells:
        right_status_length += len(str(cell[1]))

    _draw_icon(screen, index)
    _draw_cwd(screen, index)
    _draw_left_status(
        draw_data,
        screen,
        tab,
        index,
        extra_data,
    )
    _draw_right_status(
        screen,
        is_last,
        cells,
    )
    return screen.cursor.x
