#!/bin/bash
# Setup my initial work notes session
tmux new-session -d -s notes 'cd ~/dev/notes && vim';
# Setup a terminal pane in dev
tmux split-window -h;
tmux send 'cd ~/dev' ENTER;
# Attach to the tmux notes session
tmux a;
