{ system, inputs, config, pkgs, lib, nixvim, zen-browser, ... }:

let
	dev = import ./modules/dev/global.nix {
		inherit inputs config pkgs lib nixvim;
	};
	package = import ./modules/packages/global.nix {
		inherit system inputs config pkgs lib zen-browser;
	};
	window-manager = import ./modules/window-manager/global.nix {
		inherit inputs config pkgs lib;
	};
	zsh = import ./modules/shell/zsh.nix {
		inherit inputs config pkgs;
	};
in
{
	home = {
		username = "raphael";
		homeDirectory = "/home/raphael";
		stateVersion = "24.05";
	sessionVariables.EDITOR = "neovim";
	};

	nixpkgs.config.allowUnfree = true;

#	home.packages = with pkgs; [
#		cider
#		lunar-client
#		zen-browser
#	];
	
	imports = [
		dev
		package
		window-manager
		zsh
	];

	application = {
		enable = true;
		kitty = true;
		cava = true;
	};

	dev = {
		enable = true;
		language = {
			c-cpp = true;
			rust = true;
		};
	};

	window-manager = {
		enable = true;
		hyprland = true;
		hyprpaper = true;
		rofi = true;
		steam = true;
		thunar = true;
		waybar = true;
	};

	catppuccin.accent = "mauve";

	fonts.fontconfig.enable = true;
	programs.home-manager.enable = true;
}
