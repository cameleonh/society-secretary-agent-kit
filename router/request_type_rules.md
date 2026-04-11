# Request Type Rules

## Goal

Classify each incoming request into one `request_type` value that the harness can route safely.
Prefer stable operational meaning over superficial keyword matching.

## Classification Inputs

Use all of these inputs together:

- user request text
- attached file names and extensions
- source labels in `intake.json`
- requested output artifact
- requested action verbs
- explicit mention of update, send, summarize, compare, or reconstruct

Do not classify from one keyword alone when the rest of the request points elsewhere.

## Step Order

1. Identify the main action.
2. Identify the main object.
3. Identify the expected output.
4. Identify whether the request is single-step or multi-step.
5. Assign one `request_type`.
6. Assign the first skill and any downstream handoff.

## Action Signals

### Compare / Reconcile

Signals:

- 대조
- 맞춰봐
- 비교
- 정산
- reconcile
- normalize
- classify payments

Primary target:

- `dues_reconciliation`

### Update / Reflect

Signals:

- 반영
- 업데이트
- 갱신
- 상태 변경
- 회원구분 수정

Primary target:

- `membership_update`

### Reconstruct / Rebuild Process

Signals:

- 프로토콜
- SOP
- 인수인계
- 작년 메일 읽고 정리
- 운영 절차 복원
- recurring workflow

Primary target:

- `protocol_reconstruction`

### Draft Minutes / Agenda

Signals:

- 회의록
- 안건
- 의사결정 정리
- 액션아이템
- minutes
- agenda

Primary target:

- `meeting_minutes`

### Draft Notice

Signals:

- 공지문
- 안내문
- 공고
- 회원 안내
- notice
- announcement

Primary target:

- `notice_draft`

### Draft Email

Signals:

- 메일 초안
- 이메일 초안
- 회신
- 리마인드 메일
- 보고 메일
- reply draft
- reminder email

Primary target:

- `email_draft`

## Source Signals

### Dues Sources

- `.csv`, `.xlsx`, `.xls` bank export
- transaction table
- 입금내역
- 납부내역
- 오입금
- 중복입금

Bias toward:

- `dues_reconciliation`

### Membership Sources

- 회원 명단
- 신청서
- member registry
- membership sheet
- 연락처 변경
- 소속 변경

Bias toward:

- `membership_update`

### Protocol Sources

- `.eml`
- 작년 이메일
- handoff notes
- prior notices
- annual schedule
- 운영 기록

Bias toward:

- `protocol_reconstruction`

### Meeting / Comms Sources

- 회의자료
- 회의 메모
- 결정사항
- 행사 안내 초안
- 발송용 공지
- 메일 템플릿

Bias toward:

- `meeting_minutes`, `notice_draft`, or `email_draft`

## Output-Artifact Rules

If the user explicitly asks for one of these outputs, prefer the matching `request_type`.

- `회의록`, `안건표`, `액션아이템 정리` -> `meeting_minutes`
- `공지문`, `안내문`, `회원 공지` -> `notice_draft`
- `메일 초안`, `회신 메일`, `리마인드 메일`, `보고 메일` -> `email_draft`
- `운영 프로토콜`, `SOP`, `인수인계 문서`, `월별 운영 캘린더` -> `protocol_reconstruction`
- `대조표`, `정산표`, `오입금 목록`, `회비 반영안` -> `dues_reconciliation`
- `회원 명단 업데이트안`, `회원구분 태깅`, `휴면/미납 상태 정리` -> `membership_update`

## Multi-Step Detection

Classify as `multi_step_admin` when one request clearly spans two or more business phases.

### Typical Multi-Step Patterns

#### Dues -> Membership

Signals:

- 회비 내역 정리하고 회원 명단 반영
- 납부 상태 확인 후 회원구분 업데이트
- bank export plus registry update

Plan:

- first skill: `society-secretary-dues`
- next skill: `society-secretary-membership`

#### Protocol -> Meeting Comms

Signals:

- 작년 메일 읽고 올해 프로토콜 정리한 뒤 공지 초안 작성
- 운영 절차 복원 후 안내 메일 생성
- email archive plus notices or reports

Plan:

- first skill: `society-secretary-protocol`
- next skill: `society-secretary-meeting-comms`

#### Meeting Minutes -> Email

Signals:

- 회의록 정리하고 회의 결과 메일 작성
- 결정사항 정리 후 위원장 메일 초안 작성

Plan:

- first skill: `society-secretary-meeting-comms`
- next skill: `society-secretary-meeting-comms`

Use a two-artifact plan inside one skill unless the workflow boundary truly changes.

## Precedence Rules

Use these when signals conflict.

1. Explicit requested output beats generic source signal.
2. Raw payment files beat a vague "업데이트" verb.
3. `.eml` archive plus SOP/protocol wording beats a generic "정리해줘" request.
4. `회의록` beats `메일` when email is only the source and not the desired output.
5. `공지문` beats `이메일` when the user wants a notice for broad circulation.
6. If the request requires both data reconciliation and registry update, choose `multi_step_admin`.
7. If no clear dominant route exists, choose `unknown` and ask for the missing business goal.

## Review Flags at Classification Time

The classifier should set `needs_planner=true` when:

- more than one skill is likely
- the output target is unclear
- approval-sensitive actions are requested
- the request mixes records cleanup, policy interpretation, and outward communication

The classifier should set `needs_review=true` when:

- no source of truth is referenced
- the requested action could delete or override confirmed data
- the user asks for status changes without criteria

## Recommended Router Output

```json
{
  "request_type": "multi_step_admin",
  "selected_skill": "society-secretary-dues",
  "planned_skills": [
    "society-secretary-dues",
    "society-secretary-membership"
  ],
  "confidence": 0.93,
  "rationale": "The request asks to reconcile dues records first and then reflect confirmed results into the member registry.",
  "detected_signals": {
    "actions": ["정리", "대조", "반영"],
    "objects": ["회비 납부내역", "회원 명단"],
    "sources": ["xlsx bank export", "member registry"],
    "artifacts": ["회비 반영안", "명단 업데이트안"]
  },
  "needs_planner": true,
  "needs_review": false
}
```
