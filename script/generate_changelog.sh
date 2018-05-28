#!/bin/env bash
TAG_VER=$1

# Generate the CHANGELOG based on the tags
# in order to add the CHANGELOG within the tag too, delete and tag it again after commit the CHANGELOG
git tag "$TAG_VER"

gren changelog --generate --override --tags=all
git add CHANGELOG.md
git commit -m "Update CHANGELOG"

git tag --delete "$TAG_VER"

git tag "$TAG_VER"
