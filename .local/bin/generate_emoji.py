#!/usr/bin/env python3

import os
import sys
import requests

EMOJI_URL = "https://raw.githubusercontent.com/googlefonts/emoji-metadata/main/emoji_14_0_ordering.json"

def download_emoji(dest_filename: str):
    resp = requests.get(EMOJI_URL)

    with open(dest_filename, "w") as file:
        for entry in resp.json():
            group = entry["group"]

            if group in {"Flags"}:
                print(f"Skipping {group} category as they are not well supported")
                continue

            print(f"Processing group {group}...")

            for emoji in entry["emoji"]:

                # Skip "complex" emoji as they are not well supported by many tools (such as dmenu)
                if len(emoji["base"]) > 2:
                    continue

                emoji_raw = chr(emoji["base"][0])
                shortcodes = " ".join(emoji["shortcodes"])
                file.write(f"{emoji_raw} {shortcodes}\n")

if __name__ == "__main__":

    if len(sys.argv) > 2:
        print(f"Usage: {sys.argv[0]} [EMOJI DEST FILE]")
        sys.exit(1)

    if len(sys.argv) == 2:
        dest_filename = sys.argv[1]
    else:
        dest_filename = os.environ["HOME"] + "/.local/share/emoji"
        answer = input(f"Will save to {dest_filename}, is that ok ? [y/N] ")

        if answer.lower() != 'y':
            sys.exit(1)

    download_emoji(dest_filename)
