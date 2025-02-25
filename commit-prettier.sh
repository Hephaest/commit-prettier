#!/bin/sh

# Helper message.
show_help() {
  # Using echo instead of cat to show help text
  echo "Usage: $0 [-h] [--branch]"
  echo "  -h, --help    Show this help message"
  echo "  --branch      Optional. Include the current branch in the commit message. This is helpful if you don't want to add commit scope manually."
  exit 0
}

# The git branch on the current workspace.
get_branch() {
  git rev-parse --abbrev-ref HEAD
}

# Automatically add an emoji based on the commit message.
# For the list of available emojis: https://gitmoji.dev/.
get_emoji() {
  case $1 in
    *feat* | *feature*)
      echo "✨"
      ;;
    *fix* | *bug*)
      echo "🐛"
      ;;
    *refactor*)
      echo "♻️"
      ;;
    *test*)
      echo "🧪"
      ;;
    *chore*)
      echo "🧹"
      ;;
    *docs*)
      echo "📄"
      ;;
    *style*)
      echo "🌈"
      ;;
    *ci*)
      echo "👷"
      ;;
    *perf*)
      echo "⚡️"
      ;;
    *build*)
      echo "🏗️"
      ;;
    *revert*)
      echo "⏪️"
      ;;
    *)
      echo "💬"
      ;;
  esac
}

scope_branch="false"  # Default is to not set the branch as scope
commit_msg_file=""

# Parse command-line options
while [ $# -gt 0 ]; do
  case "$1" in
    -h|--help)
      show_help
      ;;
    --branch)
      scope_branch="true"
      shift
      ;;
    *)
    commit_msg_file=$1
      shift
      ;;
  esac
done

# Check if commit message file is provided
if [ -z "$commit_msg_file" ]; then
  echo "Error: Commit message file is required"
  exit -1
fi

emoji_regex=$'^(.+)\s\w+(.*)?:.*$'
scope_regex=$'\([a-zA-Z0-9_-]+\)?:.*'
commit_msg=$(cat "$commit_msg_file")

# Check if the commit message contains an emoji
if echo $commit_msg | grep -Eq $emoji_regex; then
  echo "Skipped - This commit contains Emoji already."
  exit 0
fi

modify_save_commit() {
  emoji=$(get_emoji $1);
  echo "$emoji $2" > $commit_msg_file
}

scope_exist="false"
# Remove everything after the first colon, leaving the first field.
commit_type=${commit_msg%%:*}
# Remove everything before the first colon, leaving the rest of the fields.
commit_subject=${commit_msg#*:}

if echo $commit_msg | grep -Eq $scope_regex; then
    scope_exist="true"
fi

if [ "$scope_branch" = "false" ] || [ "$scope_exist" = "true" ]; then
  modify_save_commit "$commit_type" "$commit_msg"
  exit 0
fi

modify_save_commit "$commit_type" "$commit_type($(get_branch)):$commit_subject"
