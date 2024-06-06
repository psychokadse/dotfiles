#!/bin/bash

_usage=$[100-$(vmstat 1 2 | tail -1 | awk '{ print $15 }')]

if [[ _usage -ge 95 ]]; then
	printf '<span foreground="%s">\UF04C5 %.2u%%</span>\n' $_color_urgent $_usage
elif [[ _usage -ge 90 ]]; then
	printf '<span foreground="%s">\UF0F85 %.2u%%</span>\n' $_color_warn $_usage
else
	printf '\UF0F86 %.2u%%\n' $_usage
fi
