{ config, pkgs, ... }:

{
	home.packages = with pkgs; [
		tmux
	];

	programs.tmux = {
		enable = true;
		plugins = with pkgs; [
			tmuxPlugins.vim-tmux-navigator
			tmuxPlugins.catppuccin
		];
	};
	
	home.file.".tmux.conf".text = ''
			# Set default terminal
			set -g default-terminal "screen-256color"

			# Change prefix key to Ctrl-a
			set -g prefix C-a
			unbind C-b
			bind C-a send-prefix

			# Split window bindings
			unbind %
			bind \\ split-window -h
			unbind '"'
			bind | split-window -v

			# Reload tmux configuration
			unbind r
			bind r source-file ~/.tmux.conf \; display "Reloaded!"

			setw -g mode-keys vi
			bind-key h select-pane -L
			bind-key j select-pane -D
			bind-key k select-pane -U
			bind-key l select-pane -R

			# Pane resizing shortcuts
			bind -n C-S-Up resize-pane -U 5
			bind -n C-S-Down resize-pane -D 5
			bind -n C-S-Left resize-pane -L 5
			bind -n C-S-Right resize-pane -R 5

			# Pane navigation shortcuts
			bind -n C-Up select-pane -U
			bind -n C-Down select-pane -D
			bind -n C-Left select-pane -L
			bind -n C-Right select-pane -R

			# Toggle pane zoom
			bind -r m resize-pane -Z

			# Enable mouse mode
			set -g mouse on

			# Copy mode key bindings for vim-like behavior
			bind-key -T copy-mode-vi v send-keys -X begin-selection
			bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

			# Plugin configuration
			set -g status-position top
			set -g @catppuccin_flavour 'mocha'

			set -g @catppuccin_window_right_separator "█"
			set -g @catppuccin_window_number_position "right"
			set -g @catppuccin_window_middle_separator " █"

			set -g @catppuccin_window_default_fill "number"
			set -g @catppuccin_window_current_fill "number"
			set -g @catppuccin_window_current_text "#{pane_current_path}"

			set -g @catppuccin_status_modules_right "application session date_time"
			set -g @catppuccin_status_left_separator  "██"
			set -g @catppuccin_status_right_separator "█ "
			set -g @catppuccin_status_fill "all"

			set -g @catppuccin_status_connect_separator "yes"

			bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "xclip -selection clipboard -in"
		'';

}
