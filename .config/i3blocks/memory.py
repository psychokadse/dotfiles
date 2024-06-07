#!/bin/python

import os
import subprocess

mem_symbol = '\U000F035B'

free_decoded = subprocess.run(['free', '-m'], capture_output=True) \
    .stdout \
    .decode() \
    .splitlines()

mem_stats_meg = free_decoded[1].split()

mem_total_gig = float(mem_stats_meg[1]) / 1000
mem_used_gig = float(mem_stats_meg[2]) / 1000
mem_available_gig = float(
    mem_stats_meg[-1]
) / 1000

message = f'{mem_symbol} {mem_used_gig:.2f} GiB/{mem_available_gig:.2f} GiB'
one_percent = mem_total_gig / 100

if mem_used_gig >= one_percent * 95:
    print(f'<span foreground="{os.getenv('_color_urgent')}">{message}</span>')
elif mem_used_gig >= one_percent * 90:
    print(f'<span foreground="{os.getenv('_color_warn')}">{message}</span>')
else:
    print(message)
