# Security Policy

## Supported Versions

| Version | Supported          |
| ------- | ------------------ |
| 1.0.x   | :white_check_mark: |

## Security Scanning

This project implements automated security scanning through GitHub Actions:

### 🔍 Automated Scans

1. **Dependency Scanning** - npm audit for vulnerable packages
2. **Code Security Analysis** - Trivy for filesystem vulnerabilities
3. **SAST** - Semgrep for security anti-patterns
4. **Secret Scanning** - Gitleaks for exposed secrets
5. **Container Scanning** - Trivy for Docker image vulnerabilities

### 🚨 Reporting a Vulnerability

If you discover a security vulnerability, please report it by:

1. Creating a private security advisory on GitHub
2. Emailing the security team (add your email here)

**DO NOT** open a public issue for security vulnerabilities.

### Response Time

- Critical vulnerabilities: 24-48 hours
- High vulnerabilities: 1 week
- Medium/Low vulnerabilities: 2 weeks

## Security Best Practices

- Keep dependencies updated
- Review security scan results before merging PRs
- Never commit secrets or credentials
- Use environment variables for sensitive data
