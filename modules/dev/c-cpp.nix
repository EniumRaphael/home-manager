{ inputs, config, pkgs, lib, ... }:

let
	cfg = config.dev.language.c-cpp;
	llvm = pkgs.llvmPackages_16;
in
{
	config = lib.mkIf cfg {
		home = {
			packages = with pkgs; [
				llvm.clang-tools
				glibc.dev
				gnumake
				valgrind
				readline
			] ++ ( if stdenv.isLinux then [
					valgrind
				] else []);
			sessionVariables = {
				MallocNanoZone = 0;
			};
		};
	};
}
