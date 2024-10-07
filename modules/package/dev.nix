{ config, pkgs, lib, ... }:

{
	home.packages = with pkgs; [
		bat
		cargo
		clang
		clang-tools
		docker
		exercism
		fastfetch
		glibc
		gnumake
		lazygit
		lldb
		llvm
		norminette
		onefetch
		python3
		rustc
		tokei
		tree-sitter
		valgrind
	];
}

