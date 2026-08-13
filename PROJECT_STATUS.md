# ewha-grmr 프로젝트 상태

Last updated: 2026-08-14 01:02 KST

## 현재 PHASE

PHASE 1 완료 후 PHASE 2 Student Practice MVP를 진행 중입니다. 학생 역할 shell, local STUDENT 계정, StudyRecord snapshot 도메인이 main에 반영됐고, 자유 학습 문제 조회→제출→채점→기록 생성→즉시 결과 UI vertical slice는 draft PR #45에서 검토 대기 중입니다.

추정 진행률:

- PHASE 1: 100%
- PHASE 2: 약 55~60%
- 전체 MVP: 약 60%

## 기준선 및 실행 상태

- Target project: `/Users/taekmin/Desktop/ewha-grmr`
- `origin/main`: `360d297` (PR #44 local STUDENT account merge)
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
- #28 관리자 전용 Question 생성 UI — `32828fc`
- #29 Redis 통합 테스트 컨텍스트 보정 — `82728f8`
- #30 관리자 Question 상세 조회 UI — `dc6c05b`
- #31 Question 내용 상세 링크 UX — `6600faf`
- #41 Phase 2 학생 자유 학습·StudyRecord 계약 — `e09bff8`
- #42 StudyRecord migration·불변 snapshot 도메인 — `8713877`
- #43 ADMIN/STUDENT 역할별 shell — `5a3ba6f`
- #44 local STUDENT test account — `360d297`

### 승인 대기

- #45 학생 자유 학습·채점 vertical slice — draft

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
- Question 상세·링크 UX: frontend 97/97 tests, build/lint PASS
- PostgreSQL Flyway ID 생성 통합 테스트 PASS
- Redis Testcontainers integration: 4/4 PASS
- 최신 Compose 실동작: login 200, create 201, list/detail API 200, list/create/detail SPA 200
- PR B frontend 165/165 tests, build/lint PASS
- PR B backend default/PostgreSQL/Redis tests PASS
- PR B Compose 학생 E2E: student login, next question, answer submission, StudyRecord creation, practice UI PASS

## 구현 현황

- Question backend: 완료 및 main 반영
- GPT draft/save backend: fake/local adapter 방식 완료, 실제 외부 호출 없음
- 문서 계약: GPT 응답, StudyRecord type, 단일 세션, 객관식-only MVP 반영
- Frontend 기반 및 실제 로그인·세션·보호 라우트 완료
- Question 목록·필터·페이지네이션 완료 및 main 반영
- Question 생성·상세 UI와 ADMIN/STUDENT 렌더링 권한 검사 완료 및 main 반영
- Local infra: PostgreSQL·Redis 완료
- Backend Compose: 완료 및 main 반영
- Frontend Nginx Compose: main 반영 및 실제 full-stack 재검증 완료
- StudyRecord snapshot domain/migration 및 학생 역할 shell·local 계정 main 반영
- 학생 자유 학습·채점 vertical slice 구현 완료, PR #45 승인 대기

## 알려진 리스크 / 드리프트

- 실제 GPT key가 없어 외부 integration test는 분리 대기입니다.
- Backend enum/API는 미래 문제 유형도 표현하지만 Phase 1 frontend는 객관식만 노출합니다.
- 인증 문서는 `TOKEN_EXPIRED`를 언급하지만 현재 entry point는 모든 401에 `TOKEN_INVALID`를 반환합니다. Phase 1 frontend는 HTTP 401로 처리해 기능 영향은 없습니다.
- Compose의 고정 `container_name` 때문에 프로젝트 이름을 다르게 실행하면 충돌합니다. 현재는 `-p infra-compose`를 사용합니다.
- 예약 heartbeat에서 Codex 모델 capacity 오류가 간헐적으로 발생하지만 Claude bridge와 수동 실행은 정상입니다.
- PR #19의 stacked-base 문제는 main 전달용 PR #20 merge로 해결됐습니다.

## GitHub 작업 추적

- Milestones: `PHASE 1 - Question Vertical Slice` 완료, `PHASE 2 - Student Practice MVP` 진행
- Project: `https://github.com/users/taekminKwon/projects/1`
- Issues #1~#10: CLOSED
- Phase 1 independent QA: GO, P0/P1 없음
- Phase 2 Issues #32~#40 추적 중; #32~#35 및 #38 일부가 PR #41~#45로 진행됨

## 운영 제약

- Codex는 target 코드를 직접 구현하지 않고 Claude worker에 micro task로 배정합니다.
- user 승인 전 worker branch를 main에 merge하거나 force push하지 않습니다.
- main/user 변경을 보호하며 실제 GPT 외부 호출을 하지 않습니다.
- 구현 결과는 status/diff/diff-check/test/runtime을 PM이 재검토한 뒤 작은 commit/PR로 전달합니다.

## 다음 PM 작업

1. PR #45 사용자 승인·merge 대기
2. merge 후 PR C 내 학습 이력 목록·상세 backend/frontend vertical slice
3. PR D 권한·Compose 통합 QA와 `TOKEN_EXPIRED` 문서 drift 정리
