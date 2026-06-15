# Society Secretary Agent Kit

<!-- project-summary -->
> **What this is:** Starter kit for society secretary agents with reusable skills, runtime templates, routing rules, and operating documents.
> **한국어:** 학회 총무 에이전트를 만들기 위한 재사용 스킬, 런타임 템플릿, 라우팅 규칙, 운영 문서 스타터킷입니다.
<!-- /project-summary -->


Operational starter kit for a society secretary agent.

This repository gives you two layers:

- reusable Codex skills you can install globally
- project-local runtime assets you can install per society or per operating folder

The intent is simple:

1. keep the agent behavior reusable
2. keep society-specific rules and runtime state local
3. avoid mixing real operational data into the reusable skill package

## What This Kit Contains

- `skills/`
  - reusable secretary skills
  - `society-secretary-dues`
  - `society-secretary-membership`
  - `society-secretary-protocol`
  - `society-secretary-meeting-comms`
- `runtime/`
  - job template
  - runtime schemas
  - sample job
  - review and approval file templates
- `router/`
  - request-type classification rules
  - machine-readable route map
  - classifier prompt
- `templates/`
  - notice, minutes, and protocol templates
- `rules/`
  - example dues, membership, and approval rules
- `docs/`
  - design document
  - orchestration and harness design document
- `scripts/`
  - install helpers for global and local setup

## Recommended Mental Model

Think of this repo in three parts.

- `skills/` is the reusable brain
- `runtime/` is the working memory and job state
- `rules/` and `templates/` are the local operating policy

That means:

- install skills globally once
- install runtime, router, docs, rules, and templates locally per project
- keep real member data and live jobs outside versioned truth when possible

## Install Modes

### 1. Global install

Use this when you want the secretary skills available from anywhere in Codex.

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\install-global.ps1
```

Default target:

- `C:\Users\<you>\.codex\skills`

What it installs:

- `skills/society-secretary-dues`
- `skills/society-secretary-membership`
- `skills/society-secretary-protocol`
- `skills/society-secretary-meeting-comms`

Use this mode when:

- you want to reuse the same skills across multiple society projects
- the skill logic is stable
- the society-specific variation lives in `rules/` and `runtime/`, not in the skills themselves

### 2. Local install

Use this when you want a project-local operating folder for one society or one committee.

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\install-local.ps1
```

Default target:

- current directory

What it installs:

- `skills/`
- `runtime/`
- `router/`
- `templates/`
- `rules/`
- `docs/`

Use this mode when:

- one society has its own dues rules or document templates
- you want to keep runtime job files with the project
- you want a portable working folder that can be archived or handed off

## Best-Practice Setup

Use both install modes together.

1. run `install-global.ps1` once on your machine
2. create a per-society working folder
3. run `install-local.ps1` in that working folder
4. customize `rules/` and `templates/`
5. create jobs under `runtime/jobs/`

This gives you:

- shared reusable skills globally
- society-specific runtime locally
- cleaner separation between logic and live data

## Quick Start

### A. Install globally

```powershell
cd path\to\society-secretary-agent-kit
powershell -ExecutionPolicy Bypass -File .\scripts\install-global.ps1
```

### B. Create a local working folder

```powershell
mkdir D:\YourSocietyProject
cd D:\YourSocietyProject
powershell -ExecutionPolicy Bypass -File path\to\society-secretary-agent-kit\scripts\install-local.ps1
```

### C. Customize the local rules

Edit these first:

- `rules/dues_policy.example.md`
- `rules/membership_rules.example.md`
- `rules/approval_policy.example.md`

If you want, rename them into live working files such as:

- `rules/dues_policy.md`
- `rules/membership_rules.md`
- `rules/approval_policy.md`

### D. Start the first job

1. copy `runtime/job-template/`
2. create a new folder under `runtime/jobs/`, for example:
   - `runtime/jobs/job-2026-04-12-002/`
3. fill:
   - `intake.json`
   - `plan.json`
   - `state.json`
4. attach or reference the source files
5. run the appropriate skill sequence

## First Job Example

The repository already contains one sample job:

- `runtime/jobs/job-2026-04-12-001/`

Use it as a reference for:

- intake structure
- stage planning
- state values
- review file shape
- approval file shape
- event and change logs

## Request Routing

The router files live in `router/`.

Use them like this:

- `router/request_type_rules.md`
  - human-readable classification guide
- `router/request_type_map.json`
  - machine-readable route map
- `router/classifier_prompt.md`
  - reusable LLM prompt for first-pass request classification

Typical routing:

- raw dues records -> `society-secretary-dues`
- confirmed dues reflection into registry -> `society-secretary-membership`
- last year's mail and records -> `society-secretary-protocol`
- minutes, notices, and email drafts -> `society-secretary-meeting-comms`
- mixed requests spanning two phases -> `multi_step_admin`

## How To Use The Skills

### `society-secretary-dues`

Use when the problem is payment reconciliation.

Typical request:

- "정산 파일과 회원 명단을 대조해서 자동 반영 가능 거래와 검토 필요 거래를 나눠줘."

### `society-secretary-membership`

Use when the problem is updating the member registry safely.

Typical request:

- "확정된 회비 결과를 바탕으로 회원 명단 상태를 업데이트안으로 정리해줘."

### `society-secretary-protocol`

Use when the problem is reconstructing process from old records.

Typical request:

- "작년 이메일과 공지문을 읽고 올해 운영 프로토콜과 체크리스트를 만들어줘."

### `society-secretary-meeting-comms`

Use when the output is a draft artifact.

Typical request:

- "회의자료를 읽고 회의록 초안과 위원장 공지 메일 초안을 작성해줘."

## Runtime Status Model

The harness uses these core statuses:

- `received`
- `classified`
- `planned`
- `running`
- `waiting_for_review`
- `waiting_for_approval`
- `completed`
- `failed`

Use:

- `waiting_for_review` for ambiguity or policy interpretation
- `waiting_for_approval` for outward sends, status changes, or sensitive actions

## What To Edit Most Often

In real use, the files you will touch most are:

- `rules/*.md`
- `templates/*.md`
- `runtime/job-template/*`
- `runtime/jobs/<job-id>/*`

The files you will change less often are:

- `skills/*/SKILL.md`
- `router/request_type_map.json`

The files you should treat as design references are:

- `docs/2026-04-12_학회_간사_에이전트_간사님_설계안.md`
- `docs/2026-04-12_학회_간사님_오케스트레이션_하네스_설계안.md`

## Suggested Git Workflow

If you keep this repo in GitHub:

1. keep reusable logic and templates in the repo
2. avoid committing live member data or raw email archives
3. avoid committing real `runtime/jobs/` outputs unless they are sanitized examples
4. update skills and router rules through normal commits
5. treat `rules/*.example.md` as templates, not as live confidential data

## Safety Notes

- Do not commit real member data, dues ledgers, or raw email archives.
- Do not treat `runtime/jobs/` as permanent source of truth for sensitive live operations.
- Do not push approval notes containing personal or financial data without sanitizing them.
- Do not keep live bank exports or raw mailbox dumps in this repository.
- Use the example files in `rules/` and `templates/` as starting points only.
