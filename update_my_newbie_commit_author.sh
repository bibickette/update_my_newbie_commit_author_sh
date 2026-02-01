#!/bin/bash
set -e

# check arguments
if [ "$#" -ne 3 ]; then
    echo "Error script arguments: <my_newbie_commit_author.py> <git_repo_url> <path_to_repo>"
    exit 1
fi

CONFIG_FILE="$1"
GIT_URL="$2"
REPO_PATH="$3"

# check if files and directories exist
if [ ! -f "$CONFIG_FILE" ]; then
    echo "Error: the file $CONFIG_FILE does not exist"
    exit 1
fi

if [ ! -d "$REPO_PATH" ]; then
    echo "Error: the directory $REPO_PATH does not exist"
    exit 1
fi

CONFIG_FILE="$(realpath "$CONFIG_FILE")"

# check config file
python3 src/verify_file.py "$CONFIG_FILE"

# Confirmation message
echo "⚠️ ATTENTION ⚠️"
echo "This script will UPDATE AUTHOR and COMMITTER in the git repository located at :"
echo "➡️ $REPO_PATH"
read -p "Continue? (yes/no) " confirm

if [ "$confirm" != "yes" ]; then
    echo "Cancelled."
    exit 1
fi

git -C "$REPO_PATH" filter-repo --force --commit-callback '
config = {}
exec(open("'"$CONFIG_FILE"'").read(), config)

BAD_EMAILS = [e.encode("utf-8") if isinstance(e, str) else e for e in config["BAD_EMAILS"]]
BAD_NAMES  = [n.encode("utf-8") if isinstance(n, str) else n for n in config["BAD_NAMES"]]
RIGHT_NAME = config["RIGHT_NAME"][0].encode("utf-8") 
RIGHT_EMAIL= config["RIGHT_EMAIL"][0].encode("utf-8")

if commit.author_email in BAD_EMAILS or commit.author_name in BAD_NAMES:
    commit.author_name = RIGHT_NAME
    commit.author_email = RIGHT_EMAIL

if commit.committer_email in BAD_EMAILS or commit.committer_name in BAD_NAMES:
    commit.committer_name = RIGHT_NAME
    commit.committer_email = RIGHT_EMAIL
'

if git -C "$REPO_PATH" remote get-url origin &> /dev/null; then
    git -C "$REPO_PATH" remote set-url origin "$GIT_URL"
else
    git -C "$REPO_PATH" remote add origin "$GIT_URL"
fi

git -C "$REPO_PATH" push --force --all
git -C "$REPO_PATH" push --force --tags
