# My dotfiles

Personal dotfiles with modern shell tooling, optimized for Laravel/PHP development. Features fast startup times, smart directory navigation, and modern CLI tools.

## Key Features

(Fill this in)

---

## Quick Start

```bash
git clone git@github.com:freekmurze/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
bin/install
```

---

## What's Included

### Modern CLI Tools

- **fnm** - Fast Node.js version manager
- **bat** - Cat with syntax highlighting
- **eza** - Modern ls replacement with icons
- **ripgrep** - Fast grep alternative
- **fd** - Fast find alternative
- **git-delta** - Better git diffs
- **jq** - JSON processor and formatter
- **yq** - YAML processor and formatter
- **bottom** - Modern system monitor

### Development Tools

- **PHP** - Latest version via Homebrew
- **Composer** - Dependency manager via Homebrew
- **Node.js** - LTS version managed via fnm
- **Laravel Valet** - Local development server
- **MySQL** - Database with auto-start

### QuickLook Plugins

Instant file previews in Finder: code files, markdown, JSON, CSV, patches, and archives.

---

## How It Works

### Symlinked Files

The installation creates symlinks from your home directory to the dotfiles repository. This allows you to version control your configuration while keeping files in their expected locations.

| Symlink Location | Points To | Purpose |
|-----------------|-----------|---------|
| `~/.zshrc` | `~/.dotfiles/home/.zshrc` | Main Zsh configuration |
| `~/.gitconfig` | `~/.dotfiles/home/.gitconfig` | Git configuration with delta diff viewer |
| `~/.global-gitignore` | `~/.dotfiles/home/.global-gitignore` | Global Git ignore patterns |
| `~/.mackup.cfg` | `~/.dotfiles/macos/.mackup.cfg` | Mackup backup configuration |
| `~/.codex/skills` | `~/.dotfiles/config/codex/skills/` | All Codex skills (version-controlled) |
| `~/.codex/AGENTS.md` | `~/.dotfiles/config/codex/AGENTS.md` | Codex configuration |
| `~/.codex/laravel-php-guidelines.md` | `~/.dotfiles/config/codex/laravel-php-guidelines.md` | Laravel coding standards |
| `~/.codex/config.toml` | `~/.dotfiles/config/codex/config.toml` | Codex CLI settings |
| `~/.config/zed/settings.json` | `~/.dotfiles/config/zed/settings.json` | Zed editor settings |
| `~/.config/zed/keymap.json` | `~/.dotfiles/config/zed/keymap.json` | Zed custom keybindings |
| `~/.config/ghostty/config` | `~/.dotfiles/config/ghostty/config` | Ghostty terminal settings |

To manually symlink the Zed configuration (if not using `bin/install`):

```bash
mkdir -p ~/.config/zed
ln -sf ~/.dotfiles/config/zed/settings.json ~/.config/zed/settings.json
ln -sf ~/.dotfiles/config/zed/keymap.json ~/.config/zed/keymap.json
```

### Sourced Files

These files are loaded by `.zshrc` but remain in the dotfiles directory:

- `home/.aliases` - Shell command aliases
- `home/.functions` - Custom shell functions
- `home/.exports` - Environment variables

## Daily Usage

### Laravel/PHP Shortcuts

```bash
a                   # php artisan
p                   # Run Pest/PHPUnit tests
c                   # composer
mfs                 # php artisan migrate:fresh --seed
nah                 # git reset --hard; git clean -df
```


---

## Version Management

### Node.js (via fnm)

```bash
fnm install --lts     # Install latest LTS
fnm use lts-latest    # Use latest LTS
fnm install 20        # Install specific version
fnm use 20            # Switch to specific version
fnm list              # Show installed versions
```

### PHP & Composer (via Homebrew)

```bash
brew upgrade php      # Update PHP to latest
brew upgrade composer # Update Composer
```

---

## Package Management

All Homebrew packages are declared in `config/Brewfile`. To add a new tool:

```bash
echo 'brew "visual-studio-code"' >> ~/.dotfiles/config/Brewfile
brew bundle --file=~/.dotfiles/config/Brewfile
```

**Complete package list:**

- **Core**: node, php, composer, pkg-config, wget, httpie, ncdu, hub, ack, doctl, 1password-cli, git-secret, imagemagick, mysql, yarn, ghostscript, mackup
- **Modern CLI**: zoxide, bat, eza, ripgrep, fd, git-delta, fnm, fzf, direnv, jq, yq, bottom, zsh-autosuggestions
- **QuickLook**: qlcolorcode, qlstephen, qlmarkdown, quicklook-json, qlprettypatch, quicklook-csv, betterzip, suspicious-package
- **PHP Extensions**: imagick, memcached, xdebug, redis
- **Global npm**: agent-browser
- **Global Composer**: laravel/envoy, spatie/phpunit-watcher, laravel/valet

---

## Codex Integration

### What's Included

- **Codex instructions** - `AGENTS.md` with working preferences and GitHub guidance
- **Codex CLI config** - `config.toml` for model and reasoning defaults
- **Version-controlled skills** - Entire `~/.codex/skills` directory symlinked to dotfiles
- **Laravel guidance** - Shared PHP and Laravel coding standards

### Skills (Version Controlled)

All skills are stored in `config/codex/skills/` and version-controlled with your dotfiles. When you run the installer on a new Mac, all skills are immediately available.

**Custom Skills:**
- `ray-skill` - Ray debugging integration
- `fix-github-issue` - GitHub issue automation
- `convert-issue-to-discussion` - GitHub workflow helpers

**Imported Skills:**
- `vercel-labs/agent-skills` - Web design guidelines and React best practices
- `anthropic/skills` - Frontend design and skill creation tools
- `vercel-labs/agent-browser` - Browser automation
- `expo/skills` - React Native with Expo
- `callstackincubator/agent-skills` - React Native performance
- `coreyhaines31/marketingskills` - Copywriting and programmatic SEO
- `copy-editing` - Marketing copy editing
- `copywriting` - Marketing copywriting
- `frontend-design` - Frontend design patterns
- `pdf` - PDF manipulation
- `seo-audit` - SEO auditing
- `web-design-guidelines` - Web design best practices

### Adding New Skills

```bash
# Install a new skill (adds directly to your dotfiles)
npx skills add <owner/repo>

# Commit to version control
cd ~/.dotfiles
git add config/codex/skills/
git commit -m "Add new skill"
git push
```

Browse more skills at [skills.sh](https://skills.sh)

---

## Customization

### Personal Aliases & Functions

Create custom configurations that won't be committed:

```bash
mkdir -p ~/.dotfiles-custom/shell
code ~/.dotfiles-custom/shell/.aliases
```

These files are automatically loaded by `.zshrc` if they exist.

### Project-Specific Variables

Use `direnv` for automatic environment loading:

```bash
cd my-project
echo 'export DEBUG=true' > .envrc
direnv allow
```

Variables load when you enter the directory and unload when you leave.

---

## Post-Installation

1. **Restore settings** (optional): Run `mackup restore` if you have backups

2. **Migrate history** (upgrading only): Run `migration/migrate-z-to-zoxide.sh` if you have `~/.z`

---

## Tool Comparisons

| Old Tool | New Tool | Why Better |
|----------|----------|------------|
| z.sh / autojump | zoxide | Smarter frecency algorithm, Rust speed |
| nvm | fnm | 40x faster, simpler, Rust-based |
| cat | bat | Syntax highlighting, git integration |
| ls | eza | Icons, tree view, git status |
| grep | ripgrep | 5-10x faster, respects .gitignore |
| find | fd | Simpler syntax, 10x faster |
| diff | delta | Side-by-side diffs, syntax highlighting |
| htop | bottom | Better UI, graphs, Rust-based |

---

## Utilities

The `bin/` directory contains helper scripts:

- **install** - Main installation script (idempotent, safe to re-run)
- **update** - Update dotfiles, Homebrew, npm, and Composer packages
- **doctor** - Health check and diagnostic tool

---

## Migration Notes

If upgrading from an older setup:

1. **Directory history**: Run `migration/migrate-z-to-zoxide.sh` to import your `~/.z` data
2. **Version managers**:
   - fnm replaces nvm for Node.js
   - Homebrew manages PHP/Composer (no more compilation or mise)
3. **Terminal**: Ghostty config can be symlinked from dotfiles if you use Ghostty
4. **Codex Skills**: Now version-controlled in `config/codex/skills/` and symlinked to `~/.codex/skills`

---

## Credits

Created by [Freek Van der Herten](https://github.com/freekmurze). Used by many at [Spatie](https://spatie.be).

See `config/Brewfile` for complete package list.
