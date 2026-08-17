# ewha-grmr 프로젝트 상태

Last updated: 2026-08-18 01:16 KST

## 현재 PHASE

PHASE 1과 PHASE 2가 완료됐고 PHASE 3 Assignment MVP를 진행 중입니다. 계약 PR #53, 관리자 과제 PR #54, 학생 과제 CBT PR #55가 merge됐으며 PR D 통합 QA·안정화를 진행 중입니다.

추정 진행률:

- PHASE 1: 100%
- PHASE 2: 100%
- PHASE 3: 약 85%
- 현재 문서화된 전체 MVP: 약 90%

## 기준선 및 실행 상태

- Target project: `/Users/taekmin/Desktop/ewha-grmr`
- `origin/main`: `87c9201` (Phase 3 학생 과제 PR #55 merge 반영)
- Local main: origin/main과 동기화
- PM log repository: `/Users/taekmin/Desktop/ewha-grmr-pm-log`
- Backend/Frontend Claude bridge: Pro 인증 및 최소 호출 정상, 대기 중
- Local Compose: frontend/backend/PostgreSQL/Redis healthy
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
- Frontend: 471/471 tests, build, lint PASS on PR #55 integration branch
- Latest main Compose health/smoke: PASS
- Phase 2 Issues #32~#40: 모두 CLOSED
- Phase 2 milestone: CLOSED

## 알려진 리스크 / 결정 필요

- 실제 GPT key가 없어 외부 integration test는 별도 profile로 보류함.
- 서버 로그아웃 refresh token 폐기는 refresh token 저장/cookie 정책 결정이 필요함.
- 자유 학습 무작위 문제 조회는 후보 전체 로딩 방식이라 데이터 증가 시 최적화가 필요함.
- Phase 3 통합 QA·안정화 PR D가 최신 main 기반으로 진행 중임.
- 관리자 학생/학습현황, 대시보드, 오답노트는 아직 구현되지 않음.

## 운영 제약

- Codex는 target 코드를 직접 구현하지 않고 Claude worker에 micro task로 배정함.
- prompt/commit은 작게, PR은 vertical slice 단위로 구성함.
- 사용자 승인 전 main merge/force push/새 PHASE 범위 확장을 하지 않음.
- 실제 GPT 외부 호출과 사용자 변경 훼손을 금지함.
- 검증된 커밋은 repository deployment script로 로컬에 최신 배포함.

## 다음 PM 작업

1. Phase 3 PR D backend/frontend 병렬 audit 결과 검토
2. 재현된 결함의 최소 보정·회귀 테스트·작은 커밋 누적
3. 전체 통합 검증 후 draft PR 생성 및 사용자 승인 요청
4. Phase 3 마감 검증과 상태 문서 갱신
