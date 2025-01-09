{ inputs, config, pkgs, ... }:

{
	home = {
		packages = with pkgs; [
			clang
			gcc.libc
			glibc.dev
			gnumake
			stdenv.cc.libc
		];
		sessionVariables = {
			CC = "clang";
			CPLUS_INCLUDE_PATH = "${pkgs.stdenv.cc.libc}/include/c++/v1:${pkgs.llvmPackages.libcxx}/include/c++/v1";
			C_INCLUDE_PATH = "${pkgs.glibc.dev}/include";
			LIBRARY_PATH = "${pkgs.llvmPackages.libcxx}/lib";
		};
	};
}
