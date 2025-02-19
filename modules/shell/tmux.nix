{ config, pkgs, ... }:

{
	home.packages = with pkgs; [
		tmux
	];

	programs.tmux = {
		enable = true;
		terminal = "screen-256color";
		shortcut = "a";
		clock24 = true;
		keyMode = "vi";
		customPaneNavigationAndResize = true;
		baseIndex = 1;
		mouse = true;
		resizeAmount = 5;
		plugins = with pkgs; [
			{
				plugin = tmuxPlugins.vim-tmux-navigator;
				extraConfig = ''
		 			# Copy mode key bindings for vim-like behavior
		 			bind-key -T copy-mode-vi v send-keys -X begin-selection
		 			bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
		 			bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "xclip -selection clipboard -in"
				'';
			}
			{
				plugin = tmuxPlugins.catppuccin;
				extraConfig = ''
					set -g status-position top
				 	set -g @catppuccin_flavour 'mocha'

				 	set -g @catppuccin_window_right_separator "█"
				 	set -g @catppuccin_window_number_position "right"
				 	set -g @catppuccin_window_middle_separator " █"

				 	set -g @catppuccin_window_default_fill "number"
				 	set -g @catppuccin_window_current_fill "number"
				 	set -g @catppuccin_window_current_text "#{pane_current_command}"

				 	set -g @catppuccin_status_modules_right "application session date_time"
				 	set -g @catppuccin_status_left_separator  "██"
				 	set -g @catppuccin_status_right_separator "█ "
				 	set -g @catppuccin_status_fill "all"

				 	set -g @catppuccin_status_connect_separator "yes"
				'';
			}
		];
		extraConfig = ''
			unbind %
			bind \\ split-window -h
			unbind '"'
			bind | split-window -v

		 	# Pane resizing shortcuts
		 	bind -n C-M-Up resize-pane -U 5
		 	bind -n C-M-Down resize-pane -D 5
		 	bind -n C-M-Left resize-pane -L 5
		 	bind -n C-M-Right resize-pane -R 5

		 	# Pane navigation shortcuts
		 	bind -n C-Up select-pane -U
		 	bind -n C-Down select-pane -D
		 	bind -n C-Left select-pane -L
		 	bind -n C-Right select-pane -R

		 	# Toggle pane zoom
		 	bind -r m resize-pane -Z
		'';
	};
}
