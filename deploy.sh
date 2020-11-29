#!/bin/bash

# Script based on content provided by Josh Rickard on
# https://letsautomate.it/article/how-to-setup-a-hugo-website-on-github/

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

# Build the project.
hugo --minify # if using a theme, replace with `hugo -t <YOURTHEME>`

cd public

# Checkout main branch to avoid attempting to push to detatched HEAD
git checkout main

git add .

# Commit changes.
msg="rebuilding site `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"

# Push source and build repos.
git push

# Come Back up to the Project Root
cd ..