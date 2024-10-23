#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Zk
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖

# Documentation:
# @raycast.author kha-dinh
# @raycast.authorURL https://raycast.com/kha-dinh

wezterm start -- fish -c "ZK_NOTEBOOK_DIR=$HOME/mynotes zk edit -i" &
