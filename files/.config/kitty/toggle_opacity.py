def main(args):
    pass

from kittens.tui.handler import result_handler
@result_handler(no_ui=True)
def handle_result(args, answer, target_window_id, boss):
    window = boss.window_id_map.get(target_window_id)

    if window is None:
        return

    boss.call_remote_control(window, ('inactive_text_alpha', 1.0))
