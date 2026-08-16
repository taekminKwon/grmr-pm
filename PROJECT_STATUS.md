# ewha-grmr 프로젝트 상태

Last updated: 2026-08-16 12:30 KST

## 현재 PHASE

PHASE 1과 PHASE 2가 완료됐고 PHASE 3 Assignment MVP를 진행 중입니다. PR A 계약 draft PR #53을 열었고, PR B 관리자 과제 관리의 backend read/search와 frontend 목록 UI까지 완료했습니다.

추정 진행률:

- PHASE 1: 100%
- PHASE 2: 100%
- PHASE 3: 약 25%
- 현재 문서화된 전체 MVP: 약 70%

## 기준선 및 실행 상태

- Target project: `/Users/taekmin/Desktop/ewha-grmr`
- `origin/main`: `d2b8f51` (PR #48 merge)
- Local main: origin/main과 동기화
- PM log repository: `/Users/taekmin/Desktop/ewha-grmr-pm-log`
- Backend/Frontend Claude bridge: 인증 세션 복구 후 정상 실행 중
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

## 최종 검증

- Backend default suite: 212/212 PASS
- PostgreSQL/Flyway integration suite: PASS
- Frontend: 222/222 tests, build, lint PASS
- Latest main Compose health/smoke: PASS
- Phase 2 Issues #32~#40: 모두 CLOSED
- Phase 2 milestone: CLOSED

## 알려진 리스크 / 결정 필요

- 실제 GPT key가 없어 외부 integration test는 별도 profile로 보류함.
- 서버 로그아웃 refresh token 폐기는 refresh token 저장/cookie 정책 결정이 필요함.
- 자유 학습 무작위 문제 조회는 후보 전체 로딩 방식이라 데이터 증가 시 최적화가 필요함.
- Assignment는 계약과 기반 구현까지 진행됐지만 관리자/학생 vertical slice는 아직 미완료임.
- 관리자 학생/학습현황, 대시보드, 오답노트는 아직 구현되지 않음.

## 운영 제약

- Codex는 target 코드를 직접 구현하지 않고 Claude worker에 micro task로 배정함.
- prompt/commit은 작게, PR은 vertical slice 단위로 구성함.
- 사용자 승인 전 main merge/force push/새 PHASE 범위 확장을 하지 않음.
- 실제 GPT 외부 호출과 사용자 변경 훼손을 금지함.
- 검증된 커밋은 repository deployment script로 로컬에 최신 배포함.

## 다음 PM 작업

1. Backend Assignment 목록·상세 HTTP endpoints
2. Frontend 관리자 과제 상세 UI
3. 관리자 create/update/delete와 생성·수정 UI
4. PR B vertical slice 완성 후 PR C/D 진행
