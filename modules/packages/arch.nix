{ system, inputs, config, pkgs, lib, zen-browser, ... }:

let
	cfg = pkgs.stdenv.hostPlatform.isAarch;
in
{
	config = lib.mkMerge [
		(lib.mkIf (!cfg && config.application.enable) {
			home.packages = with pkgs; [
				cider
				lunar-client
				slack
				zen-browser
			];
		})

		(lib.mkIf (!cfg && config.application.enable) {
			programs.firefox.enable = true;
		})
	];
}
