#!/usr/bin/env bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Improve Grammar
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.icon 👨‍🏫
# @raycast.packageName GPT Scripts
# @raycast.argument1 { "type": "text", "placeholder": "なんとか", "optional": true }

set -e

# Load Ruby
eval "$(rbenv init -)"
# Load API keys
source ~/icloud-drive/dotfiles/.env

clipboard="$(pbpaste)"
input="${1:-clipboard}"
../script/transform_text --prompt "できれば、文法を改善してください。出来ない場合は変えなくて繰り返してくれ" <<< "${1-}"
