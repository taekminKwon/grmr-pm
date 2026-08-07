# 2026-08-07 PHASE 1 감사 요약

## 실행 방식

- iTerm + tmux 세션: `ewha-grmr-workers`
- worker worktree 루트: `/Users/taekmin/Desktop/ewha-grmr-worktrees`
- 실행 모드: 읽기 전용 감사/계획
- 프로젝트 본체 수정: 없음
- worker worktree 수정: 없음

## Claude Worker

- Claude-A `phase-01/docs-contract`: 문서/API 계약 감사
- Claude-B `phase-01/backend-question`: backend Question 준비도 감사
- Claude-C `phase-01/frontend-react`: React 프론트 구조 계획
- Claude-D `phase-01/qa-review`: QA/통합 테스트 계획

원문 로그:

- `state/2026-08-07-claude-a-docs-contract.log`
- `state/2026-08-07-claude-b-backend-question.log`
- `state/2026-08-07-claude-c-frontend-react.log`
- `state/2026-08-07-claude-d-qa-review.log`

## 핵심 판단

현재 프로젝트는 백엔드 초기 세팅 전 단계가 아닙니다. `auth/member` 인증 vertical slice는 이미 구현되어 있고 테스트도 통과합니다. PHASE 1은 다음 순서가 맞습니다.

1. 문서/API 계약 충돌 정리
2. Question 관리 vertical slice 구현
3. React 프론트 shell/auth/question 관리 화면 착수
4. QA 기준과 통합 테스트 기준 확정

## PM 결정안

사용자에게 매번 묻지 않고 PM이 결정할 수 있는 범위로 판단합니다.

- 학습 이력 `type` query 값은 API 내부 enum 기준 `ASSIGNMENT` / `PRACTICE`로 통일합니다. 화면 표시만 `과제` / `자유 학습`으로 둡니다.
- GPT 생성 응답은 `{ "drafts": [...] }`, 저장 응답은 `{ "saved": [...] }`로 통일합니다.
- 자유학습 제출은 `POST /api/me/practice/answers`를 추가하는 방향으로 갑니다.
- 오답 재풀이 제출은 후속 PHASE에서 다루되, retry가 풀이 화면 진입 데이터를 반환한다는 계약은 유지합니다.
- PHASE 1 MVP 문제 유형은 객관식만 구현합니다. 빈칸/오류 찾기는 문서에는 향후 확장으로 남깁니다.
- refresh token은 현재 구현처럼 member별 1개만 유지합니다. 즉 단일 활성 세션 정책으로 문서화합니다.
- Question choices 저장은 `@ElementCollection` 별도 테이블 또는 child table 우선으로 검토합니다. JSON/jsonb는 H2 테스트와 JPA 쿼리에서 부담이 커서 PHASE 1 기본안으로 피합니다.
- repository 테스트는 우선 H2 `@DataJpaTest`, migration 검증은 별도 Testcontainers integration test로 분리합니다.
- frontend는 Vite + React + TypeScript를 기본 후보로 봅니다. 상태관리는 초기에는 React Context + domain별 API module로 시작하고, TanStack Query는 서버 상태가 복잡해지는 시점에 도입합니다.
- token 저장은 PHASE 1 개발 편의상 localStorage를 기본으로 하되, 실제 배포 전 보안 재검토 대상입니다.

## PHASE 1 Workstream

### WS-1 Docs Contract

목표:
`api-spec.md`, `api-spec-detail.md`, `feature-spec.md`, `code-convention.md`, wireframe 간 충돌을 정리합니다.

완료 조건:

- GPT draft/save schema 통일
- StudyRecord type enum 통일
- Question status transition matrix 확정
- 객관식-only MVP 범위 명시
- single-active-session 정책 명시
- free-practice answer endpoint 추가

### WS-2 Backend Question

목표:
관리자 Question CRUD/status/GPT save-ready 구조를 TDD로 구현합니다.

완료 조건:

- `Question` domain/entity/repository
- `V2__create_question_table.sql`
- Question service/controller/DTO
- 401/403/404/400/409/502 error contract
- `./gradlew test` PASS

### WS-3 Frontend React

목표:
React shell, auth flow, admin Question management 화면 구조를 잡습니다.

완료 조건:

- Vite React TypeScript scaffold
- login/auth state/API client
- admin layout
- Question list/filter/detail/create/generate review UI skeleton
- mocked API 또는 contract fixture 기반 개발 가능

### WS-4 QA / Integration

목표:
PHASE 1 acceptance criteria와 regression checklist를 merge gate로 사용합니다.

완료 조건:

- Question test checklist
- auth/security regression matrix
- integration branch merge 기준
- CI 도입 여부 판단

## 현재 Blocker / 주의점

- `data/` 미추적 파일이 target repo에 있습니다. OpenClaw state-store로 보이며 프로젝트 소스가 아니므로 `.gitignore` 또는 위치 이동 판단이 필요합니다.
- Backend에 CORS 설정이 없습니다. React dev server에서 API 호출하려면 dev proxy 또는 backend CORS 설정이 필요합니다.
- CI가 없습니다. 최소 `./gradlew test` GitHub Actions는 PHASE 1 안에 넣는 편이 안전합니다.
- Claude-C가 `~/.claude/plans/...`에 계획 파일을 하나 만들었습니다. target project는 아니지만, 다음 프롬프트부터는 외부 계획 파일 생성도 금지하고 PM repo 로그로만 남기도록 강화합니다.
