#!/bin/python

import os
import subprocess

disk_symbol = '\uF0A0'

df_output = subprocess.check_output(
        "df -B 1G --output=target,avail,size | awk '/^\\/[[:space:]]/'",
        shell=True
    ).decode() \
    .strip() \
    .split()

disk_avail = int(df_output[1])
disk_size = float(df_output[2])

message = f'{disk_symbol} {disk_avail} GiB'

if disk_avail <= disk_size / 100 * 5:
    print(f'<span foreground="{os.getenv('_color_urgent')}">{message}</span>')
else:
    print(message)
