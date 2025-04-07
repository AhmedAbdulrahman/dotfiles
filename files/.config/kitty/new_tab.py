def main(_args):
    location_and_maybe_name = input('New tab: ')

    return location_and_maybe_name

def handle_result(args, location_and_maybe_name, target_window_id, boss):
    num_windows = int(args[1])
    pieces = location_and_maybe_name.split(':')
    location = pieces[0]

    if len(pieces) > 1:
        title = pieces[1]
    else:
        title = location

    window = boss.window_id_map.get(target_window_id)

    if window is not None:
        boss.call_remote_control(window, ('action', 'new_tab'))
        boss.call_remote_control(window, ('action', 'set_tab_title', title))
        _set_win(boss, window, location)

        if num_windows > 1:
            boss.call_remote_control(window, ('launch', '--type=window', '--location=hsplit'))
            _set_win(boss, window, location)

            if num_windows > 2:
                boss.call_remote_control(window, ('launch', '--type=window', '--location=vsplit'))
                _set_win(boss, window, location)
                boss.call_remote_control(window, ('action', 'previous_window'))

            boss.call_remote_control(window, ('action', 'previous_window'))
            boss.call_remote_control(window, ('action', 'resize_window taller 20'))
            boss.call_remote_control(window, ('send-text', 'e\n'))

def _set_win(boss, window, location):
    if location != "":
        boss.call_remote_control(window, ('send-text', f'j {location}\n'))
