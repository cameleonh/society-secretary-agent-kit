# Society Secretary Agent Kit

Repo-ready package for a society secretary agent workflow.

This kit separates:

- reusable global skills
- local project runtime assets
- router rules
- example rules and templates
- design documents

## Layout

- `skills/`: reusable Codex skills
- `runtime/`: job template, schemas, logs, and sample job
- `router/`: request-type classifier rules and prompt
- `templates/`: draft templates for notices, minutes, and protocol docs
- `rules/`: example policy files to customize per society
- `docs/`: design and harness documents
- `scripts/`: install helpers

## Install Modes

### Global install

Use this when you want the four secretary skills available everywhere in Codex.

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

### Local install

Use this when you want a project-local working folder with runtime, router, docs, rules, and templates.

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

## Recommended Use

Use both together:

1. run `install-global.ps1` once to make the skills globally available
2. run `install-local.ps1` inside each society project folder

That gives you:

- shared skill behavior globally
- project-specific runtime and rules locally

## Safety Notes

- Do not commit real member data, dues ledgers, or raw email archives.
- Keep `runtime/jobs/` for local operational state, not for repository truth.
- Use the example files in `rules/` and `templates/` as starting points only.
