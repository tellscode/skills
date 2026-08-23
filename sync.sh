#!/usr/bin/env bash

set -u

readonly SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
readonly SOURCE_DIR="$SCRIPT_DIR/skills"

usage() {
    printf 'Usage: %s [opencode|copilot|claude]\n' "$(basename "$0")"
    printf 'Without an argument, syncs all harnesses. Pass a harness to sync only that harness.\n'
    printf 'Existing skills are updated by default; choose deletion once when prompted.\n'
}

die() {
    printf 'Error: %s\n' "$1" >&2
    exit 1
}

case "$(uname -s)" in
    Darwin)
        CONFIG_ROOT="${XDG_CONFIG_HOME:-$HOME/.config}"
        ;;
    Linux|FreeBSD|OpenBSD|NetBSD)
        CONFIG_ROOT="${XDG_CONFIG_HOME:-$HOME/.config}"
        ;;
    MINGW*|MSYS*|CYGWIN*)
        CONFIG_ROOT="${APPDATA:-${XDG_CONFIG_HOME:-$HOME/.config}}"
        ;;
    *)
        die "unsupported operating system: $(uname -s)"
        ;;
esac

if [ ! -d "$SOURCE_DIR" ]; then
    die "source skills directory not found: $SOURCE_DIR"
fi

if [ "$#" -gt 1 ]; then
    usage >&2
    exit 2
fi

if [ "$#" -eq 0 ]; then
    HARNESSes=(opencode copilot claude)
else
    case "$1" in
        opencode|copilot|claude) HARNESSes=("$1") ;;
        -h|--help) usage; exit 0 ;;
        *) usage >&2; exit 2 ;;
    esac
fi

destination_for() {
    case "$1" in
        opencode) printf '%s/opencode/skills\n' "$CONFIG_ROOT" ;;
        copilot) printf '%s/copilot/skills\n' "$HOME" ;;
        claude) printf '%s/claude/skills\n' "$HOME" ;;
    esac
}

should_wipe() {
    local answer
    printf 'Delete existing skills before copying for the selected harness(es)? [y/N] '
    IFS= read -r answer || answer=''
    case "$answer" in
        y|Y|yes|YES|Yes) return 0 ;;
        *) return 1 ;;
    esac
}

sync_harness() {
    local harness="$1"
    local destination
    destination="$(destination_for "$harness")"

    printf '\n%s -> %s\n' "$harness" "$destination"
    if [ "$WIPE" = true ]; then
        if [ -e "$destination" ]; then
            rm -rf -- "$destination" || die "could not wipe $destination"
        fi
    fi

    mkdir -p -- "$destination" || die "could not create $destination"
    for skill in "$SOURCE_DIR"/*; do
        [ -d "$skill" ] || continue
        cp -R -- "$skill" "$destination/" || die "could not copy $skill to $destination"
        printf '  copied %s\n' "$(basename "$skill")"
    done
}

WIPE=false
if should_wipe; then
    WIPE=true
fi

for harness in "${HARNESSes[@]}"; do
    sync_harness "$harness"
done

printf '\nSync complete.\n'
