{ inputs, config, pkgs, lib, ... }:

let
	cfg = config.application.steam;
in
{
	config = lib.mkIf cfg {
		programs.steam = {
			enable = true;
			gamescopeSession.enable = true;
		};
		programs.gamemode.enable = true;
		home.packages = with pkgs; [
			mangohud
		];
	};
}
