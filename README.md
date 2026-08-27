# bootstrap

Public one-liner that sets up a new Mac from my private dotfiles repo.

```bash
bash -c "$(curl -fsSL dot.peterpolman.nl)"
```

`bash -c "$(…)"` rather than `| bash`: the script prompts you (sudo for the Xcode
command line tools, `gh auth login`), and a piped script owns stdin, so those
prompts would have nothing to read from.

The script is named `index.html` so it serves from the root path. GitHub Pages needs
that filename; the extension is meaningless to `bash`. It installs the Xcode command line tools (waiting for them to finish), Homebrew and `gh`,
runs `gh auth login` (browser device flow), clones `peterpolman/dotfiles` into
`~/.config`, and execs its `install.sh`.

Public on purpose: it must be fetchable before any credentials exist on the machine.
It contains no secrets, only a repo name. Everything private stays in the dotfiles repo.

Served via GitHub Pages from `main`.
