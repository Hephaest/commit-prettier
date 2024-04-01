#!/bin/sh

# Automatically add an emoji based on the commit message.
# For the list of available emojis: https://gitmoji.dev/.
update_commit_msg() {
  case $1 in
    *feat* | *feature*)
      echo "✨ $1"
      ;;
    *fix* | *bug*)
      echo "🐞 $1"
      ;;
    *refactor*)
      echo "♻️ $1"
      ;;
    *test*)
      echo "🧪 $1"
      ;;
    *chore*)
      echo "🧹 $1"
      ;;
    *docs*)
      echo "📄 $1"
      ;;
    *style*)
      echo "🌈 $1"
      ;;
    *ci*)
      echo "👷 $1"
      ;;
    *perf*)
      echo "⚡️ $1"
      ;;
    *build*)
      echo "🏗️ $1"
      ;;
    *revert*)
      echo "⏪️ $1"
      ;;
    *)
      echo "💬 $1"
      ;;
  esac
}

emoji_regex=$'^(.+)\s\w+(.*)?:.*$'
commit_msg_file=$1
commit_msg=$(cat "$commit_msg_file")

# Check if the commit message contains an emoji
if echo $commit_msg | grep -Eq $emoji_regex; then
    echo "Skipped - This commit contains Emoji already."
    exit 0
else
    modified_commit_msg=$(update_commit_msg "$commit_msg")
    # Write the modified commit message back to the file
    echo "$modified_commit_msg" > $commit_msg_file
fi