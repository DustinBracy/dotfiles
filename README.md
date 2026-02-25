# Dotfiles (git + GNU Stow)

This repository contains your dotfiles arranged as stow "packages". Use Git to manage the repository and GNU Stow to create symlinks into your home directory.

## Prerequisites

- Git
- GNU Stow (on macOS: `brew install stow`)

## Recommended repo layout

Place related dotfiles in top-level folders (stow packages), for example:

- `zsh/` (contains `.zshrc`, `.zprofile`, etc.)
- `git/` (contains `.gitconfig`, `.gitignore_global`)
- `nvim/` (contains `.config/nvim/` tree)

Each package should contain the path as it will appear in `$HOME`. Example: `git/.gitconfig`.

## Clone the repo

Replace `<your-repo-url>` with your repository URL. Example uses `~/.dotfiles` as the local path:

```bash
git clone <your-repo-url> ~/.dotfiles
cd ~/.dotfiles
```

If the repo is already present at a different path (like `~/dotfiles`), adapt the commands accordingly.

## Backup existing files (safe first step)

Before stowing, back up existing files that may conflict:

```bash
timestamp=$(date +%Y%m%d%H%M%S)
backup_dir="$HOME/dotfiles_backup_$timestamp"
mkdir -p "$backup_dir"
# move possibly conflicting files
mv ~/.zshrc "$backup_dir/" 2>/dev/null || true
mv ~/.gitconfig "$backup_dir/" 2>/dev/null || true
```

## Use GNU Stow

Basic stow usage (dry-run first):

```bash
# dry-run for package 'zsh'
stow -n -v -R zsh -t "$HOME"

# when satisfied, create the symlinks
stow -v -R zsh -t "$HOME"

# remove a package (unstow)
stow -v -D zsh -t "$HOME"

# restow all packages in the repo root (careful; typically run from repo root)
stow -v -R */ -t "$HOME"
```

Notes:

- `-n` is a dry run (no changes).
- `-R` makes stow recursively process the package (recommended for initial install and updates).
- `-D` deletes the symlinks created by stow for that package.

## Updating dotfiles

When you change dotfiles in the repo:

```bash
cd ~/.dotfiles
git add -A
git commit -m "Update dotfiles"
git push

# re-stow to apply changes (or restow specific packages)
stow -v -R zsh -t "$HOME"
```

## Troubleshooting

- If stow reports conflicts, inspect whether the target file exists and either remove it, move it to backup, or edit the package structure so the intended symlink path is correct.
- Use `stow -S <package> -t "$HOME"` if your stow implementation supports the `-S/--stow` alias. The `-R` approach above is portable.
- Verify symlinks with `ls -la ~ | grep <name>`.

## Example quick setup (copy-paste)

```bash
# clone
git clone <your-repo-url> ~/.dotfiles
cd ~/.dotfiles

# backup a few common files
mkdir -p ~/dotfiles_backup
mv ~/.zshrc ~/dotfiles_backup/ 2>/dev/null || true

# dry-run, then stow
stow -n -v -R zsh -t "$HOME"
stow -v -R zsh -t "$HOME"
```

## Next steps

- Commit this README or modify it for your preferred workflow.
- Consider adding a `bootstrap.sh` script to automate install steps (clone, backup, stow).

---

If you'd like, I can commit this README and open a branch for the change.
