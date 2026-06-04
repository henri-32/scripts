#!/bin/bash 
set -euo pipefail 

tmux new -d -s code -n git 
tmux new-window -t code:1 -n code 
tmux new-window -t code:2 -n build
tmux new-window -t code:3 -n generalConfig

tmux new -d -s code2 -t code 

tmux send-keys -t code:0 "git fetch && git status" C-m 

tmux send-keys -t code:1 "nvim-server ." C-m 

tmux send-keys -t code:3 " cd ~/Softwareprojekte/myconfig_git && nvim ." C-m 


tmux attach -t code2 
