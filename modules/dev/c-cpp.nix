{ inputs, config, pkgs, lib, ... }:

let
	cfg = config.dev.language.c-cpp;
in
{
	config = lib.mkIf cfg {
		home = {
			packages = with pkgs; [
				clang
				gnumake
				libclang
				libcxx
				glibc.dev
				stdenv.cc.libc
				gcc.libc
			] ++ ( if stdenv.isLinux then [
					valgrind
				] else []);
			sessionVariables = {
				MallocNanoZone = 0;
				CC = "clang";
				CFLAGS = "--stdlib=libc -Wall -Werror -Wextra -std=c89";

				CXX = "c++";
				CXXFLAGS = "-Wall -Werror -Wextra -std=c++98 --stdlib=libc++ -I${pkgs.libcxx.dev}/include";
			};
		};
	};
}
