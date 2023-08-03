#!/bin/bash
set -e
argv0=vercmp-devel
XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
AURVCS=".*-(cvs|svn|git|hg|bzr|darcs)$"

# Pattern the defines VCS packages. The AUR has no formal definition of a VCS
# package - here we include the most common version control systems.
filter_vcs() {
    awk -v "mask=$AURVCS" '$1 ~ mask {print $1}' "$@"
}

# For the purposes of this example, we assume AURDEST contains both
# AUR and non-AUR git repositories (e.g. from github or archweb), with
# corresponding packages in the local repository.
AURDEST=${AURDEST:-$XDG_CACHE_HOME/aurutils/sync}
cd "$AURDEST"

# Scratch space for intermediary results.
mkdir -pm 0700 "${TMPDIR:-/tmp}/aurutils-$UID"
tmp=$(mktemp -d --tmpdir "aurutils-$UID/$argv0.XXXXXXXX")
trap 'rm -rf "$tmp"' EXIT

# Retrieve a list of the local repository contents. The repository
# can be specified with the usual aur-repo arguments.
aur repo --list "$@" | tee "$tmp"/db | filter_vcs - >"$tmp"/vcs

# Update `epoch:pkgver-pkgrel` for each target with `aur-srcver`.
# This runs `makepkg`, cloning upstream to the latest revision. The
# output is then compared with the contents of the local repository.
aur vercmp -p <(xargs -ra "$tmp"/vcs aur srcver) <"$tmp"/db
