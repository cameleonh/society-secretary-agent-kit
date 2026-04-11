---
name: society-secretary-meeting-comms
description: Draft meeting and communication artifacts for a society. Use when the user needs agendas, minutes, decision summaries, action-item lists, board reports, member notices, reminder emails, or official communication drafts built from meeting materials, event data, or prior templates.
---

# Society Secretary Meeting Comms

## Overview

Turn operational materials into sendable drafts and meeting artifacts.
Use this skill when the output is an agenda, minutes, notice, reminder, or official email rather than a data reconciliation task.

## Inputs

Expect some or all of:

- meeting notes or recordings
- prior meeting minutes
- agenda fragments
- event schedules
- committee updates
- target audience and sender
- prior notice or email templates

## Default Workflow

1. Identify the artifact type first: agenda, minutes, notice, reminder, report, or email.
2. Confirm audience, sender, approval boundary, and deadline.
3. Read the source material and extract only explicit decisions, actions, dates, and owners.
4. Draft in the official society tone using the user's existing template when available.
5. Separate send-ready content from approval-needed content.

## Artifact Types

Use this skill for:

- meeting agendas
- meeting minutes
- decision summaries
- action-item trackers
- committee briefings
- member notices
- chair or board emails
- reminder messages tied to meetings or deadlines

## Output Expectations

When drafting minutes or decision summaries, include:

- date and meeting name
- attendees if available
- agenda items
- decisions made
- action items
- owner and deadline only when explicit
- unresolved items

When drafting notices or emails, include:

- purpose of the message
- who it applies to
- what action is requested
- deadline or event date
- contact or reply instruction
- approval status if not yet final

## Guardrails

- Do not invent decisions that are not in the source material.
- Do not assign an owner or deadline unless it is explicit or the user asks you to propose one.
- Do not present a draft as officially sent or finalized.
- Keep approval-needed external communication separate from internal working drafts.
- Preserve sensitive details only when necessary for the target audience.

## Escalate to Review

Mark `검토 필요` when:

- meeting notes conflict
- the sender or approver is unclear
- dates or actions appear incomplete
- wording could imply a policy decision not yet approved
- the audience segment is not defined

## Companion Use

Use `society-secretary-protocol` first when the user needs to reconstruct the process itself from historical records.
Use this skill after the process is clear and the task becomes drafting artifacts for circulation.
