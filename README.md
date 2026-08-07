# ewha-grmr PM 로그

이 저장소는 `ewha-grmr` 프로젝트의 PM / Development Orchestrator 전용 로그입니다.

## 운영 원칙

- 프로젝트 본체: `/Users/taekmin/Desktop/ewha-grmr`
- PM 로그 저장소: `/Users/taekmin/Desktop/ewha-grmr-pm-log`
- 원격 저장소: `https://github.com/taekminKwon/ewha-grmr-pm`
- PM Discord 채널: `1535183582727901195`
- 오늘 PM 스레드: `1535186299797901343`

캘린은 프로젝트 본체의 코드나 문서를 직접 수정하지 않습니다. 구현은 Claude worker가 담당하고, 캘린은 계획, 작업 분해, 프롬프트 배정, 결과 검증, 테스트 확인, 병합 판단, 보고를 담당합니다.

## 주요 파일

- `OPERATING_PRINCIPLES.md`: PM / Orchestrator 업무 원칙
- `PROJECT_STATUS.md`: 현재 PHASE, worker 상태, 테스트 상태, 다음 작업
- `daily/YYYY-MM-DD.md`: 그날 한 일, Claude 프롬프트/결과, 내일 할 일

## 기록 언어

앞으로 PM 로그는 한국어 우선으로 작성합니다. Claude worker에게 전달하는 프롬프트는 필요하면 영어 템플릿을 섞되, 사람이 보는 진행상황과 일일 보고는 한국어로 남깁니다.

## 기본 진행 루프

1. PM 문서 확인
2. 프로젝트 상태 확인
3. PHASE / WORKSTREAM / TASK 분해
4. Claude worker에게 작업 배정
5. diff, 테스트, 범위 침범 여부 검증
6. PM 스레드에 진행상황 기록
7. PM 로그 repo에 커밋/푸시
