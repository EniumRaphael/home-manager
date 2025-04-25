{ inputs, config, pkgs, lib, ... }:

let
	tui = import ./tui.nix {
		inherit inputs config pkgs lib;
	};
	gui = import ./gui.nix {
		inherit inputs config pkgs lib;
	};
	cfg = config.cyber;
in
{
	imports = [
		gui
		tui
	];

	options.cyber = {
		enable = lib.mkOption {
			type = lib.types.bool;
			default = false;
			description = "Enable the cyber packages installation";
		};

		tui = lib.mkOption {
			type = lib.types.bool;
			default = false;
			description = "Enable the terminal tools";
		};

		gui = lib.mkOption {
			type = lib.types.bool;
			default = false;
			description = "Enable the graphical tools";
		};
	};

	config = lib.mkIf cfg.enable {
		# home = {
		# 	packages = with pkgs; [
		# 	] ++ (
		# 		if pkgs.stdenv.isLinux then [
		# 		]
		# 		else []
		# 	);
		# };
		# programs = {
		# };
	};
}
