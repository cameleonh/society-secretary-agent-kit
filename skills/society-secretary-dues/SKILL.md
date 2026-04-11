---
name: society-secretary-dues
description: Reconcile society dues records against the member registry and fee rules. Use when the user has bank exports, Excel or CSV payment logs, spreadsheet fragments, or scattered dues records that must be normalized, matched to members, classified as paid or exception, and separated into auto-updatable items versus review-needed cases.
---

# Society Secretary Dues

## Overview

Reconcile payment records without silently over-committing on ambiguous matches.
Use this skill to turn messy dues evidence into a clean update list, an exception table, and a clear review queue.

## Inputs

Expect some or all of:

- fee rules or dues policy
- current member registry
- bank export, CSV, XLSX, copied table, or manually transcribed payments
- target period such as current year or semester
- any manual mapping notes from prior reconciliations

If the fee rule or the target period is missing, say that before classifying payments.

## Default Workflow

1. Read the fee rule and the current member registry before touching payment rows.
2. Normalize each transaction into fixed fields: date, depositor, amount, account, memo, source file.
3. Match transactions to members conservatively.
4. Classify each row into `즉시 반영 가능`, `검토 필요`, or `사람 승인 필요`.
5. Produce a ledger-style result that keeps the original transaction traceable.
6. Hand off member-status changes to `society-secretary-membership` if the request also updates the registry.

## Matching Rules

Treat these as safe auto-matches:

- exact name match plus rule-consistent amount
- exact member ID or explicit identifier match
- exact prior mapping confirmed in the current registry or notes

Treat these as `검토 필요`:

- similar names without explicit confirmation
- same payer paying twice in one period
- underpayment, overpayment, or odd amounts
- payer not found in registry
- one payment that could belong to multiple members
- unclear memo text or missing date

Treat these as `사람 승인 필요`:

- refund handling
- manual reassignment of unmatched funds
- retroactive rule exceptions
- deletion or reversal of existing confirmed entries

## Output Package

Return these artifacts when possible:

- normalized transaction table
- auto-updatable transactions
- exception table with reason
- approval-needed table
- suggested registry updates
- red flags such as duplicate payments, unknown payers, and conflicting fee rules

Use these columns by default:

- payment_date
- depositor_name
- amount
- matched_member
- fee_rule_applied
- classification
- reason
- source_file

## Guardrails

- Do not auto-match based on fuzzy similarity alone.
- Do not overwrite confirmed payment history without logging before and after values.
- Do not bury anomalies in the normal update list.
- Do not infer a fee exception unless a rule or explicit instruction supports it.
- Keep every suggested change traceable to a source row and a rule.

## Handoff

If the user also asks to update member category or status, finish reconciliation first and then use `society-secretary-membership` for the registry update step.
