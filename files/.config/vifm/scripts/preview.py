#!/usr/bin/env python

import argparse
import os

DEFAULT_LIMIT = 1000000       # 1Mb
CACHE_DIR = '/tmp/preview_cache'

#  Private functions {{{ #
# Based on this commend:
# https://github.com/tmux/tmux/issues/1502#issuecomment-429710887
# Tmux has some limitation in image preview. I created an issue in vifm:
# https://github.com/vifm/vifm/issues/428
# imgcat worked for me but only for small image and only one time. So I decided
# to disable image preview in tmux. May be it could be fixed in the future.
def _check_tmux():
    if "TMUX" in os.environ:
        print("\nTMUX doesn't support image preview!\n")
        return True
    return False

def _get_preview_filename(f):
    abs_path = os.path.abspath(f)
    filename = abs_path.replace(os.sep, "_")
    return os.path.join(args.cache_dir, filename + '.png')

def _preview_grafical_image(args):
    preview_bin = "imgcat"
    size_params = ""
    if args.width != None and args.height != None:
        size_params = '--width {0} --height {1}'.format(args.width, args.height)
    return '{0} {1} "{2}" > /dev/tty'.format(preview_bin, size_params, args.file)

def _preview_text_image_info(args):
    return 'exiv2 "{0}"'.format(args.file)

def _preview_grafical_pdf(args):
    image_path = _get_preview_filename(args.file)

    if not os.path.exists(image_path):
        cmd = 'pdftoppm -png -singlefile "{0}" "{1}"'.format(args.file, os.path.splitext(image_path)[0])
        os.system(cmd)
    args.file = image_path
    return _preview_grafical_image(args)

def _preview_text_pdf(args):
    return 'pdftotext -nopgbrk "{0}" -'.format(args.file)

def _preview_grafical_video(args):
    image_path = _get_preview_filename(args.file)

    if not os.path.exists(image_path):
        cmd = 'ffmpegthumbnailer -i "{0}" -o "{1}" -s 0'.format(args.file, image_path)
        os.system(cmd)
    args.file = image_path
    return _preview_grafical_image(args)

def _preview_text_video(args):
    return 'ffprobe -pretty "{0}" 2>&1'.format(args.file)
#  }}} Private functions #
#  Public functions {{{ #
def preview_image(args):
    in_tmux = _check_tmux()
    cmd = ""
    img_size = os.path.getsize(args.file)

    if img_size <= args.max_size and in_tmux is False:
        cmd = _preview_grafical_image(args)
    else:
        cmd = _preview_text_image_info(args)
    os.system(cmd)

def preview_pdf(args):
    in_tmux = _check_tmux()
    cmd = ""
    if in_tmux is False:
        cmd = _preview_grafical_pdf(args)
    else:
        cmd = _preview_text_pdf(args)
    os.system(cmd)

def preview_video(args):
    in_tmux = _check_tmux()
    cmd = ""
    if in_tmux is False:
        cmd = _preview_grafical_video(args)
    else:
        cmd = _preview_text_video(args)
    os.system(cmd)
#  }}} Public functions #

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description="Script for preview files")
    parser.add_argument('file', type=str, help="Path to image file")
    parser.add_argument('--width', type=str, help="Width of preview image")
    parser.add_argument('--height', type=str, help="Height of preview image")
    parser.add_argument('--max_size', type=int, default=DEFAULT_LIMIT,
            help="Won't show preview for images more when this size (Default: {0} bytes)".format(DEFAULT_LIMIT))
    parser.add_argument('--type', type=str, default="image",
            help="Type of file to preview. Possible values: 'image' - for images, 'pdf' - for pdf docs, 'video' - for videos.")
    parser.add_argument('--cache_dir', type=str, default=CACHE_DIR,
            help="Path to cache dir (Default: {0})".format(CACHE_DIR))

    args = parser.parse_args()

    if not os.path.exists(args.cache_dir):
        os.makedirs(args.cache_dir)

    if args.type == 'pdf':
        preview_pdf(args)
    elif args.type == 'video':
        preview_video(args)
    else:
        preview_image(args)

# vim: foldmethod=marker:foldlevel=0