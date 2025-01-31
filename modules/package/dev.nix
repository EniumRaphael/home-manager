{ config, pkgs, lib, ... }:

{
	home.packages = with pkgs; [
		bat
		cargo
		clang
		clang-tools
		docker
		exercism
		gnumake
		lazygit
		lldb
		llvm
		nixvim
		norminette
		python3
		rustc
		tokei
		tree-sitter
	];
}

