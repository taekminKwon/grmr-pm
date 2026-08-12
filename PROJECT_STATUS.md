# ewha-grmr 프로젝트 상태

Last updated: 2026-08-12 23:50 KST

## 현재 PHASE

PHASE 1 마감 단계입니다. Question backend, 실제 관리자 로그인, Question API 계약과 목록 UI, 문서 계약, full-stack Compose가 `main`에 반영됐습니다. 관리자 전용 Question 생성 UI는 draft PR #28에서 사용자 승인·merge를 기다립니다.

PR #28 반영 후 최신 main Compose에서 생성 실동작을 확인하고 Issue #10 최종 QA를 수행하면 Phase 1 종료 판정이 가능합니다.

추정 진행률:

- PHASE 1: 약 90~95%
- 전체 MVP: 약 40%

## 기준선 및 실행 상태

- Target project: `/Users/taekmin/Desktop/ewha-grmr`
- `origin/main`: `3638799` (PR #27 Question 목록·필터 merge)
- Local main: `origin/main`과 동기화, ignored `.env`와 보존 대상 `data/` 사용
- PM log repository: `/Users/taekmin/Desktop/ewha-grmr-pm-log`
- PM log remote: `https://github.com/taekminKwon/ewha-grmr-pm`
- Backend Claude bridge: `/Users/taekmin/.local/share/ewha-grmr-pm/claude-backend-bridge`
- Frontend Claude bridge: `/Users/taekmin/.local/share/ewha-grmr-pm/claude-frontend-bridge`
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
- #21 실제 frontend 로그인 API 연동
- #22 local 관리자 시드 계정
- #23 Question 상태 전이·자유 학습 제출 계약
- #24 오렌지 관리자 UI 기반
- #25 Question API 계약·fixture — `b6264b1`
- #26 PostgreSQL Question ID 생성 정합화 — `4b3dc58`
- #27 관리자 Question 목록·필터 — `3638799`

### 승인 대기

- #28 관리자 전용 Question 생성 UI — draft, mergeable

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
- 실제 관리자 로그인 200, Question 목록 API 200, `/admin/questions` 200
- Question API contract/fixture: frontend 55/55 tests, build/lint PASS
- Question 목록 UI: frontend 67/67 tests, build/lint PASS
- Question 생성·역할 검사: frontend 85/85 tests, build/lint PASS
- PostgreSQL Flyway ID 생성 통합 테스트 PASS

## 구현 현황

- Question backend: 완료 및 main 반영
- GPT draft/save backend: fake/local adapter 방식 완료, 실제 외부 호출 없음
- 문서 계약: GPT 응답, StudyRecord type, 단일 세션, 객관식-only MVP 반영
- Frontend 기반 및 실제 로그인·세션·보호 라우트 완료
- Question 목록·필터·페이지네이션 완료 및 main 반영
- Question 생성 UI와 ADMIN/STUDENT 렌더링 권한 검사 완료, PR #28 승인 대기
- Local infra: PostgreSQL·Redis 완료
- Backend Compose: 완료 및 main 반영
- Frontend Nginx Compose: main 반영 및 실제 full-stack 재검증 완료

## 알려진 리스크 / 드리프트

- 실제 GPT key가 없어 외부 integration test는 분리 대기입니다.
- Backend enum/API는 미래 문제 유형도 표현하지만 Phase 1 frontend는 객관식만 노출합니다.
- 기존 Redis refresh-token integration test의 Spring Security test context 오류는 별도 후속 보정 후보입니다.
- Compose의 고정 `container_name` 때문에 프로젝트 이름을 다르게 실행하면 충돌합니다. 현재는 `-p infra-compose`를 사용합니다.
- 예약 heartbeat에서 Codex 모델 capacity 오류가 간헐적으로 발생하지만 Claude bridge와 수동 실행은 정상입니다.
- PR #19의 stacked-base 문제는 main 전달용 PR #20 merge로 해결됐습니다.

## GitHub 작업 추적

- Milestone: `PHASE 1 - Question Vertical Slice`
- Project: `https://github.com/users/taekminKwon/projects/1`
- Issues #1~#9: CLOSED
- 남은 공식 Phase 1 backlog: #10 통합 QA
- 새 Phase와 Phase 2 범위는 Phase 1 종료 후 사용자 승인 전 시작하지 않음

## 운영 제약

- Codex는 target 코드를 직접 구현하지 않고 Claude worker에 micro task로 배정합니다.
- user 승인 전 worker branch를 main에 merge하거나 force push하지 않습니다.
- main/user 변경을 보호하며 실제 GPT 외부 호출을 하지 않습니다.
- 구현 결과는 status/diff/diff-check/test/runtime을 PM이 재검토한 뒤 작은 commit/PR로 전달합니다.

## 다음 PM 작업

1. PR #28 사용자 승인·merge 대기
2. merge 후 최신 main Compose에서 관리자 Question 생성 실제 연동 QA
3. Issue #10 체크리스트 기반 backend/frontend/security/Compose 최종 QA
4. Phase 1 종료 보고 후 Phase 2 범위 제안 및 사용자 승인 대기
