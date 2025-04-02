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
				libclang
				stdenv.cc.libc
			] ++ ( if stdenv.isLinux then [
					valgrind
					glibc.dev
				] else []);
			sessionVariables = {
				MallocNanoZone = 0;
				CC = "clang";
				CFLAGS = "-Wall -Werror -Wextra -std=c89";

				CXX = "c++";
				CXXFLAGS="--stdlib=libc++ -I${pkgs.libcxx.dev}/include";
			};
		};
	};
}
