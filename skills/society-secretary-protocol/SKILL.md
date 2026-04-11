---
name: society-secretary-protocol
description: Reconstruct operating protocols and annual checklists from prior society records. Use when the user has email archives, meeting minutes, notices, folders from last year, or fragmented handoff materials and needs a current-year SOP, recurring workflow map, monthly calendar, or onboarding document.
---

# Society Secretary Protocol

## Overview

Turn scattered historical evidence into an executable operating protocol.
Use this skill when the source of truth is buried in last year's mail, notices, and partial handoff files.

## Inputs

Expect some or all of:

- email archives such as `.eml`
- meeting minutes
- prior notices and announcements
- event schedules
- committee reports
- handoff notes
- current-year constraints or updated dates

## Default Workflow

1. Inventory the source set by date, sender, committee, and document type.
2. Identify recurring workflows such as dues cycle, board meetings, annual conference prep, notices, and reporting.
3. Extract actors, trigger dates, required inputs, outputs, approvals, and follow-up actions.
4. Rewrite the process into a current-year protocol only where dates or cadence are explicit or computable.
5. Separate assumptions, missing handoff items, and unresolved questions into a review section.

## Preferred Output Structure

Produce some or all of these:

- annual operating calendar
- recurring workflow list
- step-by-step SOP per workflow
- role map by chair, committee, or secretary
- missing-information list
- approval checkpoints
- current-year action checklist

## What Counts as Evidence

Prefer explicit evidence such as:

- repeated notices across years
- calendar invites and meeting patterns
- fixed deadlines in emails
- named approvers in minutes
- files that show the actual deliverable used last year

Treat these as weaker evidence:

- one-off requests
- informal speculation in email threads
- dates that were probably ad hoc
- implied ownership without explicit assignment

## Guardrails

- Do not invent deadlines that are not supported by the records.
- Do not turn one-off incidents into standard process without saying so.
- Mark any inferred month, owner, or approval path as an assumption.
- Preserve the difference between confirmed protocol and suggested improvement.

## Escalate to Review

Put items in `검토 필요` when:

- current-year dates cannot be computed safely
- the responsible committee is unclear
- an approval step appears in some years but not others
- records conflict on cadence or ownership
- the process may have changed due to new rules or officers

## Companion Use

Use `society-secretary-meeting-comms` after this skill if the user wants the reconstructed protocol turned into notices, reports, or meeting documents.
