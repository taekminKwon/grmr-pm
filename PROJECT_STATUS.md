# ewha-grmr 프로젝트 상태

Last updated: 2026-08-31 00:08 KST

## 현재 PHASE

PHASE 1, PHASE 2, PHASE 3가 완료됐고 PHASE 4 Learning Analytics & Dashboards를 진행 중입니다. PR A는 merge됐고 PR B 관리자 학생 관리·학습 이력이 Draft PR #62로 검토 대기 중입니다.

추정 진행률:

- PHASE 1: 100%
- PHASE 2: 100%
- PHASE 3: 100%
- PHASE 4: PR A 완료, PR B 구현·검증 완료 및 Draft 검토 대기
- 현재 승인된 Phase 4 포함 전체 범위: 약 85%

## 기준선 및 실행 상태

- Target project: `/Users/taekmin/Desktop/ewha-grmr`
- `origin/main`: `222a10e` (Phase 4 PR A #61 merge 반영)
- Target repository recovery clone: `/Users/taekmin/Desktop/ewha-grmr-worktrees/phase4-admin-student-history-recovery`
- PM log recovery clone: `/Users/taekmin/Desktop/ewha-grmr-pm-log-recovery`
- Backend/Frontend Claude bridge: 정상, 대기 중
- 기존 target main/worktree/PM repository Git metadata와 `.env`: macOS `dataless` 상태
- Local Compose: `.env` materialize 전까지 PR B branch 재배포 smoke 보류
- Frontend: `http://localhost`
- Backend: `http://localhost:8080`
- 실제 GPT 외부 호출: 미수행

## 완료 범위

- JWT 인증, ADMIN/STUDENT 역할 분리, local test accounts
- 관리자 Question 생성·목록·필터·상세·수정·상태 변경
- GPT 문제 생성 port/fake adapter 기반 흐름
- 학생 자유 학습 문제 조회, 답안 제출·서버 채점, StudyRecord snapshot 생성
- 학생 본인 학습 이력 목록·상세 및 소유권 격리
- React 역할별 shell과 관리자/학생 UI
- PostgreSQL·Redis·backend·Nginx frontend Docker Compose
- repository-owned 안전한 로컬 배포 스크립트
- Phase 2 통합 QA 및 공통 인증/오류 응답 안정화
- Phase 3 과제 계약, 관리자 과제 생성·조회·수정·삭제 vertical slice
- 학생 과제 목록·문제 조회, PostgreSQL 답안 임시 저장, CBT 최종 제출·원자 채점
- 과제별 immutable StudyRecord 스냅샷과 제출 결과 조회
- 학생 과제 목록·CBT 풀이·결과 React UI

## 최종 검증

- Backend default suite 및 PostgreSQL/Flyway integration suite: PASS
- Frontend: 529/529 tests, build, lint PASS on PR #62 branch
- Backend: 전체 unit suite 및 StudyRecord PostgreSQL/Flyway integration PASS on PR #62 branch
- Latest main Compose health/smoke: PR A merge 시 PASS; PR B branch smoke는 `.env` dataless로 보류
- Phase 2 Issues #32~#40: 모두 CLOSED
- Phase 2 milestone: CLOSED
- Phase 3 Issues: 4/4 CLOSED
- Phase 3 milestone: CLOSED

## 알려진 리스크 / 결정 필요

- 실제 GPT key가 없어 외부 integration test는 별도 profile로 보류함.
- 서버 로그아웃 refresh token 폐기는 refresh token 저장/cookie 정책 결정이 필요함.
- 자유 학습 무작위 문제 조회는 후보 전체 로딩 방식이라 데이터 증가 시 최적화가 필요함.
- 로컬 학생 계정 환경변수 설정 및 STUDENT 로그인/token 발급 smoke 완료.
- 관리자 학생 목록·상세 및 관리자 학습 이력은 PR #62에 구현됨.
- 학생/관리자 대시보드는 PR C 예정이며, 오답노트는 Phase 5로 연기됨.
- 기존 local repository와 `.env`가 macOS File Provider에 의해 `dataless`로 오프로드되어 복구 clone을 사용 중임.

## 운영 제약

- Codex는 target 코드를 직접 구현하지 않고 Claude worker에 micro task로 배정함.
- prompt/commit은 작게, PR은 vertical slice 단위로 구성함.
- 사용자 승인 전 main merge/force push/새 PHASE 범위 확장을 하지 않음.
- 실제 GPT 외부 호출과 사용자 변경 훼손을 금지함.
- 검증된 커밋은 repository deployment script로 로컬에 최신 배포함.

## 다음 PM 작업

1. PR #62 로컬 배포 smoke를 위해 `.env` materialize 또는 안전한 환경 복구
2. PR #62 사용자 검토·merge
3. 최신 main에서 학생/관리자 대시보드 PR C vertical slice
4. Phase 4 통합 QA·안정화 PR D
