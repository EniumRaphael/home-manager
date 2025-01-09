{ inputs, config, pkgs, ... }:

{
	home = {
		packages = with pkgs; [
			direnv
			fastmod
			jq
			linux-manual
			lldb
			man-pages
			man-pages-posix
			valgrind
		];
	};
	programs.man.enable = true;
}
