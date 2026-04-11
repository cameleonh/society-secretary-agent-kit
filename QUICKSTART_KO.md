# 학회 간사님 빠른 시작

이 문서는 `society-secretary-agent-kit`를 바로 써보기 위한 한국어 빠른 시작 안내서다.

목표는 아래 두 가지다.

1. `간사님` 스킬을 전역으로 설치한다.
2. 특정 학회용 로컬 작업 폴더를 만들고 첫 job을 시작한다.

---

## 1. 언제 이 구조를 쓰면 되나

이 repo는 아래처럼 나눠서 쓰는 구조다.

- `전역 설치`
  - 4개 secretary skill을 어디서든 쓸 수 있게 한다.
- `로컬 설치`
  - 특정 학회용 `runtime`, `router`, `rules`, `templates`, `docs`를 프로젝트 폴더에 깐다.

추천 방식은 항상 둘 다 쓰는 것이다.

---

## 2. 전역 설치

repo 루트에서 아래를 실행한다.

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\install-global.ps1
```

기본 설치 위치:

- `C:\Users\<사용자>\.codex\skills`

설치되는 스킬:

- `society-secretary-dues`
- `society-secretary-membership`
- `society-secretary-protocol`
- `society-secretary-meeting-comms`

이 단계는 보통 한 번만 하면 된다.

---

## 3. 로컬 작업 폴더 만들기

예를 들어 학회별 작업 폴더를 하나 만든다.

```powershell
mkdir D:\MySocietyProject
cd D:\MySocietyProject
powershell -ExecutionPolicy Bypass -File path\to\society-secretary-agent-kit\scripts\install-local.ps1
```

설치되면 아래 폴더가 생긴다.

- `skills/`
- `runtime/`
- `router/`
- `templates/`
- `rules/`
- `docs/`

---

## 4. 가장 먼저 수정할 파일

로컬 설치 후 가장 먼저 손볼 파일은 아래 3개다.

- `rules/dues_policy.example.md`
- `rules/membership_rules.example.md`
- `rules/approval_policy.example.md`

실제로 운영할 때는 아래처럼 복사하거나 이름을 바꿔 쓰는 것을 추천한다.

- `rules/dues_policy.md`
- `rules/membership_rules.md`
- `rules/approval_policy.md`

여기에 학회별 기준을 넣는다.

- 회비 금액
- 회원구분 기준
- 승인 필요 업무
- 예외 처리 기준

---

## 5. 첫 job 시작하기

`runtime/job-template/`를 복사해서 새 작업 폴더를 만든다.

예시:

```powershell
Copy-Item .\runtime\job-template .\runtime\jobs\job-2026-04-12-002 -Recurse
```

그 다음 아래 3개 파일을 채운다.

### `intake.json`

여기에 넣을 것:

- 요청 목적
- 입력 파일 경로
- 기준 문서 경로
- 승인 정책

### `plan.json`

여기에 넣을 것:

- 어떤 skill을 쓸지
- 몇 단계로 실행할지
- 중단 조건
- 다음 handoff skill

### `state.json`

처음에는 보통 아래처럼 둔다.

- `current_status: "planned"`
- `next_skill: "society-secretary-dues"` 또는 적절한 첫 스킬

---

## 6. 어떤 요청이 어떤 스킬로 가나

기본 라우팅은 아래처럼 보면 된다.

- 회비 파일 대조, 오입금, 중복입금 -> `society-secretary-dues`
- 회원 명단 상태 반영, 회원구분 갱신 -> `society-secretary-membership`
- 작년 메일/공지/문서를 읽고 SOP 복원 -> `society-secretary-protocol`
- 회의록, 공지문, 메일 초안 -> `society-secretary-meeting-comms`

복합 요청은 이렇게 연결된다.

- 회비 정산 후 명단 반영 -> `dues -> membership`
- 작년 메일 분석 후 공지/메일 초안 -> `protocol -> meeting-comms`

자세한 규칙은 아래 파일을 보면 된다.

- `router/request_type_rules.md`
- `router/request_type_map.json`
- `router/classifier_prompt.md`

---

## 7. 첫 실전 예시 보기

샘플 job 하나가 이미 들어 있다.

- `runtime/jobs/job-2026-04-12-001/`

이 폴더를 보면 아래를 바로 참고할 수 있다.

- `intake.json` 구조
- `plan.json` 단계 설계
- `state.json` 상태값
- `logs/events.jsonl`
- `review/review_items.md`
- `approval/approval_items.md`

즉, 새 작업은 이 샘플을 참고해서 만들면 된다.

---

## 8. 운영 중 상태값

핵심 상태는 아래 8개다.

- `received`
- `classified`
- `planned`
- `running`
- `waiting_for_review`
- `waiting_for_approval`
- `completed`
- `failed`

보통은 이렇게 움직인다.

1. `received`
2. `classified`
3. `planned`
4. `running`
5. 필요하면 `waiting_for_review` 또는 `waiting_for_approval`
6. 끝나면 `completed`

---

## 9. 자주 쓰는 흐름

### 회비 정산

1. 회비 파일과 회원 명단 준비
2. `dues_policy.md` 확인
3. `society-secretary-dues` 실행
4. 자동 반영 가능 / 검토 필요 / 승인 필요 분리
5. 확정 가능한 결과만 `society-secretary-membership`으로 넘김

### 운영 프로토콜 복원

1. 작년 이메일과 공지문 준비
2. `society-secretary-protocol` 실행
3. SOP와 연간 체크리스트 생성
4. 필요하면 `society-secretary-meeting-comms`로 공지문이나 메일 초안 작성

### 회의록 / 공지

1. 회의자료 또는 결정사항 준비
2. `society-secretary-meeting-comms` 실행
3. 회의록 초안, 공지문 초안, 메일 초안 생성
4. 승인 필요 문안은 `approval_items.md`에 적재

---

## 10. 절대 같이 올리지 말 것

GitHub나 공유 저장소에 아래는 올리지 않는 것을 권장한다.

- 실제 회원 명단
- 실제 회비 입금 내역
- 개인정보 포함 메일 원문
- 승인 전 민감 문서
- 계좌정보가 포함된 파일

repo에는 아래만 넣는 게 안전하다.

- skill
- runtime template
- router
- rules 예시
- templates
- docs

---

## 11. 최소 권장 운영 순서

처음 셋업할 때는 아래 순서가 제일 무난하다.

1. 전역 설치
2. 로컬 설치
3. rules 파일 학회 기준으로 수정
4. 첫 job 생성
5. `dues -> membership` 흐름부터 테스트
6. 그 다음 `protocol -> meeting-comms` 흐름 테스트

---

## 12. 다음에 보면 좋은 파일

- 전체 설명: `README.md`
- 설계 문서: `docs/2026-04-12_학회_간사_에이전트_간사님_설계안.md`
- 하네스 설계: `docs/2026-04-12_학회_간사님_오케스트레이션_하네스_설계안.md`
- 라우터 규칙: `router/request_type_rules.md`
- 샘플 job: `runtime/jobs/job-2026-04-12-001/`
