# DevSecOps Quick Reference

## 🚀 Quick Commands

### Run Security Scans Locally

```bash
# 1. Dependency Security Scan
cd user-service && npm audit
cd ../product-service && npm audit

# 2. Install and run Trivy (filesystem scan)
brew install trivy
trivy fs .

# 3. Scan Docker images
docker build -t user-service:test ./user-service
trivy image user-service:test

# 4. Secret scanning with Gitleaks
brew install gitleaks
gitleaks detect --source . -v
```

### GitHub Actions Workflows

```bash
# Located in .github/workflows/

devsecops-pipeline.yml  # Main security pipeline
deploy.yml              # Deployment workflow
```

## 🔒 Security Tools Overview

| Tool          | Purpose                    | When it Runs  |
| ------------- | -------------------------- | ------------- |
| **npm audit** | Dependency vulnerabilities | Every push/PR |
| **Trivy**     | Code & container scanning  | Every push/PR |
| **Semgrep**   | SAST - Code patterns       | Every push/PR |
| **Gitleaks**  | Secret detection           | Every push/PR |

## 📊 Pipeline Stages

```
1. Dependency Check → 2. Code Security → 3. SAST Scan
                    ↓
4. Secret Scan → 5. Build & Test → 6. Docker Scan
                    ↓
7. Security Report → 8. Deploy (if main branch)
```

## ✅ Pre-Commit Checklist

- [ ] No secrets in code
- [ ] Dependencies updated
- [ ] Local security scans passed
- [ ] Code reviewed
- [ ] Tests passing

## 🔍 Viewing Results

- **Actions Tab**: Pipeline execution logs
- **Security Tab**: Vulnerability reports (SARIF)
- **PR Checks**: Status before merge
- **Summary**: Each workflow run summary

## 🚨 Common Issues

**npm audit fails?**

```bash
npm audit fix
npm audit --audit-level=high
```

**Container vulnerabilities?**

```bash
# Update base image in Dockerfile
FROM node:18-alpine  # Use alpine for smaller attack surface
```

**Secrets detected?**

- Remove from code immediately
- Use environment variables
- Rotate exposed credentials

## 📚 Documentation

- Full guide: `DEVSECOPS.md`
- Security policy: `SECURITY.md`
- Gitleaks config: `.gitleaks.toml`
