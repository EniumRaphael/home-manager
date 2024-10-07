{ config, pkgs, lib, ... }:

{
	home.packages = with pkgs; [
		bat
		cargo
		clang
		clang-tools
		docker
		exercism
		glibc
		gnumake
		lazygit
		lldb
		llvm
		norminette
		python3
		rustc
		tokei
		tree-sitter
		valgrind
	];
}

