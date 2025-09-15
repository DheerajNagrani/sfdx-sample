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

## Notes test one pr test
- Use `sfdx force:source:pull` and `sfdx force:source:push` carefully to avoid metadata conflicts.
- Resolve conflicts by running:
  ```bash
  sfdx force:source:status

  ## Static Code Analysis with PMD

This project uses [PMD](https://pmd.github.io/) to analyze Apex classes.

### GitHub Actions
- Workflow file: `.github/workflows/pmd.yml`
- Runs on:
  - Pull requests targeting `develop`
  - Pushes to `develop`
- Generates a `pmd-report.html` file as an artifact.

### Jenkins
- Jenkinsfile runs PMD as part of the pipeline.
- The PMD report is archived in Jenkins and viewable in the job’s **PMD Analysis Report** section.

