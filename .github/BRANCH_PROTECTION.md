# Branch Protection Setup Guide

This document describes the recommended branch protection rules to configure on the
`IBM-TechExchange-2026/terraform-lab-template` repository before the lab goes live.

---

## Main Branch Protection

Apply the following rules to the `main` branch via:
**GitHub → Repository Settings → Branches → Add branch ruleset**

| Setting | Value |
|---|---|
| Require a pull request before merging | ✅ Enabled |
| Required approvals | 1 (instructional team) |
| Dismiss stale pull request approvals | ✅ Enabled |
| Require review from Code Owners | ✅ Enabled (uses `.github/CODEOWNERS`) |
| Restrict who can push to matching branches | ✅ Instructors team only |
| Allow force pushes | ❌ Disabled |
| Allow deletions | ❌ Disabled |

---

## Student Branch Convention

Students must create branches following this naming convention:

```
student-<initials>
```

Example: `student-ao`, `student-jd`

This keeps all student branches easily identifiable and prevents naming collisions.

---

## Instructor Setup Steps

1. Go to `https://github.com/IBM-TechExchange-2026/terraform-lab-template/settings/branches`
2. Click **Add branch ruleset**
3. Set **Branch name pattern** to `main`
4. Apply the settings from the table above
5. Under **Bypass list**, add the `instructors` team so instructors can push hotfixes directly if needed during the lab
