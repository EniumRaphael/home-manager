{ system, inputs, config, pkgs, lib, zen-browser, ... }:

let
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
		cava
		kitty
	];

	options.application = {
		enable = lib.mkOption {
			type = lib.types.bool;
			default = false;
			description = "Enable the default applications";
		};
		cider = lib.mkOption {
			type = lib.types.bool;
			default = false;
			description = "Enable the Cider Music";
		};
		teamspeak = lib.mkOption {
			type = lib.types.bool;
			default = false;
			description = "enable the teamspealk client";
		};
		prismlauncher = lib.mkOption {
			type = lib.types.bool;
			default = false;
			description = "Enable the Prism Launcher";
		};
		zed = lib.mkOption {
			type = lib.types.bool;
			default = false;
			description = "Enable the Zed Editor";
		};
		obs = lib.mkOption {
			type = lib.types.bool;
			default = false;
			description = "Enable the OBS Studio";
		};
		slack = lib.mkOption {
			type = lib.types.bool;
			default = false;
			description = "Enable the Slack";
		};
		element = lib.mkOption {
			type = lib.types.bool;
			default = false;
			description = "Enable the Element Desktop";
		};
		fonts = lib.mkOption {
			type = lib.types.bool;
			default = false;
			description = "Enable the Nerd Fonts";
		};
		obsidian = lib.mkOption {
			type = lib.types.bool;
			default = false;
			description = "Enable the Obsidian";
		};
		openvpn = lib.mkOption {
			type = lib.types.bool;
			default = false;
			description = "Enable the OpenVPN";
		};
		ungoogled = lib.mkOption {
			type = lib.types.bool;
			default = false;
			description = "Enable the Ungoogled Chromium";
		};
		vesktop = lib.mkOption {
			type = lib.types.bool;
			default = false;
			description = "Enable the Vesktop";
		};
		vlc = lib.mkOption {
			type = lib.types.bool;
			default = false;
			description = "Enable the VLC";
		};
		evince = lib.mkOption {
			type = lib.types.bool;
			default = false;
			description = "Enable the evince";
		};
		imv = lib.mkOption {
			type = lib.types.bool;
			default = false;
			description = "Enable the IMV";
		};
		wireshark = lib.mkOption {
			type = lib.types.bool;
			default = false;
			description = "Enable the wireshark";
		};
		zen = lib.mkOption {
			type = lib.types.bool;
			default = false;
			description = "Enable the zen web browser";
		};
		cava = lib.mkOption {
			type = lib.types.bool;
			default = false;
			description = "Enable the cava audio visualiser";
		};
		kitty = lib.mkOption {
			type = lib.types.bool;
			default = false;
			description = "Enable the kitty terminal emulator";
		};
	};

	config = lib.mkIf cfg.enable {
		home.packages = with pkgs; 
			(if cfg.cider then [ cider ] else [])
			++ (if cfg.prismlauncher then [ prismlauncher openjdk ] else [])
			++ (if cfg.element then [ element-desktop ] else [])
			++ (if cfg.fonts then with pkgs.nerd-fonts; [ fira-code jetbrains-mono ] else [])
			++ (if cfg.obsidian then [ obsidian ] else [])
			++ (if cfg.openvpn then [ openvpn ] else [])
			++ (if cfg.slack then [ slack ] else [])
			++ (if cfg.ungoogled then [ ungoogled-chromium ] else [])
			++ (if cfg.vesktop then [ vesktop ] else [])
			++ (if cfg.teamspeak then [ teamspeak_client ] else [])
			++ (if cfg.vlc then [ vlc ] else [])
			++ (if cfg.evince then [ evince ] else [])
			++ (if cfg.imv then [ imv ] else [])
			++ (if cfg.wireshark then [ wireshark-cli ] else [])
			++ (if cfg.zed then [ zed-editor ] else [])
			++ (if cfg.zen then [ zen-browser ] else []);
		programs = {
			obs-studio = lib.mkIf cfg.obs {
				enable = true;
				plugins = with pkgs.obs-studio-plugins; [
					wlrobs
					obs-backgroundremoval
					obs-pipewire-audio-capture
				];
			};
		};
	};
}
