# bootstrap

Public one-liner that sets up a new Mac from my private dotfiles repo.

```bash
curl -fsSL dot.peterpolman.nl/mac.sh | bash
```

`mac.sh` installs Homebrew and `gh`, runs `gh auth login` (browser device flow),
clones `peterpolman/dotfiles` into `~/.config`, and execs its `install.sh`.

Public on purpose: it must be fetchable before any credentials exist on the machine.
It contains no secrets, only a repo name. Everything private stays in the dotfiles repo.

Served via GitHub Pages from `main`.
