#!/bin/bash

source "$(dirname "$0")/helpers.sh"

PKG_MGR=$(get_pkg_mgr)

# Air (Go Hot Reload)
install_air() {
	go install github.com/air-verse/air@latest > >(write_to_log) 2>&1
}
handle_install "Air" install_air air

# UV (Python Package Manager)
install_uv() {
	curl -Ls https://astral.sh/uv/install.sh | bash > >(write_to_log) 2>&1

	set_path '$HOME/.local/bin'

	local uv_env="$HOME/.local/bin/env"
	if test -f "$uv_env"; then
		echo "🔁 Sourcing uv env config from $uv_env"
		# shellcheck source=/root/.local/bin/env
		source "$uv_env"
	else
		echo "⚠️ uv env file not found at $uv_env"
	fi
}
handle_install "uv" install_uv uv

# PNPM
install_pnpm() {
	curl -fsSL https://get.pnpm.io/install.sh | sh - > >(write_to_log) 2>&1
	set_alias "pn" "pnpm"
}
handle_install "PNPM" install_pnpm pnpm

# Neovim
install_neovim() {
	$PKG_MGR install build-essential -y > >(write_to_log) 2>&1 # gcc for lazyvim

	curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz > >(write_to_log) 2>&1
	sudo rm -rf /opt/nvim
	sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
	sudo mv /opt/nvim-linux-x86_64 /opt/nvim
	set_path "/opt/nvim/bin"
}
handle_install "Neovim" install_neovim nvim

# Tmux and TPM
install_tmux() {
	$PKG_MGR install tmux -y > >(write_to_log) 2>&1
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm > >(write_to_log) 2>&1

	tmux start-server
	tmux new-session -d
	"$HOME/.tmux/plugins/tpm/bin/install_plugins" > >(write_to_log) 2>&1
	tmux source-file "$HOME/.config/tmux/tmux.conf"
	tmux kill-server

}
handle_install "tmux" install_tmux tmux

# Ghostty
install_ghostty() {
	$PKG_MGR install libgtk-4-dev libadwaita-1-dev git blueprint-compiler gettext libxml2-utils libonig5 -y > >(write_to_log) 2>&1
	curl -fsSL https://raw.githubusercontent.com/mkasberg/ghostty-ubuntu/HEAD/install.sh | bash > >(write_to_log) 2>&1
}
handle_install "Ghostty" install_ghostty ghostty

# Docker
install_docker() {
	if ! command -v docker &>/dev/null; then
		curl -fsSL https://get.docker.com -o get-docker.sh > >(write_to_log) 2>&1
		sudo sh get-docker.sh > >(write_to_log) 2>&1

		# Compose
		$PKG_MGR install docker-compose-plugin -y > >(write_to_log) 2>&1

		# Groups
		getent group docker >/dev/null || sudo groupadd docker
		CURRENT_USER=$(whoami)
		sudo usermod -aG docker "$CURRENT_USER"

		# Clean up
		rm -f get-docker.sh
	else
		echo "Docker is already installed."
	fi
}
handle_install "Docker" install_docker docker

# pgAdmin 4 (Web Mode)
install_pgadmin() {
	if dpkg -l | grep -q pgadmin4-web && [ -d /usr/pgadmin4 ]; then
		echo "pgAdmin 4 is already installed."
	else
		# Add pgAdmin repository GPG key
		if [ ! -f /usr/share/keyrings/packages-pgadmin-org.gpg ]; then
			curl -fsS https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo gpg --dearmor -o /usr/share/keyrings/packages-pgadmin-org.gpg > >(write_to_log) 2>&1
		fi

		# Add repository if not already added
		if [ ! -f /etc/apt/sources.list.d/pgadmin4.list ]; then
			sudo sh -c 'echo "deb [signed-by=/usr/share/keyrings/packages-pgadmin-org.gpg] https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" > /etc/apt/sources.list.d/pgadmin4.list' > >(write_to_log) 2>&1
		fi

		# Install pgAdmin 4 web
		$PKG_MGR update > >(write_to_log) 2>&1
		$PKG_MGR install pgadmin4-web -y > >(write_to_log) 2>&1

		# Configure web server (non-interactive)
		echo "Setting up pgAdmin web server..."
		sudo /usr/pgadmin4/bin/setup-web.sh --yes > >(write_to_log) 2>&1 || true

		echo ""
		echo "🌐 pgAdmin 4 available at: http://localhost/pgadmin4"
		echo "📝 Start Apache with: sudo service apache2 start"
	fi
}
handle_install "pgAdmin 4" install_pgadmin "pgadmin4"

# TODO: Lazygit
# TODO: grep / fzf
# TODO: Lua / hererocks / luarocks
