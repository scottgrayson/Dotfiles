#!/bin/zsh
#
# Recreate DB, import a SQL backup, and run migrations.
# Run from a Laravel project root (where .env and artisan live).
#
# Usage:
#   laravel-load-backup.sh [backup-file]
#   laravel-load-backup.sh              # auto-detect most recent *backup*.sql
#   laravel-load-backup.sh --list       # list matching backup files
#
# When run from a git worktree, backups are looked for in the main worktree directory (e.g. …/main).
# Requires: mysql client, Laravel .env with DB_DATABASE, DB_USERNAME, etc.

set -e

# Must be run from project root
if [ ! -f .env ] || [ ! -f artisan ]; then
    echo "Error: Run this script from a Laravel project root (where .env and artisan are)."
    exit 1
fi

# Where to look for *backup*.sql: when in a worktree, use the main worktree dir so backups in main are found; else parent of top-level or cwd
GIT_TOPLEVEL=$(git rev-parse --show-toplevel 2>/dev/null) || true
if [ -n "$GIT_TOPLEVEL" ]; then
    MAIN_WORKTREE=$(git worktree list --porcelain 2>/dev/null | awk '/^worktree /{path=$2} /branch refs\/heads\/main$/{print path; exit}')
    if [ -n "$MAIN_WORKTREE" ] && [ -d "$MAIN_WORKTREE" ] && [ "$MAIN_WORKTREE" != "$GIT_TOPLEVEL" ]; then
        BACKUP_DIR="$MAIN_WORKTREE"
    else
        BACKUP_DIR=$(dirname "$GIT_TOPLEVEL")
    fi
else
    BACKUP_DIR=$(pwd)
fi

# Read DB config from .env (simple key=value, no quotes)
env_var() {
    grep -E "^${1}=" .env 2>/dev/null | cut -d= -f2- | tr -d '\r' || true
}

DB_DATABASE=$(env_var DB_DATABASE)
DB_USERNAME=$(env_var DB_USERNAME)
DB_PASSWORD=$(env_var DB_PASSWORD)
DB_HOST=$(env_var DB_HOST)
DB_PORT=$(env_var DB_PORT)

DB_HOST=${DB_HOST:-127.0.0.1}
DB_PORT=${DB_PORT:-3306}
DB_USERNAME=${DB_USERNAME:-root}
# Empty password is fine for local

if [ -z "$DB_DATABASE" ]; then
    echo "Error: DB_DATABASE not set in .env"
    exit 1
fi

# Find most recent backup matching *backup*.sql in BACKUP_DIR (full path); uses find to avoid zsh no-match on empty glob
find_most_recent_backup() {
    local most_recent=""
    local most_recent_time=0
    while IFS= read -r -d '' file; do
        local t
        t=$(stat -f "%m" "$file" 2>/dev/null || echo 0)
        if [ "$t" -gt "$most_recent_time" ]; then
            most_recent="$file"
            most_recent_time=$t
        fi
    done < <(find "$BACKUP_DIR" -maxdepth 1 -name '*backup*.sql' -print0 2>/dev/null)
    echo "$most_recent"
}

# Help / list
if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    echo "Usage: laravel-load-backup.sh [backup-file]"
    echo "       Run from Laravel project root."
    echo ""
    echo "Options:"
    echo "  --help, -h     Show this help"
    echo "  --list, -l     List *backup*.sql files in backup directory (main worktree when in a worktree)"
    echo "  [backup-file]  Use this file (default: most recent *backup*.sql)"
    exit 0
fi

if [ "$1" = "--list" ] || [ "$1" = "-l" ]; then
    echo "Backup files (*backup*.sql) in $BACKUP_DIR:"
    find "$BACKUP_DIR" -maxdepth 1 -name '*backup*.sql' 2>/dev/null | while read -r f; do
        [ -f "$f" ] && ls -lh "$f" | awk '{print "  " $9 " (" $5 ")"}'
    done
    exit 0
fi

# Choose backup file
if [ -n "$1" ]; then
    BACKUP_FILE="$1"
    echo "Using backup file: $BACKUP_FILE"
else
    # Use only the last line of output (avoids capturing stray lines, e.g. debug output or filenames with newlines)
    BACKUP_FILE=$(find_most_recent_backup | tail -1)
    if [ -z "$BACKUP_FILE" ]; then
        echo "Error: No *backup*.sql files found in $BACKUP_DIR"
        echo "Usage: laravel-load-backup.sh [backup-file]"
        exit 1
    fi
    echo "Using most recent backup: $BACKUP_FILE"
fi

if [ ! -f "$BACKUP_FILE" ]; then
    echo "Error: File not found: $BACKUP_FILE"
    exit 1
fi

# MySQL connection args
MYSQL_OPTS=(-h "$DB_HOST" -P "$DB_PORT" -u "$DB_USERNAME")
[ -n "$DB_PASSWORD" ] && MYSQL_OPTS+=(-p"$DB_PASSWORD")

echo "Dropping and recreating database: $DB_DATABASE"
mysql "${MYSQL_OPTS[@]}" -e "DROP DATABASE IF EXISTS \`$DB_DATABASE\`;"
mysql "${MYSQL_OPTS[@]}" -e "CREATE DATABASE \`$DB_DATABASE\` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"

echo "Importing: $BACKUP_FILE"
mysql "${MYSQL_OPTS[@]}" "$DB_DATABASE" < "$BACKUP_FILE"

echo "Running migrations..."
php artisan migrate

echo "Clearing caches..."
php artisan config:clear
php artisan cache:clear
php artisan route:clear
php artisan view:clear 2>/dev/null || true

echo "Done."
