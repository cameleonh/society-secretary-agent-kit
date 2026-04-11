# Society Secretary Runtime

This folder stores harness runtime data for the `간사님` workflow.

## Structure

- `jobs/`: active and completed jobs
- `job-template/`: copy this folder to start a new job
- `schemas/`: JSON schemas for the runtime files

## New Job Flow

1. Copy `job-template/` to `jobs/job-YYYY-MM-DD-001/`.
2. Fill `intake.json` with the current request and source files.
3. Update `plan.json` with the intended skill sequence.
4. Move `state.json` through `received -> classified -> planned -> running`.
5. Append event records to `logs/events.jsonl`.
6. Append data-change records to `logs/changes.jsonl` when files or rows change.
7. Store generated outputs in `artifacts/`.
8. Write unresolved items to `review/review_items.md`.
9. Write approval-gated items to `approval/approval_items.md`.

## Status Rules

- Use `waiting_for_review` when the issue is ambiguous and needs human interpretation.
- Use `waiting_for_approval` when the next action is valid but requires human approval.
- Use `completed` only after the current workflow has produced its final artifacts.
- Use `failed` only when the job cannot continue without a structural fix.
