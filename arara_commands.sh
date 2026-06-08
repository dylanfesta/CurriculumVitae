#!/bin/bash

# Function to handle script termination
cleanup() {
  # Remove traps to avoid infinite loop when kill 0 sends SIGTERM
  trap - SIGINT SIGTERM

  echo "Terminating script..."
  if [ -n "$INOTIFY_PID" ]; then
    kill "$INOTIFY_PID" 2>/dev/null
  fi
  kill 0
  exit 0
}

# Set up trap to catch SIGINT and SIGTERM

# Main loop to monitor file changes
while true; do
  # Start inotifywait to monitor file changes
  inotifywait -rq --exclude '.*\\.log$|.*\\.aux$|.*\\.out$|.*\\.pdf$|.*\\.el$' --event modify . &
  INOTIFY_PID=$!
  wait $INOTIFY_PID # Wait for inotifywait to detect changes

  # Run arara on the specified file without showing its output
  arara cv.tex >/dev/null 2>&1
  cp cv.pdf DylanFesta_cv_$(date +%Y%m%d).pdf

  # Sleep briefly to avoid catching changes made by arara
  sleep 5
done &

# Continuously display the log file in the terminal
watch -n 3 tail -n 50 cv.log
