# dotfiles

A snapshot of my macOS shell + terminal config. This is a **reference archive**, not
a symlink/stow setup — the files under [`home/`](home/) mirror their path under `$HOME`,
so `home/.config/ghostty/config` lives at `~/.config/ghostty/config`. To restore on a new
machine, install the tools below and copy the files to their matching paths.

## The stack

| Area | Tool | Config |
|------|------|--------|
| Shell | zsh | [`home/.zshrc`](home/.zshrc), [`home/.zsh.anvaka`](home/.zsh.anvaka) |
| Plugins | [antidote](https://antidote.sh) | [`home/.config/zsh/.zsh_plugins.txt`](home/.config/zsh/.zsh_plugins.txt) |
| Prompt | [Starship](https://starship.rs) | [`home/.config/starship.toml`](home/.config/starship.toml) |
| Terminal | [Ghostty](https://ghostty.org) | [`home/.config/ghostty/config`](home/.config/ghostty/config) |
| History | [atuin](https://atuin.sh) (Ctrl-R) | — |
| Multiplexer | tmux ≥ 3.2 | [`home/.tmux.conf`](home/.tmux.conf) |
| Editor | Neovim | [`home/.vimrc`](home/.vimrc) (`~/.config/nvim` → `~/.vim`) |
| Git | git + [delta](https://github.com/dandavison/delta) | [`home/.gitconfig`](home/.gitconfig) |

Plugins loaded by antidote: Oh-My-Zsh git aliases (aliases only, no OMZ runtime),
`Aloxaf/fzf-tab`, `zsh-autosuggestions`, `fast-syntax-highlighting`.

Shell tooling wired in `.zshrc`: `fzf`, `zoxide` (`z <dir>`), `fnm` (node, `--use-on-cd`),
`atuin`. Modern CLI aliases (only if installed): `eza` (`ls`/`ll`/`la`/`lt`), `bat` (`cat`),
`dust` (`du`), `lazygit` (`lg`), `vim` → `nvim`.

## Install (Homebrew)

```sh
brew install antidote starship atuin zoxide fnm fzf eza bat dust lazygit neovim tmux git-delta
brew install --cask ghostty font-hack-nerd-font
```

Then copy `home/*` to the matching paths under `$HOME`.

## Secrets

Real secrets live in `~/.config/zsh/secrets.zsh` (chmod 600), sourced at the end of
`.zshrc`. That file is **git-ignored and never committed** — see
[`secrets.zsh.example`](secrets.zsh.example) for the shape.

## prompts/

[`prompts/project-overview.md`](prompts/project-overview.md) — an autonomous prompt for
generating a hierarchy of README files across a codebase.
