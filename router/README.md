# Request Router

This folder defines how the `간사님` harness classifies incoming requests into `request_type` values and skill routes.

## Files

- `request_type_rules.md`: human-readable routing rules
- `request_type_map.json`: machine-readable mapping for code or no-code orchestration
- `classifier_prompt.md`: reusable LLM router prompt

## Output Contract

The classifier should return at least:

- `request_type`
- `selected_skill`
- `planned_skills`
- `confidence`
- `rationale`
- `detected_signals`
- `needs_planner`

## Current Request Types

- `dues_reconciliation`
- `membership_update`
- `protocol_reconstruction`
- `meeting_minutes`
- `notice_draft`
- `email_draft`
- `multi_step_admin`
- `unknown`
