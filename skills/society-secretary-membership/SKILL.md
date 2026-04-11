---
name: society-secretary-membership
description: Maintain the society member registry using documented category and status rules. Use when the user needs to classify new members, update member type, reflect dues status, merge application data into a master sheet, or clean a member list while separating deterministic updates from ambiguous cases.
---

# Society Secretary Membership

## Overview

Maintain the member registry as a controlled status table rather than a loose contact list.
Use this skill when the hard part is deciding member category, status, and safe row-level updates.

## Inputs

Expect some or all of:

- master member registry
- membership category rules
- dues status data or outputs from `society-secretary-dues`
- application forms or onboarding sheets
- contact changes, affiliation changes, or exception notes

If no category rule exists, ask for it or keep category changes in `검토 필요`.

## Default Workflow

1. Read the current registry and membership rules first.
2. Normalize incoming data into stable fields such as name, affiliation, email, phone, category, status, and notes.
3. Match each incoming record to an existing row conservatively.
4. Decide whether each change is deterministic, review-needed, or approval-needed.
5. Produce row-level updates with a change log.

## Safe Updates

Treat these as `즉시 반영 가능` when the rule is explicit:

- contact updates with a single confirmed member row
- affiliation or title updates with explicit source data
- dues status reflection from a confirmed reconciliation result
- category updates that follow a documented rule without exceptions

Treat these as `검토 필요`:

- likely duplicate people
- same name with multiple possible rows
- incomplete application data
- category changes requiring interpretation
- missing status history or conflicting source fields

Treat these as `사람 승인 필요`:

- member removal
- status downgrade with consequences
- exception category assignment
- bulk merges that could destroy row history

## Registry Fields

Prefer a stable schema like:

- member_id
- full_name
- affiliation
- role_or_title
- email
- phone
- member_category
- dues_status
- last_payment_date
- status
- notes

## Output Package

Return these sections when possible:

- deterministic row updates
- review-needed row candidates
- approval-needed actions
- duplicate-risk list
- change log with before and after values

## Guardrails

- Do not merge rows just because names are similar.
- Do not infer member category from institution type unless a rule explicitly allows it.
- Do not delete historical notes or payment fields without approval.
- Preserve registry IDs and source traceability.
- If one source says a member is active and another says inactive, report the conflict instead of picking one silently.

## Handoff

Use `society-secretary-dues` first when the request starts from raw payment records.
Use this skill after reconciliation when the task becomes a registry update problem.
