#!/bin/env bash
NEW_TAG=$1
echo "Tagging $NEW_TAG"
bash ./script/generate_changelog.sh "$NEW_TAG"
