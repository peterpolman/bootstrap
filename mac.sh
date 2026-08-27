#!/usr/bin/env bash
# Bootstrap a new Mac: Homebrew + gh, authenticate, clone the private dotfiles
# repo to ~/.config, then hand over to its install.sh.
#
#   curl -fsSL dot.peterpolman.nl/mac.sh | bash
#
# Idempotent: safe to re-run.
set -euo pipefail

REPO="peterpolman/dotfiles"
CONFIG="$HOME/.config"
log() { printf '\033[35m==>\033[0m %s\n' "$1"; }

[ "$(uname -s)" = "Darwin" ] || { echo "macOS only"; exit 1; }

log "Xcode command line tools"
xcode-select -p >/dev/null 2>&1 || {
	xcode-select --install
	echo "    finish the Xcode CLT install, then re-run this script"
	exit 0
}

log "Homebrew"
command -v brew >/dev/null || \
	NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"

log "GitHub CLI"
command -v gh >/dev/null || brew install gh
gh auth status >/dev/null 2>&1 || gh auth login

log "dotfiles -> $CONFIG"
if [ -d "$CONFIG/.git" ]; then
	git -C "$CONFIG" pull --ff-only
elif [ -d "$CONFIG" ] && [ -n "$(ls -A "$CONFIG" 2>/dev/null)" ]; then
	echo "$CONFIG exists and is not a clone — move it aside first"
	exit 1
else
	gh repo clone "$REPO" "$CONFIG"
fi

log "handing over to install.sh"
exec "$CONFIG/install.sh"
