#!/usr/bin/env bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Improve Grammar
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 👨‍🏫
# @raycast.packageName GPT Scripts
# @raycast.argument1 { "type": "text", "placeholder": "なんとか" }

set -e

transform_text --prompt "できれば、文法を改善してください。出来ない場合は変えなくて繰り返してくれ" <<< "$1"
