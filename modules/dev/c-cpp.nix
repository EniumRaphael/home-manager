{ inputs, config, pkgs, lib, ... }:

let
	cfg = config.dev.language.c-cpp;
in
{
	config = lib.mkIf cfg {
		home = {
			packages = with pkgs; [
				clang
				gcc.libc
				gnumake
				libcxx
				stdenv.cc.libc
			] ++ ( if stdenv.isLinux then [
					valgrind
					glibc.dev
				] else []);
			sessionVariables = {
				CC = "clang";
				C_INCLUDE_PATH = "${pkgs.gcc.libc}/include";

				CXX = "c++";
				CXXFLAGS="--stdlib=libc++ -I${pkgs.libcxx.dev}/include";
				CPLUS_INCLUDE_PATH = "${pkgs.stdenv.cc.libc}/include/c++/v1:${pkgs.llvmPackages.libcxx}/include/c++/v1";

				LDFLAGS="-L${pkgs.libcxx}/lib";
				LIBRARY_PATH = "${pkgs.llvmPackages.libcxx}/lib";
			};
		};
	};
}
