# tells-skills

Private skills repository for AI agents.

## Syncing Skills

`sync.sh` copies the skills in this repository to a local AI harness. Existing
skills are updated by default; before each harness sync, the script asks
whether its destination directory should be wiped first.

```bash
./sync.sh                  # sync OpenCode, Copilot, and Claude Code
./sync.sh opencode         # sync only OpenCode
./sync.sh copilot          # sync only GitHub Copilot CLI
./sync.sh claude           # sync only Claude Code
```

On Unix-like systems the destinations are:

- OpenCode: `${XDG_CONFIG_HOME:-~/.config}/opencode/skills`
- GitHub Copilot CLI: `~/.copilot/skills`
- Claude Code: `~/.claude/skills`

The script also supports Windows environments running through MSYS, MinGW, or
CYGWIN, using `%APPDATA%` for OpenCode when available.
