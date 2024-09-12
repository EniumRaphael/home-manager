{ config, pkgs, lib, ... }:

let
	application = import ./applications/application.nix { inherit config pkgs lib; };
	package = import ./package/package.nix { inherit config pkgs lib; };
in
{
	imports = [
		application
		package
	];

	home.packages = with pkgs; [
		git
		neovim
		nerdfonts
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
