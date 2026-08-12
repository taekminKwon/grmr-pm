# ewha-grmr 프로젝트 상태

Last updated: 2026-08-12 11:20 KST

## 현재 PHASE

PHASE 1 진행 중입니다. Question backend vertical slice, 핵심 문서 계약, React/TypeScript 기반, 로그인 화면 shell, PostgreSQL·Redis·backend Docker Compose 구성까지 `main`에 반영됐습니다.

남은 핵심 범위는 frontend Question API 계약/목록 화면, 실제 인증 연동, 문서 Issue #3, 통합 QA입니다. Nginx frontend 정적 서빙도 PR #20을 통해 main에 반영됐고 최신 full-stack Compose 검증을 통과했습니다.

추정 진행률:

- PHASE 1: 약 65%
- 전체 MVP: 약 30~35%

## 기준선 및 실행 상태

- Target project: `/Users/taekmin/Desktop/ewha-grmr`
- `origin/main`: `28af000` (PR #20 Nginx frontend main 전달 merge)
- Local main 상태: auth 미커밋 변경 정리 완료, untracked `data/`만 보존
- PM log repository: `/Users/taekmin/Desktop/ewha-grmr-pm-log`
- PM log remote: `https://github.com/taekminKwon/ewha-grmr-pm`
- Claude bridge: `com.taekmin.ewha-grmr-claude-bridge`
- Bridge queue: `/Users/taekmin/.local/share/ewha-grmr-pm/claude-backend-bridge`
- Codex heartbeat: `ewha-grmr PM orchestration loop`, 30분 간격, active
- PostgreSQL: `grmr-postgres`, localhost:5432, healthy
- Redis: `grmr-redis`, localhost:6379, healthy
- 실제 GPT 외부 호출: 미수행

## GitHub PR 상태

### Main 반영 완료

- #11 Question backend APIs — `cb92d79c`
- #12 GPT 문제 생성 응답 계약 정합화 — `bebea10a`
- #13 PostgreSQL·Redis Compose — `7bdf60e0`
- #14 학습 이력·단일 세션·객관식-only 계약 — `61583879`
- #15 React TypeScript scaffold — `3c3b83a`
- #16 로그인 화면 라우팅 shell — `e1089586`
- #17 Backend Docker/Compose — `e0a001ae`
- #18 Auth domain interface refactor — `b3b88563`
- #20 Nginx frontend main 전달 — `28af000c`

### Stacked branch 반영

- #19 Nginx frontend 정적 서빙 — `phase-01/compose-backend`에 merge (`6f383d18`), main 직접 반영 아님

## 검증 완료 항목

- Question backend 전체 테스트: 99 tests, 0 failures/errors
- Auth domain refactor: `./gradlew test` PASS
- Frontend scaffold: npm ci/build/lint, test 1/1 PASS
- Login shell: npm ci/build/lint, test 7/7 PASS
- Backend container: Flyway/Redis/PostgreSQL 연결 및 health PASS
- Frontend container: Nginx `/`, `/login`, `/healthz` 200
- Nginx `/api/questions` proxy: backend 401 응답으로 path-preserving proxy 확인
- 격리된 full-stack Compose 검증: postgres/redis/backend/frontend 모두 healthy

## 구현 현황

- Question backend: 완료 및 main 반영
- GPT draft/save backend: fake/local adapter 방식 완료, 실제 외부 호출 없음
- 문서 계약: GPT 응답, StudyRecord type, 단일 세션, 객관식-only MVP 반영
- Frontend 기반: Vite + React + TypeScript + Router + Vitest + ESLint 완료
- 로그인 화면: 접근 가능한 shell과 route/fallback 완료, 실제 auth API 연동은 미구현
- Local infra: PostgreSQL·Redis 완료
- Backend Compose: 완료 및 main 반영
- Frontend Nginx Compose: main 반영 및 실제 full-stack 재검증 완료

## 알려진 리스크 / 드리프트

- 문서는 PHASE 1을 `MULTIPLE_CHOICE` only로 정의하지만 backend enum/API는 미래 유형도 허용합니다. frontend에서는 객관식만 노출할 예정입니다.
- 실제 GPT key가 없어 외부 integration test는 분리 대기입니다.
- 로그인 UI는 아직 실제 API 호출, token 저장, refresh, protected route를 구현하지 않았습니다.
- Free-practice answer endpoint와 Question 상태 전이 계약은 Issue #3에서 정리해야 합니다.
- GitHub Issue 상태가 실제 PR 진행과 어긋납니다. #1, #4~#7은 구현/merge됐지만 OPEN이며 label도 `status:ready`입니다.
- PR #19의 stacked-base 문제는 main 전달용 PR #20 merge로 해결됐습니다.
- Compose의 고정 `container_name` 때문에 여러 worktree stack을 동시에 기본 이름으로 실행할 수 없습니다.

## GitHub 작업 추적

- Milestone: `PHASE 1 - Question Vertical Slice`
- Project: `https://github.com/users/taekminKwon/projects/1`
- 완료로 정리해야 할 issue: #1, #4, #5, #6, #7
- 실제 CLOSED: #2
- 남은 제품 backlog: #3, #8, #9, #10
- 다음 PM tracking task: 완료 issue close/label/Project status 정합화

## 운영 제약

- Codex는 target 코드를 직접 구현하지 않고 Claude worker에 micro task로 배정합니다.
- user 승인 전 worker branch를 main에 merge하거나 force push하지 않습니다.
- main/user 변경을 보호하며 실제 GPT 외부 호출을 하지 않습니다.
- 구현 결과는 status/diff/diff-check/test/runtime을 PM이 재검토한 뒤 작은 commit/PR로 전달합니다.

## 다음 PM 작업

1. GitHub Issue #1, #4~#7 및 Project board 상태를 실제 merge 이력에 맞게 정리
2. Issue #7 잔여 범위: auth state/API client/token refresh/protected route를 micro task로 분해
3. Issue #8 Question constants/API client fake contract
4. Issue #9 Admin Question list/filter UI 및 backend 실제 연동
5. Issue #3 문서 계약 정리 후 Issue #10 통합 QA
