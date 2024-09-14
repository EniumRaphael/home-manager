{ config, pkgs, lib, ... }:

{
	home.packages = with pkgs; [
		bat
		cargo
		clang
		docker
		lazygit
		lldb
		llvm
		norminette
		python3
		rustc
		gnumake
		valgrind
	];
}

