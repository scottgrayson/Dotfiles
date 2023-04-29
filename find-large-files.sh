#!/bin/sh
# du -h / | grep -E '^[0-9 .]+[GTP]\t'
du -sk * | awk '$1 > 10485760 { print $2 }'
