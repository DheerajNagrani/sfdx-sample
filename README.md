# SFDX Sample Project

This repository contains a Salesforce DX project with an example Apex class and trigger.

## Branching Strategy
- `main`: Production-ready code. Protected, requires PR reviews & passing Jenkins build.
- `develop`: Active development branch.

## Permissions
- Read-only: User A
- Write access: User B

## CI/CD
- Jenkins job runs on every PR to `main`.
- Status check (`jenkins/ci`) must pass before merging.

## Notes test
- Use `sfdx force:source:pull` and `sfdx force:source:push` carefully to avoid metadata conflicts.
- Resolve conflicts by running:
  ```bash
  sfdx force:source:status
