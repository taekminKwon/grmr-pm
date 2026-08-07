# 2026-08-07 GitHub 작업 시각화 세팅

## 결정

Jira/Notion 대신 `ewha-grmr` GitHub Issues + Milestone + Labels를 기본 작업 추적 도구로 사용합니다.

이유:

- 무료
- PR/branch/commit과 직접 연결 가능
- micro task 운영과 잘 맞음
- 사용자가 GitHub에서 진행상황을 바로 확인 가능

## 생성 완료

Repository:

- `https://github.com/taekminKwon/ewha-grmr`

Milestone:

- `PHASE 1 - Question Vertical Slice`

Labels:

- `phase:1`
- `type:micro-task`
- `area:docs`
- `area:backend`
- `area:frontend`
- `area:qa`
- `worker:claude-a`
- `worker:claude-b`
- `worker:claude-c`
- `worker:claude-d`
- `status:ready`
- `status:in-progress`
- `status:review`
- `status:blocked`

Issues:

- #1 `[Docs] GPT draft/save schema contract 정리`
- #2 `[Docs] StudyRecord type / single session / MVP question type 정리`
- #3 `[Docs] Question status transition / free-practice answer endpoint 정리`
- #4 `[Backend] Question migration + domain model`
- #5 `[Backend] Question service create/list/detail tests`
- #6 `[Backend] Question controller list/detail/create endpoints`
- #7 `[Frontend] Vite React TypeScript scaffold + auth shell`
- #8 `[Frontend] Question constants + API client mock contract`
- #9 `[Frontend] Admin Question list/filter screen`
- #10 `[QA] PHASE 1 PR review checklist`

## GitHub Projects 상태

GitHub Projects board 생성은 아직 완료하지 못했습니다.

원인:

- 현재 `gh` token에 `project` scope가 없음.
- `gh project list` 실행 시 `read:project` scope 부족 오류 발생.
- `gh auth refresh -h github.com -s project`가 device login을 요구함.

필요한 후속 작업:

1. 사용자가 <https://github.com/login/device>에서 device code 인증을 완료한다.
2. `gh auth refresh -h github.com -s project`로 project scope를 갱신한다.
3. GitHub Project `ewha-grmr PM Board`를 생성한다.
4. 생성된 Issues #1-#10을 Project board에 추가한다.
5. Board 컬럼/상태를 Backlog / Ready / In Progress / Review / Blocked / Done 기준으로 정리한다.

## 현재 사용 방법

Project board가 없어도 당장 다음 URL에서 PHASE 1 작업을 볼 수 있습니다.

- Issues: `https://github.com/taekminKwon/ewha-grmr/issues`
- Milestone: `https://github.com/taekminKwon/ewha-grmr/milestone/1`
