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
		zen = lib.mkOption {
			type = lib.types.bool;
			default = false;
			description = "Enable the Zen Browser";
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
		firefox = lib.mkOption {
			type = lib.types.bool;
			default = false;
			description = "Enable the Firefox web browser";
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
		if (cfg.cider) then {
			home.packages = with pkgs; [
				cider
			];
		};
		if (cfg.prismlauncher) then {
			home.packages = with pkgs; [
				prismlauncher
			];
		};
		if (cfg.element) then {
			home.packages = with pkgs; [
				element-desktop
			];
		};
		if (cfg.fonts) then {
			home.packages = with pkgs.nerd-fonts; [
				fira-code
				jetbrains-mono
			];
		};
		if (cfg.obsidian) then {
			home.packages = with pkgs; [
				obsidian
			];
		};
		if (cfg.openvpn) then {
			home.packages = with pkgs; [
				openvpn
			];
		};
		if (cfg.firefox) then {
			programs.firefox.enable = true;
		};
		if (cfg.obs) then {
			programs.obs-studio = {
				enable = true;
				plugins = with pkgs.obs-studio-plugins; [
					wlrobs
					obs-backgroundremoval
					obs-pipewire-audio-capture
				];
			};
		};
		if (cfg.slack) then {
			home.packages = with pkgs; [
				slack
			];
		};
		if (cfg.ungoogled) then {
			home.packages = with pkgs; [
				ungoogled-chromium
			];
		};
		if (cfg.vesktop) then {
			home.packages = with pkgs; [
				vesktop
			];
		};
		if (cfg.vlc) then {
			home.packages = with pkgs; [
				vlc
			];
		};
		if (cfg.zed) then {
			home.packages = with pkgs; [
				zed-editor
			];
		};
		if (cfg.zen) then {
			home.packages = with pkgs; [
				zen-browser
			];
		};
	};
}
