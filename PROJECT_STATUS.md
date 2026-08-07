# ewha-grmr 프로젝트 상태

Last updated: 2026-08-07 16:44 KST

## 현재 PHASE

PHASE 1 준비: 계약 정합성 감사 완료, 첫 vertical slice 작업 분배 준비.

사용자는 iTerm/tmux 기반 Claude worker 운영 방식과 PM 로그 한국어 운영을 승인했습니다. 첫 Claude worker 라운드는 읽기 전용 감사/계획으로 실행 완료했습니다.

## 현재 상태

- Target project: `/Users/taekmin/Desktop/ewha-grmr`
- PM log repository: `/Users/taekmin/Desktop/ewha-grmr-pm-log`
- PM log remote: `https://github.com/taekminKwon/ewha-grmr-pm`
- PM Discord channel: `1535183582727901195`
- Current PM Discord daily thread: `1535186299797901343` (`2026-08-07 ewha-grmr PM`)
- tmux session: `ewha-grmr-workers`
- worker worktrees:
  - `phase-01/docs-contract` → `/Users/taekmin/Desktop/ewha-grmr-worktrees/docs-contract`
  - `phase-01/backend-question` → `/Users/taekmin/Desktop/ewha-grmr-worktrees/backend-question`
  - `phase-01/frontend-react` → `/Users/taekmin/Desktop/ewha-grmr-worktrees/frontend-react`
  - `phase-01/qa-review` → `/Users/taekmin/Desktop/ewha-grmr-worktrees/qa-review`
- Claude CLI: `/Users/taekmin/.local/bin/claude`
- Claude version: `2.1.224`
- Active Claude Code session:
  - cwd: `/Users/taekmin/Desktop/ewha-grmr`
  - sessionId: `bf80e47a-1d7c-4f58-b48b-2231eb34b2a6`
  - name: `document-login-api-jwt`
  - status: idle at last check

## 프로젝트 요약

Grammar Lab (`grmr`) is an English grammar practice and learning management service.

- Admin manages questions, assignments, students, study records, and dashboards.
- Student solves assignments/free-practice questions and reviews history/wrong answers.
- Backend: Java 21, Spring Boot 4.1.0, Gradle, JPA, Flyway, PostgreSQL.
- Frontend: React planned.

## 알려진 문서/계약 리스크

- `api-spec.md` and `api-spec-detail.md` still conflict on GPT generation response shape.
- JWT/auth scope has grown, but backend dependencies may not yet match.
- `CLAUDE.md` may be stale against the newest domain-first package convention.
- Free-practice answer submission endpoint is still missing.
- Non-multiple-choice question types are mentioned but not fully specified for scoring/UI.
- Question status transition needs explicit rules for `DRAFT -> IN_USE`.

## PM 제약

- PM은 target project 파일을 직접 수정하지 않습니다.
- PM 문서, 계획, 메모는 target project repository 안에 만들지 않습니다.
- 구현은 Claude worker가 담당합니다.
- PM은 target repo 읽기, git status/diff 확인, 테스트 실행, 작업 배정, 결과 리뷰, 보고만 담당합니다.

## Git / Review 운영

- Claude worker 또는 모델별로 branch/worktree를 분리합니다.
- worker branch를 `main`에 직접 merge하지 않습니다.
- PHASE 또는 worker 단위 작업이 끝나면 GitHub Pull Request를 `main` 대상으로 엽니다.
- 택민님은 각 PR을 보고 PHASE 마무리/merge 여부를 확인합니다.
- PM은 PR 전 diff/test/scope를 먼저 검토하고, 필요하면 Claude worker에게 수정을 재지시합니다.

## Micro Prompt / Commit 운영

- Claude에게 한 번에 큰 PHASE 전체를 맡기지 않습니다.
- 프롬프트 단위는 기능/검증 가능한 작은 task로 나눕니다.
- 기본 단위는 endpoint 1개, component 1개, migration 1개, test class 1개, docs contract patch 1개입니다.
- 각 task는 bounded file scope, acceptance criteria, test/check command를 포함해야 합니다.
- 각 task 완료 후 PM이 diff/scope/test를 확인하고, 통과한 단위만 작은 commit으로 남깁니다.
- 컨텍스트가 커지면 새 micro prompt로 분리합니다.

## 현재 모니터링

OpenClaw cron job:

- Job ID: `f6ecfeee-6144-4513-ac42-d70a04f8f603`
- Schedule: every 3 minutes
- Purpose: monitor Claude process, project cwd, and important document drift.
- Delivery: silent by default; wakes main session only on meaningful issue.
- Status: paused at Taekmin's request.

Daily PM report cron job:

- Job ID: `e53603b0-f1e9-4e57-ab10-9c5f1411abc3`
- Schedule: 23:45 Asia/Seoul daily
- Purpose: update daily PM log, commit it in this repository, and report summary to PM Discord channel `1535183582727901195`.
- Status: paused at Taekmin's request.

Note: PM Discord channel `1535183582727901195` is now allowlisted in OpenClaw config. Daily PM threads can be created with `openclaw message thread create`.

## Claude Token / Limit 보고

- Claude token/quota/usage/rate limit 또는 equivalent blocking condition이 감지되면 해당 model/session에 추가 작업을 배정하지 않습니다.
- PM Discord thread에 즉시 보고합니다.
- 오늘 완료한 일과 내일/limit reset 후 해야 할 일을 정리합니다.
- PM daily log를 갱신하고 commit/push합니다.
- 가능하면 PM log commit hash를 함께 보고합니다.
- 현재 cron은 일시 중지되어 있으므로 background 자동 감지는 꺼져 있습니다. active PM 작업 중 감지되는 limit은 즉시 보고합니다.

## 사용 가능한 API / 인터페이스

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

## 최근 Claude / 프로젝트 점검

2026-08-07 16:44 KST:

- Last target project commit: `d2ba68d Docs : 코드 컨벤션 개정 (도메인 우선 구조, 로그인 API 반영)`.
- Recent history shows auth/member implementation already exists (`d895ba9 Feat : 로그인/토큰 재발급/로그아웃 API 구현 (JWT + Spring Security, TDD)`), so PHASE 1 should not be treated as a blank backend setup phase.
- Current target repo status: only untracked `data/` state-store files.
- Backend unit tests: `./gradlew test` PASS.
- No direct target project files were modified by PM.
- PM log repo was pushed to GitHub remote.
- Claude-A/B/C/D read-only audit completed. Raw logs are in `state/`, Korean summary is in `reports/2026-08-07-phase01-audit-summary.md`.
- Worker worktrees are clean; target project still has only untracked `data/`.

## 다음 PM 작업

1. Claude-A에게 docs contract 정리 작업을 micro prompt 단위로 배정하고 `phase-01/docs-contract` branch에서 PR 준비합니다.
2. Claude-B에게 Question domain/Flyway/API TDD 작업을 endpoint/test 단위로 쪼개 배정하고 `phase-01/backend-question` branch에서 PR 준비합니다.
3. Claude-C에게 Vite React TypeScript scaffold/auth/question UI 작업을 component 단위로 쪼개 배정하고 `phase-01/frontend-react` branch에서 PR 준비합니다.
4. Claude-D는 QA reviewer로 두고 worker 결과와 PR merge gate를 검증합니다.
5. PM 로그는 한국어 우선으로 작성하고 GitHub에 푸시합니다.
6. Claude token/budget 제한이 감지되면 당일 작업/내일 작업과 함께 보고합니다.
