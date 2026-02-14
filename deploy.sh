#!/bin/bash
# FocusForge Privacy Policy Deployment Script
# This script helps deploy the privacy policy to GitHub Pages

set -e

echo "🚀 FocusForge Privacy Policy Deployment"
echo "===================================="
echo ""

# Check if gh CLI is installed
if command -v gh &> /dev/null; then
    echo "✅ GitHub CLI found"

    # Check if user is authenticated
    if gh auth status &> /dev/null; then
        echo "✅ GitHub authenticated"
    else
        echo "❌ Please run: gh auth login"
        exit 1
    fi

    REPO_NAME="focusforge-privacy"

    echo ""
    echo "Creating GitHub repo: $REPO_NAME"
    gh repo create $REPO_NAME --public --source=. --remote=origin || echo "Repo may already exist"

    echo ""
    echo "Enabling GitHub Pages..."
    sleep 2
    gh repo view $REPO_NAME --web || echo "Please enable Pages manually in repo settings"

    echo ""
    echo "✅ Deployment complete!"
    echo ""
    echo "Your privacy policy will be available at:"
    gh repo view $REPO_NAME --web 2>/dev/null || echo "https://YOUR_USERNAME.github.io/$REPO_NAME/"

else
    echo "❌ GitHub CLI not found"
    echo ""
    echo "Manual deployment steps:"
    echo "1. Go to https://github.com/new"
    echo "2. Create repo named 'focusforge-privacy' (public, no README)"
    echo "3. Run these commands in this directory:"
    echo "   git remote add origin https://github.com/YOUR_USERNAME/focusforge-privacy.git"
    echo "   git branch -M main"
    echo "   git push -u origin main"
    echo "4. Enable GitHub Pages in repo settings"
    echo ""
fi

echo ""
echo "⚠️  IMPORTANT: After deployment, update app.json:"
echo "   Update extra.privacyUrl to your GitHub Pages URL"
echo "   Add extra.termsUrl pointing to terms.html"
