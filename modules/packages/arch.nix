{ system, inputs, config, pkgs, lib, zen-browser, ... }:

let
	cfg = pkgs.stdenv.hostPlatform.is64bit;
in
{
	config = lib.mkMerge [
		(lib.mkIf (cfg && config.application.enable) {
			home.packages = with pkgs; [
				cider
				lunar-client
				zen-browser
			];
		})

		(lib.mkIf (!cfg && config.application.enable) {
			programs.firefox.enable = true;
		})
	];
}
