{ inputs, config, pkgs, lib, nixvim, ... }:

let
	dev = import ./modules/dev/global.nix {
		inherit inputs config pkgs lib;
	};
	cava = import ./modules/cava.nix {
		inherit inputs config pkgs;
	};
	waybar = import ./modules/waybar.nix {
		inherit inputs config pkgs;
	};
	hyprlock = import ./modules/hyprpaper.nix {
		inherit inputs config pkgs;
	};
	hyprpaper = import ./modules/hyprpaper.nix {
		inherit inputs config pkgs;
	};
	hyprland = import ./modules/hyprland.nix {
		inherit inputs config pkgs;
	};
	kitty = import ./modules/kitty.nix {
		inherit inputs config pkgs;
	};
	rofi = import ./modules/rofi.nix {
		inherit inputs config pkgs;
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
		packages = with pkgs; [
			cider
			ghostty
			bat
			grim
			lunar-client
			gvfs
			hyprcursor
			nerd-fonts.fira-code
			nerd-fonts.jetbrains-mono
			nixvim
			obsidian
			openvpn
			pavucontrol
			slurp
			vesktop
			vlc
			xfce.thunar
			xfce.thunar-archive-plugin
			xfce.thunar-volman
			xfce.tumbler
			xfce.xfconf
		];
	};

	nixpkgs.config.allowUnfree = true;
	
	imports = [
		cava
		dev
		hyprland
		hyprpaper
		kitty
		rofi
		waybar
		zsh
	];

	dev = {
		enable = true;
		language = {
			c-cpp = true;
			rust = true;
		};
	};

	xdg.userDirs = {
		enable = true;
		createDirectories = true;
	};

	programs = {
		firefox.enable = true;
		lazygit.enable = true;
	};

	services = {
	};

	catppuccin = {
		accent = "mauve";
		kitty.enable = true;
		hyprland.enable = true;
		bat.enable = true;
		gtk = {
			enable = true;
			icon.enable = true;
		};
		cursors = {
			enable = true;
			accent = "dark";
		};
		rofi.enable = true;
		waybar = {
			enable = true;
			mode = "createLink";
		};
	};


	# Home Manager is pretty good at managing dotfiles. The primary way to manage
	# plain files is through 'home.file'.
	home.file = {
		# # Building this configuration will create a copy of 'dotfiles/screenrc' in
		# # the Nix store. Activating the configuration will then make '~/.screenrc' a
		# # symlink to the Nix store copy.
		# ".screenrc".source = dotfiles/screenrc;

		# # You can also set the file content immediately.
		# ".gradle/gradle.properties".text = ''
		#	 org.gradle.console=verbose
		#	 org.gradle.daemon.idletimeout=3600000
		# '';
	};

	# Home Manager can also manage your environment variables through
	# 'home.sessionVariables'. These will be explicitly sourced when using a
	# shell provided by Home Manager. If you don't want to manage your shell
	# through Home Manager then you have to manually source 'hm-session-vars.sh'
	# located at either
	#
	#	~/.nix-profile/etc/profile.d/hm-session-vars.sh
	#
	# or
	#
	#	~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
	#
	# or
	#
	#	/etc/profiles/per-user/raphael/etc/profile.d/hm-session-vars.sh
	#
	home.sessionVariables = {
		EDITOR = "neovim";
	};

	fonts.fontconfig.enable = true;
	# Let Home Manager install and manage itself.
	programs.home-manager.enable = true;
}
