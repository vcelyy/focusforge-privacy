# FocusForge Privacy Policy Hosting

This repository contains the privacy policy and terms of service for the FocusForge mobile app.

## Files
- `index.html` - Privacy Policy
- `terms.html` - Terms of Service

## Quick Start (GitHub Pages)

### Option A: Using GitHub CLI (gh)

```bash
# From this directory, run:
gh repo create focusforge-privacy --public --source=. --remote=origin
gh repo view focusforge-privacy --web
```

### Option B: Manual GitHub Setup

```bash
# 1. Initialize git repo
git init
git add .
git commit -m "Initial commit: Privacy policy and terms for FocusForge"

# 2. Create GitHub repo
# Go to https://github.com/new
# Create repo named "focusforge-privacy" (public)
# DO NOT initialize with README

# 3. Push to GitHub
git remote add origin https://github.com/YOUR_USERNAME/focusforge-privacy.git
git branch -M main
git push -u origin main

# 4. Enable GitHub Pages
# Go to repo Settings → Pages
# Source: Deploy from a branch
# Branch: main / root
# Save

# 5. Get your URL
# After 1-2 minutes, visit: https://YOUR_USERNAME.github.io/focusforge-privacy/
```

## Update App Config

Once hosted, update `app.json`:

```json
{
  "expo": {
    "extra": {
      "privacyUrl": "https://YOUR_USERNAME.github.io/focusforge-privacy/"
    }
  }
}
```

Also add terms URL:
```json
{
  "expo": {
    "extra": {
      "termsUrl": "https://YOUR_USERNAME.github.io/focusforge-privacy/terms.html"
    }
  }
}
```

## Netlify Alternative (No Git Required)

1. Install Netlify Drop: https://app.netlify.com/drop
2. Drag this entire folder to Netlify Drop
3. Get your URL (e.g., https://amazing-name-123456.netlify.app)
4. Use that URL in app.json

## Files Ready for Deployment
- ✅ Privacy Policy (index.html) - brand updated to "FocusForge"
- ✅ Terms of Service (terms.html) - created
- ✅ Mobile-responsive styling
- ✅ All links formatted correctly

**Note:** Email addresses in these files use `@focusspark.app` which matches the bundle ID. These can be updated to `@focusforge.app` if you purchase that domain.
