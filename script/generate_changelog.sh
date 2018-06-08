#!/bin/env bash
TAG_VER=$1

# Generate the CHANGELOG based on the tags
gren changelog --generate --override --tags=all

# Since master is a protected branch, it commit to changelog branch and create a pull request
git branch -D changelog
git push origin --delete changelog
git checkout -B changelog
git add CHANGELOG.md
git commit -m "Update CHANGELOG for $TAG_VER"
git push -u origin changelog

# Craete pull request to merge the changelog into master
hub pull-request -m "Update CHANGELOG for $TAG_VER" -b master

git checkout master

# Generate GitHub release notes
gren release --tags=$TAG_VER
