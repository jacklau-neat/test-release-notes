#!/bin/env bash
TAG_VER=$1

# Generate the CHANGELOG based on the tags
# in order to add the CHANGELOG within the tag too, delete and tag it again after commit the CHANGELOG
function git_tag {
  git tag "$TAG_VER"
  git push --tags
}

function remove_git_tag {
  git push --delete origin "$TAG_VER"
  git tag --delete "$TAG_VER"
}

git_tag

gren changelog --generate --override --tags=all

remove_git_tag

git add CHANGELOG.md
git commit -m "Update CHANGELOG, Release $TAG_VER"
git push

git_tag
gren release --tags=$TAG_VER
