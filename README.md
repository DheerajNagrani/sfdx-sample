
---

## Branching Strategy
- **`main` branch**  
  - Production-ready code.  
  - Protected: requires PR reviews and a passing Jenkins status check before merge.  

- **`develop` branch**  
  - Active development branch. Protected: requires PR reviews and a passing Jenkins status check before merge. 
  - Pull requests into `develop` trigger Jenkins validation.  

---

## Permissions
- **Read-only user**: Can view repo contents but cannot push or merge.  
- **Write user**: Can create branches, raise pull requests, and push commits.  

---

## Jenkins Integration
- A webhook is configured from GitHub → Jenkins.  
- Every **push** and **pull request** triggers the Jenkins pipeline:
  1. **Checkout** the repository.  
  2. **Authenticate** with Salesforce via JWT.  
  3. **Validate or deploy** metadata:
     - Validation runs for PRs into `main` and `develop`.  
     - Full deployment runs on direct commits to these branches.  
  4. **PMD static analysis** runs on Apex classes, producing:
     - An **HTML report** archived in Jenkins.  
     - Annotations in GitHub PRs (via SARIF).  

---

## Status Checks
- GitHub branch protection enforces that **Jenkins build must pass** before merging into `main`.  
- This ensures deployments meet Salesforce’s 75% test coverage requirement and pass static analysis.  

---

## SFDX Notes
- Always use **`sfdx force:source:pull` / `push`** to avoid metadata conflicts.  
- If conflicts occur:
  - Run `sfdx force:source:status` to see pending local/remote changes.  
  - Use `sfdx force:source:pull --forceoverwrite` if safe, or resolve manually before committing.  
- Validate deployments before merging to `main` to avoid blocking errors in production.  
- Use `sf project deploy validate` in PR pipelines to check for errors without deploying.

---

## Static Analysis (PMD)
- PMD rulesets included:
  - **Design**  
  - **Best Practices**  
  - **Error Prone**  
- Reports:
  - Downloadable HTML (`pmd-report.html`) in Jenkins build artifacts.  
  - GitHub code scanning alerts via SARIF.  

---

## How to Contribute
1. Create a feature branch from `develop`.  
2. Commit and push changes.  
3. Open a PR to `develop`.  
4. Wait for Jenkins validation + PMD checks.  
5. Once approved, changes can be merged.  

---

👉 This setup ensures **code quality**, **metadata safety**, and **controlled deployments** into Salesforce environments.
