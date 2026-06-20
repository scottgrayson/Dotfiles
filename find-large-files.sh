#!/bin/sh
# Usage: find-large-files.sh [DIR]
# Find directories/files larger than 10GB under DIR (default: current directory).
# Example: find-large-files.sh ~
#
# Alternative (scan whole filesystem): du -h / | grep -E '^[0-9 .]+[GTP]\t'
dir="${1:-.}"
resolved=$(cd "$dir" && pwd)
echo "Directories/files over 10GB under $resolved:"
echo ""
(cd "$dir" && du -sk * 2>/dev/null) | sort -rn | awk -v dir="$resolved" '
  $1 > 10485760 {
    size = $1
    name = $2
    if (size >= 1048576)      h = sprintf("%.1fG", size/1048576)
    else if (size >= 1024)    h = sprintf("%.1fM", size/1024)
    else                      h = sprintf("%.0fK", size)
    printf "%8s  %s/%s\n", h, dir, name
  }
'
