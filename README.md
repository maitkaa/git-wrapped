# Git Wrapped 📊

Inspired by Spotify Wrapped, this script generates a simple markdown summary of your Git repository activity. See your coding habits, contributions, and patterns throughout the year.

## Features
- Monthly commit activity
- Line changes and file operations
- Top contributors
- Most used commit words
- Time-of-day analysis
- File type distribution

## Requirements
- Git repository
- Bash shell

## Installation
### Via Curl
```bash
# Download the script
curl -O https://raw.githubusercontent.com/maitkaa/git-wrapped/master/git-wrapped.sh

# Make it executable
chmod +x git-wrapped.sh
```

### Browser
Download the script from [here](https://raw.githubusercontent.com/maitkaa/git-wrapped/master/git-wrapped.sh) and run it using Git Bash.

## Usage
Navigate to any Git repository and run:
```bash
# Current year
./path/to/git-wrapped.sh

# Specific year
./path/to/git-wrapped.sh 2023
```

The script generates `git-wrapped-YEAR.md` in your current directory.

## Example Output
Here's a example of what you might see:

# 🎵 Git Wrapped 2024

## 📊 Your Year in Code

### 🚀 Commits
**248** total commits made

### 📅 Monthly Activity
- January: **45** commits
- February: **52** commits
- March: **38** commits
- April: **65** commits
- May: **48** commits

### 📝 Changes
- ✨ Added: **23567** lines
- 🗑️  Removed: **8901** lines

### 📁 File Operations
- ✨ Created: **156** files
- 🗑️ Deleted: **23** files

### 👥 Top Contributors
- **react-dev**: 180 commits
- **typescript-guru**: 45 commits
- **ui-master**: 23 commits

### 💭 Most Used Words
- component: **89**
- interface: **76**
- router: **45**
- context: **34**
- hooks: **28**

### ⏰ Commit Times
- 🌅 Morning (5-12): 56
- ☀️  Afternoon (12-17): 102
- 🌆 Evening (17-22): 67
- 🌙 Night (22-5): 23

### 📊 File Types
- .tsx: **89** files
- .ts: **67** files
- .css: **34** files
- .json: **12** files
- .md: **8** files


## License
[MIT License](/LICENSE)