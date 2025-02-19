{ inputs, config, pkgs, lib, ... }:

let
	cfg = config.dev.language.rust;
in
{
	config = lib.mkIf cfg {
		home = {
			packages = with pkgs; [
				cargo
				clippy
				rust-analyzer
				rustc
			];
			sessionVariables = {
				CARGO_HOME = "$HOME/.cargo";
			};
		};
	};
}
