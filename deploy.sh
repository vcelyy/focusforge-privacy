#!/bin/bash
# FlowForge Privacy Policy - One-Command Deployment
# Usage: ./deploy.sh [--verify-only]
#
# This script deploys the privacy policy to GitHub Pages.
# After deployment, the policy is available at:
# https://vcelyy.github.io/focusforge-privacy/

set -e

REPO_URL="https://github.com/vcelyy/focusforge-privacy.git"
PAGES_URL="https://vcelyy.github.io/focusforge-privacy/"
APP_JSON_PATH="../../app.json"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}FlowForge Privacy Policy Deployment${NC}"
echo "======================================"
echo ""

# Check if --verify-only flag is passed
if [ "$1" == "--verify-only" ]; then
    echo "Verification mode - checking live URLs..."
    echo ""

    PRIVACY_STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$PAGES_URL")
    TERMS_STATUS=$(curl -s -o /dev/null -w "%{http_code}" "${PAGES_URL}terms.html")

    if [ "$PRIVACY_STATUS" == "200" ]; then
        echo -e "${GREEN}✅ Privacy Policy: $PAGES_URL (HTTP $PRIVACY_STATUS)${NC}"
    else
        echo -e "${RED}❌ Privacy Policy: $PAGES_URL (HTTP $PRIVACY_STATUS)${NC}"
    fi

    if [ "$TERMS_STATUS" == "200" ]; then
        echo -e "${GREEN}✅ Terms of Service: ${PAGES_URL}terms.html (HTTP $TERMS_STATUS)${NC}"
    else
        echo -e "${RED}❌ Terms of Service: ${PAGES_URL}terms.html (HTTP $TERMS_STATUS)${NC}"
    fi

    # Check app.json has correct URL
    if grep -q "$PAGES_URL" "$APP_JSON_PATH" 2>/dev/null; then
        echo -e "${GREEN}✅ app.json has correct privacyUrl${NC}"
    else
        echo -e "${YELLOW}⚠️  app.json may need privacyUrl update${NC}"
    fi

    echo ""
    echo "Verification complete."
    exit 0
fi

# Full deployment mode
echo "Step 1: Checking git status..."
if [ -n "$(git status --porcelain)" ]; then
    echo "  Changes detected, committing..."
    git add -A
    git commit -m "Update privacy policy content - $(date +%Y-%m-%d)"
else
    echo "  No changes to commit."
fi

echo ""
echo "Step 2: Pushing to GitHub..."
git push origin master

echo ""
echo "Step 3: Verifying deployment (GitHub Pages updates in 30-60s)..."
sleep 5

# Try up to 6 times with 10s intervals
for i in {1..6}; do
    STATUS=$(curl -s -o /dev/null -w "%{http_code}" "$PAGES_URL")
    if [ "$STATUS" == "200" ]; then
        echo -e "${GREEN}✅ Deployment verified! (HTTP $STATUS)${NC}"
        break
    fi
    echo "  Attempt $i/6: Waiting for GitHub Pages... (HTTP $STATUS)"
    sleep 10
done

echo ""
echo "Step 4: Updating app.json..."
if [ -f "$APP_JSON_PATH" ]; then
    # Check if already has correct URL
    if grep -q "$PAGES_URL" "$APP_JSON_PATH"; then
        echo -e "${GREEN}✅ app.json already has correct URLs${NC}"
    else
        echo -e "${YELLOW}⚠️  app.json needs manual update${NC}"
        echo "   Update privacyUrl to: $PAGES_URL"
        echo "   Update termsUrl to: ${PAGES_URL}terms.html"
    fi
fi

echo ""
echo -e "${GREEN}======================================"
echo "Deployment Complete!"
echo "======================================${NC}"
echo ""
echo "Privacy Policy: $PAGES_URL"
echo "Terms of Service: ${PAGES_URL}terms.html"
echo ""
echo "To verify later: ./deploy.sh --verify-only"
