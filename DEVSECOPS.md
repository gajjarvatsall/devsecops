# DevSecOps Pipeline Documentation

## Overview

This project implements a comprehensive DevSecOps pipeline using GitHub Actions with automated security scanning at every stage of the development lifecycle.

## Pipeline Components

### 1. **Dependency Security Scan**

- **Tool**: npm audit
- **Purpose**: Identifies known vulnerabilities in Node.js dependencies
- **Runs**: On every push and PR
- **Action**: Scans both user-service and product-service

### 2. **Code Security Analysis**

- **Tool**: Trivy (filesystem mode)
- **Purpose**: Scans codebase for security vulnerabilities and misconfigurations
- **Runs**: On every push and PR
- **Output**: Results uploaded to GitHub Security tab

### 3. **SAST (Static Application Security Testing)**

- **Tool**: Semgrep
- **Purpose**: Identifies security anti-patterns and vulnerabilities in source code
- **Rules**: security-audit, nodejs, docker
- **Runs**: On every push and PR

### 4. **Secret Scanning**

- **Tool**: Gitleaks
- **Purpose**: Detects hardcoded secrets, API keys, and credentials
- **Runs**: On every push and PR
- **Scans**: Full git history

### 5. **Docker Image Security**

- **Tool**: Trivy (image mode)
- **Purpose**: Scans Docker images for vulnerabilities
- **Severity**: Focuses on CRITICAL and HIGH vulnerabilities
- **Runs**: After successful build

## Workflow Files

### `.github/workflows/devsecops-pipeline.yml`

Main DevSecOps pipeline with all security checks

### `.github/workflows/deploy.yml`

Deployment workflow that runs after security validation

## How to Use

### Running Locally

1. **Install security tools locally (optional):**

```bash
# Install Trivy
brew install trivy

# Scan filesystem
trivy fs .

# Scan Docker image
trivy image user-service:latest
```

2. **Run npm audit:**

```bash
cd user-service
npm audit

cd ../product-service
npm audit
```

3. **Install Gitleaks:**

```bash
brew install gitleaks
gitleaks detect --source . -v
```

### GitHub Actions

The pipeline runs automatically on:

- Push to `main` or `develop` branches
- Pull requests to `main` or `develop` branches

### Viewing Results

1. **GitHub Actions Tab**: View pipeline execution
2. **Security Tab**: View Trivy and CodeQL results (SARIF format)
3. **Pull Request Checks**: See security scan status before merge

## Security Scan Results

All security findings are:

- ✅ Reported in the Actions log
- ✅ Uploaded to GitHub Security tab (where supported)
- ✅ Available in PR status checks
- ✅ Summarized in the workflow summary

## Configuration Files

- `.gitleaks.toml` - Gitleaks configuration
- `SECURITY.md` - Security policy and reporting guidelines

## Best Practices

1. **Review all security findings** before merging PRs
2. **Fix critical vulnerabilities** immediately
3. **Update dependencies** regularly
4. **Never commit secrets** - use environment variables
5. **Review Docker base images** for security updates

## Troubleshooting

### Pipeline Fails on npm audit

- Review the vulnerabilities
- Update dependencies: `npm update`
- Use `npm audit fix` for automatic fixes

### Trivy Finds Vulnerabilities

- Review severity levels
- Update base images in Dockerfiles
- Check for package updates

### Semgrep Findings

- Review code patterns flagged
- Fix or suppress false positives
- Follow security best practices

## Future Enhancements

- [ ] Add DAST (Dynamic Application Security Testing)
- [ ] Integrate SonarQube for code quality
- [ ] Add container runtime security
- [ ] Implement security compliance checks
- [ ] Add automated security patching

## Support

For security issues, see `SECURITY.md` for reporting guidelines.
