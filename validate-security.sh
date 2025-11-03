#!/bin/bash

# DevSecOps Setup Validation Script
# This script validates your DevSecOps pipeline setup

echo "🔒 DevSecOps Pipeline Validation"
echo "=================================="
echo ""

# Color codes
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check functions
check_file() {
    if [ -f "$1" ]; then
        echo -e "${GREEN}✓${NC} $1 exists"
        return 0
    else
        echo -e "${RED}✗${NC} $1 missing"
        return 1
    fi
}

check_dir() {
    if [ -d "$1" ]; then
        echo -e "${GREEN}✓${NC} $1 directory exists"
        return 0
    else
        echo -e "${RED}✗${NC} $1 directory missing"
        return 1
    fi
}

echo "📁 Checking Pipeline Files..."
echo "------------------------------"
check_file ".github/workflows/devsecops-pipeline.yml"
check_file ".github/workflows/deploy.yml"
check_file ".github/dependabot.yml"
check_file ".gitleaks.toml"
check_file "SECURITY.md"
check_file "DEVSECOPS.md"
echo ""

echo "🔍 Checking Project Structure..."
echo "--------------------------------"
check_dir "user-service"
check_dir "product-service"
check_dir "nginx"
check_file "docker-compose.yml"
echo ""

echo "📦 Checking Service Configuration..."
echo "------------------------------------"
check_file "user-service/package.json"
check_file "user-service/Dockerfile"
check_file "product-service/package.json"
check_file "product-service/Dockerfile"
echo ""

echo "🔧 Checking for Security Tools (Optional)..."
echo "-------------------------------------------"
if command -v trivy &> /dev/null; then
    echo -e "${GREEN}✓${NC} Trivy is installed"
else
    echo -e "${YELLOW}!${NC} Trivy not installed (optional for local scanning)"
    echo "  Install: brew install trivy"
fi

if command -v gitleaks &> /dev/null; then
    echo -e "${GREEN}✓${NC} Gitleaks is installed"
else
    echo -e "${YELLOW}!${NC} Gitleaks not installed (optional for local scanning)"
    echo "  Install: brew install gitleaks"
fi

if command -v docker &> /dev/null; then
    echo -e "${GREEN}✓${NC} Docker is installed"
else
    echo -e "${RED}✗${NC} Docker not installed (required)"
fi

if command -v npm &> /dev/null; then
    echo -e "${GREEN}✓${NC} npm is installed"
else
    echo -e "${RED}✗${NC} npm not installed (required)"
fi
echo ""

echo "📊 Quick Security Checks..."
echo "---------------------------"
if [ -d "user-service" ]; then
    cd user-service
    if [ -f "package.json" ]; then
        echo "Running npm audit on user-service..."
        npm audit --audit-level=moderate 2>/dev/null || echo -e "${YELLOW}!${NC} Some vulnerabilities found in user-service"
    fi
    cd ..
fi

if [ -d "product-service" ]; then
    cd product-service
    if [ -f "package.json" ]; then
        echo "Running npm audit on product-service..."
        npm audit --audit-level=moderate 2>/dev/null || echo -e "${YELLOW}!${NC} Some vulnerabilities found in product-service"
    fi
    cd ..
fi
echo ""

echo "✅ Setup Validation Complete!"
echo ""
echo "📚 Next Steps:"
echo "  1. Review DEVSECOPS.md for full documentation"
echo "  2. Check DEVSECOPS-QUICKREF.md for quick commands"
echo "  3. Push to GitHub to trigger the pipeline"
echo "  4. View results in GitHub Actions and Security tabs"
echo ""
echo "🚀 To test locally:"
echo "  ./validate-security.sh    # Run this script"
echo "  npm audit                 # Check dependencies"
echo "  trivy fs .                # Scan filesystem"
echo "  gitleaks detect           # Scan for secrets"
echo ""
