{ system, inputs, config, pkgs, lib, zen-browser, ... }:

let
	arch = import ./arch.nix {
		inherit system inputs config pkgs lib zen-browser;
	};
	cava = import ./cava.nix {
		inherit inputs config pkgs lib;
	};
	kitty = import ./kitty.nix {
		inherit inputs config pkgs lib;
	};
	cfg = config.application;
in
{
	imports = [
		arch
		cava
		kitty
	];

	options.application = {
		enable = lib.mkOption {
			type = lib.types.bool;
			default = false;
			description = "Enable the default applications";
		};
		kitty = lib.mkOption {
			type = lib.types.bool;
			default = false;
			description = "Enable the kitty terminal emulator";
		};
		cava = lib.mkOption {
			type = lib.types.bool;
			default = false;
			description = "Enable the cava audio visualiser";
		};
	};

	config = lib.mkIf cfg.enable {
		home.packages = with pkgs; [
			element-desktop
			slack
			nerd-fonts.fira-code
			nerd-fonts.jetbrains-mono
			obsidian
			openvpn
			ungoogled-chromium
			vesktop
			vlc
		];
	};
}
