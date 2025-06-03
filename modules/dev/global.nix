{ inputs, config, pkgs, lib, nixvim, ... }:

let
	c-cpp = import ./c-cpp.nix {
		inherit inputs config pkgs lib;
	};
	rust = import ./rust.nix {
		inherit inputs config pkgs lib;
	};
	cfg = config.dev;
in
{
	imports = [
		c-cpp
		rust
	];

	options.dev = {
		enable = lib.mkOption {
			type = lib.types.bool;
			default = false;
			description = "Enable the environment to home for global features.";
		};

		language = {
			c-cpp = lib.mkOption {
				type = lib.types.bool;
				default = false;
				description = "Enable C/C++ development tools.";
			};

			rust = lib.mkOption {
				type = lib.types.bool;
				default = false;
				description = "Enable Rust development tools.";
			};
		};
	};

	config = lib.mkIf cfg.enable {
		home = {
			packages = with pkgs; [
				fd
				direnv
				doxygen
				fastmod
				gotop
				jq
				lazydocker
				lldb
				llvm
				man-pages
				man-pages-posix
				nixvim
				ripgrep
			] ++ (
				if pkgs.stdenv.isLinux then [
					valgrind
				]
				else
					[]
			);
		};
		catppuccin.bat.enable = true;
		programs = {
			lazygit.enable = true;
			man.enable = true;
		};
	};
}
