# Security Policy

## Supported Versions

`aeg` is pre-1.0.
Security fixes are currently applied to the latest `main` branch.

## Reporting a Vulnerability

Please do not open public issues for security vulnerabilities.

Report privately with:
- description of the issue
- impact assessment
- proof of concept or reproduction steps
- suggested remediation (if available)

Contact:
- Open a private security advisory on GitHub (recommended), or
- Email: `security@aeg.local` (replace with your real security contact before publishing)

## Response Process

1. Triage and acknowledge report.
2. Reproduce and assess severity.
3. Prepare patch and tests.
4. Coordinate disclosure timeline.
5. Publish advisory and remediation notes.

## Scope Highlights

High-priority security areas:
- prompt injection and jailbreak bypass in guard policies
- unsafe tool/action execution
- improper human-approval bypass
- memory/context leakage across sessions
- world-model unsafe action execution

## Hardening Recommendations

- Keep dependencies updated.
- Use least-privilege credentials for providers.
- Store API keys in environment variables, never in source.
- Enable audit logging for runtime decisions.
- Review eval gates before releases.
