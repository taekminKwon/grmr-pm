#!/usr/bin/env zsh
set -euo pipefail

SESSION="ewha-grmr-workers"
PM="/Users/taekmin/Desktop/ewha-grmr-pm-log"
CLAUDE="/Users/taekmin/.local/bin/claude"

if tmux has-session -t "$SESSION" 2>/dev/null; then
  echo "tmux session already exists: $SESSION"
  echo "Attach with: tmux attach -t $SESSION"
  exit 0
fi

mkdir -p "$PM/state"

tmux new-session -d -s "$SESSION" -n phase01 -c "/Users/taekmin/Desktop/ewha-grmr-worktrees/docs-contract"
tmux set-option -t "$SESSION" pane-border-status top >/dev/null
tmux set-option -t "$SESSION" pane-border-format "#{pane_index}: #{pane_title}" >/dev/null

tmux rename-window -t "$SESSION:0" "phase01-audit"
tmux select-pane -t "$SESSION:0.0" -T "Claude-A docs-contract"
tmux split-window -h -t "$SESSION:0.0" -c "/Users/taekmin/Desktop/ewha-grmr-worktrees/backend-question"
tmux select-pane -t "$SESSION:0.1" -T "Claude-B backend-question"
tmux split-window -v -t "$SESSION:0.0" -c "/Users/taekmin/Desktop/ewha-grmr-worktrees/frontend-react"
tmux select-pane -t "$SESSION:0.2" -T "Claude-C frontend-react"
tmux split-window -v -t "$SESSION:0.1" -c "/Users/taekmin/Desktop/ewha-grmr-worktrees/qa-review"
tmux select-pane -t "$SESSION:0.3" -T "Claude-D qa-review"
tmux select-layout -t "$SESSION:0" tiled >/dev/null

tmux send-keys -t "$SESSION:0.0" "clear; echo '[Claude-A] docs-contract audit starting'; $CLAUDE -p --permission-mode plan --disallowedTools Edit Write NotebookEdit --effort high --name phase01-docs-contract \"\$(cat $PM/prompts/phase01-a-docs-contract.txt)\" | tee $PM/state/2026-08-07-claude-a-docs-contract.log; echo '[Claude-A] DONE'; exec zsh" C-m
tmux send-keys -t "$SESSION:0.1" "clear; echo '[Claude-B] backend-question audit starting'; $CLAUDE -p --permission-mode plan --disallowedTools Edit Write NotebookEdit --effort high --name phase01-backend-question \"\$(cat $PM/prompts/phase01-b-backend-question.txt)\" | tee $PM/state/2026-08-07-claude-b-backend-question.log; echo '[Claude-B] DONE'; exec zsh" C-m
tmux send-keys -t "$SESSION:0.2" "clear; echo '[Claude-C] frontend-react plan starting'; $CLAUDE -p --permission-mode plan --disallowedTools Edit Write NotebookEdit --effort high --name phase01-frontend-react \"\$(cat $PM/prompts/phase01-c-frontend-react.txt)\" | tee $PM/state/2026-08-07-claude-c-frontend-react.log; echo '[Claude-C] DONE'; exec zsh" C-m
tmux send-keys -t "$SESSION:0.3" "clear; echo '[Claude-D] qa-review plan starting'; $CLAUDE -p --permission-mode plan --disallowedTools Edit Write NotebookEdit --effort high --name phase01-qa-review \"\$(cat $PM/prompts/phase01-d-qa-review.txt)\" | tee $PM/state/2026-08-07-claude-d-qa-review.log; echo '[Claude-D] DONE'; exec zsh" C-m

echo "Started tmux session: $SESSION"
echo "Attach with: tmux attach -t $SESSION"
