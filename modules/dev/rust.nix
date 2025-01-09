{ inputs, config, pkgs, ... }:

{
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
}
