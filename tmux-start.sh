#!/bin/bash
SESSION_NAME="main"
TMUX=/opt/homebrew/bin/tmux

$TMUX has-session -t $SESSION_NAME 2>/dev/null
if [ $? -eq 0 ]; then
  $TMUX attach-session -t $SESSION_NAME
else
  $TMUX new-session -s $SESSION_NAME -d
  $TMUX attach-session -t $SESSION_NAME
fi
