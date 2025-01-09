{ inputs, config, pkgs, lib, ... }:

let
	cfg = config.dev.language.c-cpp;
in
{
	config = lib.mkIf cfg {
		home.packages = with pkgs; [
			clang
			gcc.libc
			glibc.dev
			gnumake
			stdenv.cc.libc
		];
		home.sessionVariables = {
			CC = "clang";
			CPLUS_INCLUDE_PATH = "${pkgs.stdenv.cc.libc}/include/c++/v1:${pkgs.llvmPackages.libcxx}/include/c++/v1";
			C_INCLUDE_PATH = "${pkgs.glibc.dev}/include";
			LIBRARY_PATH = "${pkgs.llvmPackages.libcxx}/lib";
		};
	};
}
