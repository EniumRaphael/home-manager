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
		nerdfonts
		neovim
	];

		home.activation.myScript = lib.mkAfter ''
		if [ ! -d ~/.local/share/nvim/lazy/lazy.nvim ]; then
			echo "neovim: Adding lazy package manager..."
			${pkgs.git}/bin/git clone https://github.com/folke/lazy.nvim.git ~/.local/share/nvim/lazy/lazy.nvim 1> /dev/null
		fi

		if [ ! -d "$HOME/.config/nvim" ]; then
			echo "neovim: Adding configuration for neovim..."
			${pkgs.git}/bin/git clone git@github.com:EniumRaphael/neovimconf.git ~/.config/nvim 1> /dev/null
		else
			echo "neovim: pulling the update for neovim..."
			cd $HOME/.config/nvim
			${pkgs.git}/bin/git pull 1> /dev/null
		fi
	'';

}
