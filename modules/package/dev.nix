{ config, pkgs, lib, ... }:

{
	home.packages = with pkgs; [
		bat
		cargo
		clang
		docker
		gnumake
		lazygit
		lldb
		llvm
		norminette
		python3
		rustc
		tokei
		valgrind
	];
}

