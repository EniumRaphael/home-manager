{ config, pkgs, lib, ... }:

{
	home.packages = with pkgs; [
		bat
		brightnessctl
		btop
		burp
		cargo
		clang
		docker
		eza
		fzf
		git
		grim
		htop
		lazygit
		lldb
		llvm
		metasploit
		ncdu
		neofetch
		neovim
		nerdfonts
		nmap
		norminette
		openvpn
		python3
		ripgrep
		rustc
		seclists
		slurp
		tree
		valgrind
		vesktop
	];

	home.activation.myScript = lib.mkAfter ''
		echo "Checking neovim installation..."
		if [ ! -d ~/.local/share/nvim/lazy/lazy.nvim ]; then
			${pkgs.git}/bin/git clone https://github.com/folke/lazy.nvim.git ~/.local/share/nvim/lazy/lazy.nvim
			echo "neovim: Adding lazy package manager..."
		fi

		if [ ! -d "$HOME/.config/nvim" ]; then
			${pkgs.git}/bin/git clone https://github.com/EniumRaphael/neovimconf.git ~/.config/nvim
			echo "neovim: Adding configuration for neovim..."
		fi
	'';

}
