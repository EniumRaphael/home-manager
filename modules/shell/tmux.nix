{ config, pkgs, ... }:

{
	home.packages = with pkgs; [
		tmux
	];

	catppuccin.tmux = {
		enable = true;
		extraConfig = ''
			set -g status-position top
			set -g @catppuccin_flavour 'mocha'
			set -g @catppuccin_status_fill "all"
			set -g @catppuccin_status_connect_separator "yes"
		'';
	};
	programs.tmux = {
		enable = true;
		terminal = "screen-256color";
		shortcut = "s";
		clock24 = true;
		keyMode = "vi";
		customPaneNavigationAndResize = true;
		baseIndex = 0;
		mouse = true;
		resizeAmount = 5;
		plugins = with pkgs.tmuxPlugins; [
			catppuccin
			vim-tmux-navigator
		];
		extraConfig = ''
			unbind %
			bind \\ split-window -h
			unbind '"'
			bind | split-window -v

			set -g status-position top

		 	# Pane resizing shortcuts
		 	bind -n C-M-Up resize-pane -U 5
		 	bind -n C-M-Down resize-pane -D 5
		 	bind -n C-M-Left resize-pane -L 5
		 	bind -n C-M-Right resize-pane -R 5

		 	# Pane navigation shortcuts
		 	bind -n C-k select-pane -U
		 	bind -n C-j select-pane -D
		 	bind -n C-h select-pane -L
		 	bind -n C-l select-pane -R

		 	# Toggle pane zoom
		 	bind -r m resize-pane -Z
		'';
	};
}
