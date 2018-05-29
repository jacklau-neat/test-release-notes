#!/bin/env bash
NEW_TAG=$1
echo "Tagging $NEW_TAG"
git tag "$NEW_TAG"
git push --tags
bash ./script/generate_changelog.sh "$NEW_TAG"
