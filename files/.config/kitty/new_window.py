from typing import List
from kitty.boss import Boss

def main(args: List[str]) -> str:
    # this is the main entry point of the kitten, it will be executed in
    # the overlay window when the kitten is launched
    name = input('New OS Window: ')
    # whatever this function returns will be available in the
    # handle_result() function
    return name

def handle_result(args: List[str], name: str, target_window_id: int, boss: Boss) -> None:
    window = boss.window_id_map.get(target_window_id)

    if window is not None:
        boss.call_remote_control(window, ('action', f'new_os_window'))
        boss.call_remote_control(window, ('send-text', 'j ' + name + '\r'))
        boss.call_remote_control(window, ('action', f'set_tab_title', name))
        boss.call_remote_control(window, ('launch', f'--location=hsplit', '--cwd=current'))
        boss.call_remote_control(window, ('send-text', 'j ' + name + '\r'))
        boss.call_remote_control(window, ('launch', f'--location=vsplit', '--cwd=current'))
        boss.call_remote_control(window, ('send-text', 'j ' + name + '\r'))
        boss.call_remote_control(window, ('action', f'previous_window'))
        boss.call_remote_control(window, ('action', f'previous_window'))
        boss.call_remote_control(window, ('action', f'resize_window taller 20'))
