#!/bin/bash
set -euo pipefail

echo "🚀 Starting CachyOS core package installation..."
echo "   Environment: Cosmic DE │ Limine bootloader │ btrfs"
echo ""

# Cache sudo credentials and keep them alive for the full duration of the script
sudo -v
(while true; do
	sudo -n true
	sleep 60
	kill -0 "$PPID" 2>/dev/null || exit
done) &

# ── Packages ─────────────────────────────────────────────────────────────────
echo "📦 Installing packages via paru..."
paru -S --needed --noconfirm --sudoloop \
	bat \
	claude-code \
	claude-desktop-bin \
	cliphist \
	code \
	docker \
	duf \
	dust \
	eza \
	fd \
	fisher \
	fuzzel \
	fzf \
	git-crypt \
	git-delta \
	github-cli \
	github-desktop \
	gnome-keyring \
	lazygit \
	micro \
	nvm \
	nvtop \
	onlyoffice-bin \
	ripgrep \
	shfmt \
	starship \
	ttf-cascadia-code-nerd \
	ttf-firacode-nerd \
	vlc \
	wl-clipboard \
	yq \
	zellij \
	zoxide

echo "✅ Packages installed."
echo ""

# ── Shell setup ───────────────────────────────────────────────────────────────
echo "🐚 Configuring shell environments..."

# Bash (fallback)
if grep -qF 'nvm/init-nvm.sh' ~/.bashrc 2>/dev/null; then
	echo "  → bash: nvm already in ~/.bashrc, skipping"
else
	echo "source /usr/share/nvm/init-nvm.sh" >>~/.bashrc
	echo "  → bash: nvm sourced in ~/.bashrc"
fi
if grep -qF 'zoxide init bash' ~/.bashrc 2>/dev/null; then
	echo "  → bash: zoxide already in ~/.bashrc, skipping"
else
	echo 'eval "$(zoxide init bash)"' >>~/.bashrc
	echo "  → bash: zoxide init added to ~/.bashrc"
fi

# Fish config: NVM auto-detection + Cosmic DE env
mkdir -p ~/.config/fish

if grep -qF '__auto_nvm' ~/.config/fish/config.fish 2>/dev/null; then
	echo "  → fish: config.fish already configured, skipping"
else
	cat >>~/.config/fish/config.fish <<'EOF'

# Set XDG for Cosmic DE (fixes open command)
set -gx XDG_CURRENT_DESKTOP COSMIC

# Set default editor
set -gx EDITOR micro
set -gx VISUAL micro

# Zoxide (smarter cd)
zoxide init fish | source

# NVM auto-detection
function __auto_nvm --on-variable PWD
    if test -f .nvmrc
        nvm install
        nvm use
    end
end

# Starship Terminal
starship init fish | source

# Abbreviations (shortcuts)
abbr -a g git
abbr -a gst git status
abbr -a ga git add
abbr -a gc git commit
abbr -a gp git push
abbr -a gl git pull
abbr -a gco git checkout
abbr -a gcam 'git commit -am' 
abbr -a ll 'eza -la --icons --git'
abbr -a lt 'eza --tree --level=2 --icons'
abbr -a cat bat
abbr -a df duf
abbr -a du dust
abbr -a find fd
abbr -a grep rg


EOF
	echo "  → fish: config.fish written"
fi

# Starship prompt theme
echo "⭐ Configuring Starship prompt..."
if [[ -f ~/.config/starship.toml ]]; then
	echo "  → ~/.config/starship.toml already exists, skipping"
else
	starship preset gruvbox-rainbow -o ~/.config/starship.toml
	echo "  → starship: gruvbox-rainbow preset written to ~/.config/starship.toml"
fi

# CachyOS glyph — starship ships a ribbon emoji (🎗️) as the default for
# CachyOS since no Nerd Font has a dedicated glyph. Reuse Arch's (󰣇).
# Inserted after the Arch line in [os.symbols] so it lives with its siblings.
if grep -qE '^CachyOS\s*=' ~/.config/starship.toml; then
	echo "  → starship: CachyOS glyph already set, skipping"
elif grep -qE '^Arch\s*=' ~/.config/starship.toml; then
	sed -i '/^Arch = /a CachyOS = "󰣇"' ~/.config/starship.toml
	echo "  → starship: CachyOS glyph added (reuses Arch: 󰣇)"
else
	echo "  → starship: no [os.symbols] Arch entry found — skipping CachyOS patch"
fi
echo ""

# All fisher plugins — must be invoked inside fish since fisher is a fish function
echo "🐟 Installing fish plugins via fisher..."
fish -c "
    fisher install jorgebucaran/nvm.fish
    fisher install PatrickF1/fzf.fish
    fisher install jorgebucaran/autopair.fish
    fisher install meaningful-ooo/sponge
    fisher install franciscolourenco/done
    fisher install acomagu/fish-async-prompt
"
echo "  → 6 plugins installed"
echo ""

# ── VS Code extensions ────────────────────────────────────────────────────────
# Note: 'code' is the binary from the extra/code package on CachyOS.
# If extensions fail, verify with: which code  (may be 'code-oss' on some setups)
echo "🧩 Installing VS Code extensions..."

code \
	--install-extension Anthropic.claude-code \
	--install-extension christian-kohler.path-intellisense \
	--install-extension dbaeumer.vscode-eslint \
	--install-extension editorconfig.editorconfig \
	--install-extension esbenp.prettier-vscode \
	--install-extension gruntfuggly.todo-tree \
	--install-extension mechatroner.rainbow-csv \
	--install-extension mikestead.dotenv \
	--install-extension mk12.better-git-line-blame \
	--install-extension mkhl.shfmt \
	--install-extension ms-azuretools.vscode-docker \
	--install-extension ms-python.python \
	--install-extension oderwat.indent-rainbow \
	--install-extension redhat.vscode-yaml \
	--install-extension tamasfe.even-better-toml \
	--install-extension usernamehw.errorlens \
	--install-extension yzhang.markdown-all-in-one

echo "  → 17 extensions installed"
echo ""

# ── Alacritty ────────────────────────────────────────────────────────────────
echo "🖥️  Configuring Alacritty terminal..."

if [[ -f ~/.config/alacritty/alacritty.toml ]]; then
	echo "  → ~/.config/alacritty/alacritty.toml already exists, skipping"
else
	mkdir -p ~/.config/alacritty
	cat >~/.config/alacritty/alacritty.toml <<'EOF'
[font]
normal = { family = "FiraCode Nerd Font", style = "Regular" }
bold = { family = "FiraCode Nerd Font", style = "Bold" }
italic = { family = "FiraCode Nerd Font", style = "Light" }
size = 13.0

[font.offset]
x = 0
y = 0
EOF
	echo "  → ~/.config/alacritty/alacritty.toml written"
fi
echo ""

# ── Clipboard stack (cliphist + wl-clipboard + fuzzel) ──────────────────────
# Super+V picker: fuzzel dmenu → cliphist decode → wl-copy.
# Watcher runs at login via XDG autostart; keybind is set manually (COSMIC
# shortcut config is RON and not safe to edit programmatically).
echo "📋 Configuring clipboard watcher autostart..."

CLIPHIST_AUTOSTART="$HOME/.config/autostart/cliphist.desktop"
if [[ -f "$CLIPHIST_AUTOSTART" ]]; then
	echo "  → $CLIPHIST_AUTOSTART already exists, skipping"
else
	mkdir -p "$(dirname "$CLIPHIST_AUTOSTART")"
	cat >"$CLIPHIST_AUTOSTART" <<'EOF'
[Desktop Entry]
Type=Application
Name=cliphist
Exec=sh -c 'wl-paste --watch cliphist store'
X-GNOME-Autostart-enabled=true
NoDisplay=true
EOF
	echo "  → $CLIPHIST_AUTOSTART written"
fi

# fuzzel theme — Catppuccin-ish palette to match COSMIC's default dark theme
FUZZEL_CONFIG="$HOME/.config/fuzzel/fuzzel.ini"
if [[ -f "$FUZZEL_CONFIG" ]]; then
	echo "  → $FUZZEL_CONFIG already exists, skipping"
else
	mkdir -p "$(dirname "$FUZZEL_CONFIG")"
	cat >"$FUZZEL_CONFIG" <<'EOF'
[colors]
background=1e1e2eff
text=cdd6f4ff
match=89b4faff
selection=313244ff
selection-text=cdd6f4ff
selection-match=89b4faff
border=89b4faff
EOF
	echo "  → $FUZZEL_CONFIG written (dark theme)"
fi
echo ""

# ── Docker ────────────────────────────────────────────────────────────────────
echo "🐳 Configuring Docker..."

systemctl is-enabled --quiet docker 2>/dev/null &&
	echo "  → docker.service already enabled, skipping" ||
	{ sudo systemctl enable docker && echo "  → docker.service enabled at boot"; }

groups "$USER" | grep -qw docker &&
	echo "  → $USER already in docker group, skipping" ||
	{ sudo usermod -aG docker "$USER" && echo "  → $USER added to docker group"; }
echo ""

# ── Git ───────────────────────────────────────────────────────────────────────
echo "🔀 Configuring Git..."

git config --global core.editor "code --wait"
git config --global merge.tool vscode
git config --global mergetool.vscode.cmd 'code --wait $MERGED'
git config --global diff.tool vscode
git config --global difftool.vscode.cmd 'code --wait --diff $LOCAL $REMOTE'
echo "  → git: VS Code set as editor, diff tool, and merge tool"
git config --global core.pager delta
git config --global interactive.diffFilter "delta --color-only"
git config --global delta.navigate true
git config --global delta.line-numbers true
git config --global delta.side-by-side true
git config --global merge.conflictstyle diff3
echo "  → git: git-delta set for git diff and log enhancements"
git config --global url."git@github.com:".insteadOf "https://github.com/"
echo "  → git: always use ssh instead of https"
echo ""

# ── SSH key ───────────────────────────────────────────────────────────────────
echo "🔑 Setting up SSH key pair..."

if [[ -f ~/.ssh/id_ed25519 ]]; then
	echo "  → ~/.ssh/id_ed25519 already exists, skipping"
else
	mkdir -p ~/.ssh
	chmod 700 ~/.ssh
	ssh-keygen -t ed25519 -C "imran@imranc.io" -f ~/.ssh/id_ed25519 -N ""
	echo "  → ed25519 keypair generated"
fi

if [[ -z "${SSH_AUTH_SOCK:-}" ]]; then
	eval "$(ssh-agent -s)" >/dev/null
fi
ssh-add ~/.ssh/id_ed25519 2>/dev/null && echo "  → key loaded into ssh-agent" || echo "  → run manually: ssh-add ~/.ssh/id_ed25519"
echo ""
echo "  📋 Add this public key to GitHub → https://github.com/settings/ssh/new"
echo ""
cat ~/.ssh/id_ed25519.pub
echo "  💡 You can generate a Personal Access Token here https://github.com/settings/tokens"
echo "     The minimum required scopes are 'repo', 'read:org', 'admin:public_key'"
echo "     Run 'gh auth login' → GitHub.com → SSH → ~/.ssh/id_ed25519.pub"
echo ""

# ── Summary ───────────────────────────────────────────────────────────────────
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✨ Setup complete!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "📦 Packages installed:"
echo "   bat                — Better cat with syntax highlighting"
echo "   claude-code        — Claude AI CLI"
echo "   claude-desktop-bin — Claude Desktop app"
echo "   cliphist           — Wayland clipboard history store"
echo "   code               — VS Code (OSS)"
echo "   docker             — Container engine"
echo "   duf                — Better df (disk usage overview)"
echo "   dust               — Better du (disk usage tree)"
echo "   eza                — Better ls (icons, git status)"
echo "   fd                 — Better find"
echo "   fisher             — Fish plugin manager"
echo "   fuzzel             — Wayland dmenu-style launcher (clipboard picker UI)"
echo "   fzf                — Fuzzy finder (used by fzf.fish plugin)"
echo "   git-crypt          — Git repo encryption"
echo "   git-delta          — Enhanced diff/log viewer"
echo "   github-cli         — GitHub CLI (gh)"
echo "   github-desktop     — GitHub Desktop GUI"
echo "   gnome-keyring      — Credential/secrets manager"
echo "   lazygit            — Terminal UI for git"
echo "   micro              — Terminal text editor (default \$EDITOR)"
echo "   nvm                — Node version manager"
echo "   nvtop              — GPU process monitor"
echo "   onlyoffice-bin     — Office suite"
echo "   ripgrep            — Better grep (rg)"
echo "   shfmt              — Shell script formatter"
echo "   starship           — Cross-shell prompt"
echo "   ttf-cascadia-code-nerd — Cascadia Code Nerd Font"
echo "   ttf-firacode-nerd  — FiraCode Nerd Font (used by Alacritty)"
echo "   vlc                — Media player"
echo "   wl-clipboard       — Wayland clipboard CLI (wl-copy / wl-paste)"
echo "   yq                 — YAML/JSON/TOML processor (like jq for YAML)"
echo "   zellij             — Terminal multiplexer (tmux alternative)"
echo "   zoxide             — Smarter cd that learns your habits (z)"
echo ""
echo "🧩 VS Code extensions:"
echo "   Anthropic.claude-code               — Claude Code IDE integration"
echo "   christian-kohler.path-intellisense  — Path autocomplete"
echo "   dbaeumer.vscode-eslint              — ESLint integration"
echo "   editorconfig.editorconfig           — EditorConfig support"
echo "   esbenp.prettier-vscode              — Prettier formatter"
echo "   gruntfuggly.todo-tree               — TODO/FIXME tree view"
echo "   mechatroner.rainbow-csv             — CSV highlighting"
echo "   mikestead.dotenv                    — .env file support"
echo "   mk12.better-git-line-blame          — Inline git blame"
echo "   mkhl.shfmt                          — Shell script formatting"
echo "   ms-azuretools.vscode-docker         — Docker support"
echo "   ms-python.python                    — Python language support"
echo "   oderwat.indent-rainbow              — Indent level highlighting"
echo "   redhat.vscode-yaml                  — YAML language support"
echo "   tamasfe.even-better-toml            — TOML language support"
echo "   usernamehw.errorlens                — Inline error/warning display"
echo "   yzhang.markdown-all-in-one          — Markdown editing suite"
echo ""
echo "🔧 Shell configuration:"
echo "   ~/.bashrc                       — nvm + zoxide init sourced (bash fallback)"
echo "   ~/.config/fish/config.fish      — NVM auto-detect + zoxide + starship + EDITOR=micro + XDG_CURRENT_DESKTOP=COSMIC + abbrs"
echo "   ~/.config/starship.toml         — gruvbox-rainbow preset + CachyOS glyph override (󰣇)"
echo "   ~/.config/alacritty/alacritty.toml — FiraCode Nerd Font, size 13"
echo "   fish plugins:"
echo "     jorgebucaran/nvm.fish       — Node version manager"
echo "     PatrickF1/fzf.fish          — Ctrl+R history, file search, git log"
echo "     jorgebucaran/autopair.fish  — Auto-close brackets/quotes"
echo "     meaningful-ooo/sponge       — Auto-clean failed cmds from history"
echo "     franciscolourenco/done      — Desktop notifications for long cmds"
echo "     acomagu/fish-async-prompt   — Async prompt for snappiness"
echo ""
echo "🔑 SSH key:"
echo "   ~/.ssh/id_ed25519      — ed25519 keypair (no passphrase)"
echo "   ~/.ssh/id_ed25519.pub  — add to https://github.com/settings/ssh/new"
echo ""
echo "🔀 Git (global):"
echo "   core.editor              — code --wait"
echo "   diff.tool / merge.tool   — vscode"
echo "   core.pager               — delta (side-by-side, line numbers)"
echo "   interactive.diffFilter   — delta --color-only"
echo "   merge.conflictstyle      — diff3"
echo ""
echo "🐳 Docker:"
echo "   docker.service  — enabled at boot"
echo "   $USER           — added to 'docker' group"
echo ""
echo "📋 Clipboard (Super+V picker):"
echo "   Packages:  cliphist · wl-clipboard · fuzzel"
echo "   Autostart: ~/.config/autostart/cliphist.desktop"
echo "              (runs: wl-paste --watch cliphist store)"
echo "   Theme:     ~/.config/fuzzel/fuzzel.ini  (dark, matches COSMIC default)"
echo ""
echo "   ⚠️  Manual step — COSMIC shortcut config is not safely editable by script."
echo "   Bind Super+V: Settings → Input → Keyboard → Keyboard Shortcuts →"
echo "                 Custom Shortcuts → Add Shortcut"
echo "   Command:"
echo "     sh -c 'cliphist list | fuzzel --dmenu | cliphist decode | wl-copy'"
echo ""
echo "   Test from a terminal before binding. History only fills once the"
echo "   autostart watcher is running — log out and back in first."
echo ""
echo "💡 zellij SSH workflow:"
echo "   ssh user@host -t 'zellij attach --create main'"
echo "   # Drops you into (or reattaches to) a persistent session named 'main'."
echo "   # Disconnect anytime — session survives. Reconnect and pick up exactly where you left off."
echo ""
echo "⚠️  Log out and back in (or: newgrp docker) to activate docker group."
echo ""
echo "🔄 Restart shell or run: exec fish"
echo ""
