# DevSecOps Pipeline Architecture

## Pipeline Flow Diagram

```
┌─────────────────────────────────────────────────────────────────┐
│                    CODE COMMIT (Push/PR)                         │
└─────────────────────────────────────────────────────────────────┘
                              ║
                    ┌─────────╨─────────┐
                    │  SECURITY LAYER   │
                    └─────────┬─────────┘
                              ║
        ┌─────────────────────┼─────────────────────┐
        │                     │                     │
        ▼                     ▼                     ▼
┌───────────────┐   ┌───────────────┐   ┌───────────────┐
│  DEPENDENCY   │   │     CODE      │   │     SAST      │
│   SECURITY    │   │   SECURITY    │   │   SCANNING    │
│               │   │   ANALYSIS    │   │               │
│  npm audit    │   │    Trivy      │   │   Semgrep     │
└───────┬───────┘   └───────┬───────┘   └───────┬───────┘
        │                   │                   │
        └─────────────────┬─┴───────────────────┘
                          │
                          ▼
                ┌───────────────────┐
                │  SECRET SCANNING  │
                │                   │
                │     Gitleaks      │
                └─────────┬─────────┘
                          │
                          ▼
                ┌───────────────────┐
                │  BUILD & TEST     │
                │                   │
                │  Node.js Build    │
                └─────────┬─────────┘
                          │
                          ▼
                ┌───────────────────┐
                │  DOCKER IMAGE     │
                │  SECURITY SCAN    │
                │                   │
                │  Trivy (Images)   │
                └─────────┬─────────┘
                          │
                          ▼
                ┌───────────────────┐
                │  SECURITY REPORT  │
                │                   │
                │  GitHub Security  │
                └─────────┬─────────┘
                          │
                          ▼
            ┌─────────────────────────┐
            │   DEPLOYMENT (main)     │
            │                         │
            │  Docker Compose Deploy  │
            └─────────────────────────┘
```

## Security Tools Matrix

| Stage | Tool          | Type      | Output                     |
| ----- | ------------- | --------- | -------------------------- |
| 1     | npm audit     | SCA       | Dependency vulnerabilities |
| 2     | Trivy (fs)    | SAST      | Code vulnerabilities       |
| 3     | Semgrep       | SAST      | Security patterns          |
| 4     | Gitleaks      | Secret    | Exposed credentials        |
| 5     | Trivy (image) | Container | Image vulnerabilities      |

## Workflow Triggers

```yaml
on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main, develop]
```

## Security Gates

```
┌──────────────────────────────────────────┐
│ All Security Scans Must Pass Before:    │
│                                          │
│  ✓ Merge to main                        │
│  ✓ Deployment to production             │
│  ✓ Docker image build                   │
└──────────────────────────────────────────┘
```

## Continuous Monitoring

```
Dependabot (Weekly)
    │
    ├─► npm packages
    ├─► Docker images
    └─► GitHub Actions
```
