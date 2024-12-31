#!/bin/bash

YEAR=${1:-$(date +%Y)}
OUTPUT="git-wrapped-${YEAR}.md"

function write_header() {
    cat > "$OUTPUT" << EOF
# 🎉 Git Wrapped ${YEAR}

## 📊 Your Year in Code

### 🚀 Commits
**$(git rev-list --count HEAD --since="${YEAR}-01-01" --until="${YEAR}-12-31")** total commits made
EOF
}

function write_monthly_stats() {
    echo -e "\n### 📅 Monthly Activity" >> "$OUTPUT"
    months=("January" "February" "March" "April" "May" "June" "July" "August" "September" "October" "November" "December")

    for i in {1..12}; do
        month=${months[$i-1]}
        month_num=$(printf "%02d" $i)
        count=$(git rev-list --count HEAD --since="${YEAR}-${month_num}-01" --until="${YEAR}-${month_num}-31")
        if [ "$count" -gt 0 ]; then
            echo "- ${month}: **${count}** commits" >> "$OUTPUT"
        fi
    done
}


function write_changes() {
    local changes=$(git log --since="${YEAR}-01-01" --until="${YEAR}-12-31" --numstat |
        awk 'BEGIN {adds=0; dels=0}
             $1 ~ /^[0-9]+$/ {adds+=$1}
             $2 ~ /^[0-9]+$/ {dels+=$2}
             END {print adds " " dels}')

    echo -e "\n### 📝 Changes" >> "$OUTPUT"
    echo "- ✨ Added: **${changes%% *}** lines" >> "$OUTPUT"
    echo "- 🗑️  Removed: **${changes##* }** lines" >> "$OUTPUT"
}

function write_file_ops() {
    echo -e "\n### 📁 File Operations" >> "$OUTPUT"
    echo "- ✨ Created: **$(git log --since="${YEAR}-01-01" --until="${YEAR}-12-31" --diff-filter=A --summary | grep -c "create mode")** files" >> "$OUTPUT"
    echo "- 🗑️ Deleted: **$(git log --since="${YEAR}-01-01" --until="${YEAR}-12-31" --diff-filter=D --summary | grep -c "delete mode")** files" >> "$OUTPUT"
}

function write_contributors() {
    echo -e "\n### 👥 Top Contributors" >> "$OUTPUT"
    git shortlog -sn --since="${YEAR}-01-01" --until="${YEAR}-12-31" | head -5 |
        while read -r commits name; do
            echo "- **${name}**: ${commits} commits" >> "$OUTPUT"
        done
}

function write_words() {
    echo -e "\n### 💭 Most Used Words" >> "$OUTPUT"
    git log --since="${YEAR}-01-01" --until="${YEAR}-12-31" --format="%s" |
        tr '[:upper:]' '[:lower:]' |
        tr -cs '[:alpha:]' '\n' |
        grep -vE '^(fix|update|remove|add|change|merge|feature|bug|test|wip|and|the|to|for)$' |
        sort | uniq -c | sort -rn | head -5 |
        while read -r count word; do
            echo "- ${word}: **${count}**" >> "$OUTPUT"
        done
}

function write_time_stats() {
    echo -e "\n### ⏰ Commit Times" >> "$OUTPUT"
    git log --since="${YEAR}-01-01" --until="${YEAR}-12-31" --format="%ad" --date=format:"%H" |
        awk '{
            hour=$1
            if (hour >= 5 && hour < 12) morning++
            else if (hour >= 12 && hour < 17) afternoon++
            else if (hour >= 17 && hour < 22) evening++
            else night++
        }
        END {
            print "- 🌅 Morning (5-12): " morning+0
            print "- ☀️  Afternoon (12-17): " afternoon+0
            print "- 🌆 Evening (17-22): " evening+0
            print "- 🌙 Night (22-5): " night+0
        }' >> "$OUTPUT"
}

function write_file_types() {
    echo -e "\n### 📊 File Types" >> "$OUTPUT"
    git ls-files | grep -E ".*\.[^/]+$" | sed -E 's/.*\.([^/]+)$/\1/' |
        tr '[:upper:]' '[:lower:]' | sort | uniq -c | sort -rn | head -5 |
        while read -r count ext; do
            echo "- .${ext}: **${count}** files" >> "$OUTPUT"
        done
}

write_header
write_monthly_stats
write_changes
write_file_ops
write_contributors
write_words
write_time_stats
write_file_types

echo -e "\nGit Wrapped generated at ${OUTPUT}"
