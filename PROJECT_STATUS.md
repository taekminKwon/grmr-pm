# ewha-grmr Project Status

Last updated: 2026-08-07 15:56 KST

## Current Phase

Pre-PHASE 1: Repository and document analysis.

PHASE 1 has not been approved yet.

## Current State

- Target project: `/Users/taekmin/Desktop/ewha-grmr`
- PM log repository: `/Users/taekmin/Desktop/ewha-grmr-pm-log`
- Claude CLI: `/Users/taekmin/.local/bin/claude`
- Claude version: `2.1.224`
- Active Claude Code session:
  - cwd: `/Users/taekmin/Desktop/ewha-grmr`
  - sessionId: `bf80e47a-1d7c-4f58-b48b-2231eb34b2a6`
  - status: busy at last check

## Project Summary

Grammar Lab (`grmr`) is an English grammar practice and learning management service.

- Admin manages questions, assignments, students, study records, and dashboards.
- Student solves assignments/free-practice questions and reviews history/wrong answers.
- Backend: Java 21, Spring Boot 4.1.0, Gradle, JPA, Flyway, PostgreSQL.
- Frontend: React planned.

## Known Document Risks

- `api-spec.md` and `api-spec-detail.md` still conflict on GPT generation response shape.
- JWT/auth scope has grown, but backend dependencies may not yet match.
- `CLAUDE.md` may be stale against the newest domain-first package convention.
- Free-practice answer submission endpoint is still missing.
- Non-multiple-choice question types are mentioned but not fully specified for scoring/UI.
- Question status transition needs explicit rules for `DRAFT -> IN_USE`.

## PM Constraints

- PM must not edit target project files directly.
- PM must not create PM artifacts inside the target project repository.
- Implementation belongs to Claude workers.
- PM may read target repo, inspect git status/diff, run tests, assign work, review results, and report.

## Current Monitoring

OpenClaw cron job:

- Job ID: `f6ecfeee-6144-4513-ac42-d70a04f8f603`
- Schedule: every 3 minutes
- Purpose: monitor Claude process, project cwd, and important document drift.
- Delivery: silent by default; wakes main session only on meaningful issue.

Daily PM report cron job:

- Job ID: `e53603b0-f1e9-4e57-ab10-9c5f1411abc3`
- Schedule: 23:45 Asia/Seoul daily
- Purpose: update daily PM log, commit it in this repository, and report summary to Discord.

## Available APIs / Interfaces

### OpenClaw

- `cron`: recurring monitoring and wake events.
- `skill_workshop`: create/update/revise/list/apply/reject/quarantine reusable skill proposals.
- `sessions_spawn`: spawn clean OpenClaw/subagent sessions.
- `session_status`: inspect current OpenClaw session/model status.
- `memory_search` / `memory_get`: memory recall when needed.
- `image_generate`, `video_generate`, `image`: media generation/handling.

### Claude Code CLI

- `claude -p`: non-interactive prompt execution.
- `claude -c`: continue the most recent Claude conversation in the current directory.
- `claude agents --json --all --cwd <path>`: inspect active/completed Claude agent sessions for a project.
- `claude --worktree`, `claude --tmux`: create worktree/tmux-based Claude sessions for future parallel worker operations.
- `--effort`, `--model`, `--permission-mode`, `--allowedTools`, `--disallowedTools`: worker control knobs.

### Claude Local State

- Project session logs: `~/.claude/projects/-Users-taekmin-Desktop-ewha-grmr/*.jsonl`
- Active session metadata: `~/.claude/sessions/*.json`
- Background tasks: `~/.claude/tasks/`

Note: no direct Claude "remaining token quota" API has been identified. Token exhaustion reporting must be inferred from Claude limit messages, session status, and logs unless another API becomes available.

## Next PM Actions

1. Present initial PHASE plan for approval.
2. If PHASE 1 approved, spawn/assign Claude workers via branches/worktrees.
3. Keep daily log updated in this PM repository.
4. Report when Claude token/budget exhaustion or limit condition is detected.
