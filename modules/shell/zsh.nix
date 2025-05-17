{ config, pkgs, lib, ... }:

let
	starship = import ./starship.nix {
		inherit config pkgs;
	};
	tmux = import ./tmux.nix {
		inherit config pkgs;
	};
in
{
	imports = [
		starship
		tmux
	];

	home.packages = with pkgs; [
		cowsay
		direnv
		eza
		fzf
		lolcat
		wget
		zoxide
	];

	programs = {
		fastfetch = {
			enable = true;
		};

		zoxide = {
			enable = true;
		};
		
		direnv = {
			enable = true;
			silent = true;
			nix-direnv = {
				enable = true;
			};
		};

		bat = {
			enable = true;
			config.theme = "Catppuccin Mocha";
		};

		git = {
			enable = true;
			userName  = "Raphael";
			userEmail = "rparodi@student.42.fr";
			ignores = [
				".DS_Store"
				"*.swp"
				"*.swo"
				"*.swm"
				"*.swu"
				"node_modules/"
				".env"
			];
		};

		zsh = {
			enable = true;
			autosuggestion = {
				enable = true;
			};
			history = {
				append = true;
				expireDuplicatesFirst = false;
				extended = false;
				findNoDups = true;
				ignoreAllDups = true;
				ignoreDups = true;
				ignoreSpace = true;
				path = "$HOME/.zsh_history";
				save = 5000;
				share = true;
				size = 5000;
			};
			enableCompletion = true;
			autocd = true;
			historySubstringSearch = {
				enable = true;
			};
			shellAliases = {
				"cls" = "clear";
				"vim" = "nvim";
				"gcl" = "git clone";
				"gs" = "git status";
				"gm" = "git commit -m";
				"gc" = "git commit -m";
				"gp" = "git push";
				"gpp" = "git pull";
				"ga" = "git add .";
				"gr" = "git restore .";
				"ls" = "eza -h --icons=always";
				"ll" = "ls -l";
				"l" = "ls -l";
				"la" = "ls -la";
				"vg" = "valgrind --leak-check=full --show-leak-kinds=all --trace-children=yes --track-fds=yes --track-origins=yes --show-reachable=yes";
				"ssh" = "TERM=xterm-256color ssh";
			};
			zplug = {
				enable = true;
				zplugHome = "${config.xdg.dataHome}/.zplug";
				plugins = [
					{
						name = "Aloxaf/fzf-tab";
					}
					{
						name = "nix-community/nix-zsh-completions";
					}
					{
						name = "z-shell/F-Sy-H";
					}
					{
						name = "zsh-users/zsh-autosuggestions";
					}
					{
						name = "zsh-users/zsh-syntax-highlighting";
					}
				];
			};
			envExtra = ''
				[ -f "$HOME/.zvars"  ] && source "$HOME/.zvars";
				[ -f "$HOME/.nix-profile/etc/profile.d/nix.sh" ]  && source "$HOME/.nix-profile/etc/profile.d/nix.sh"
				[ -f "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" ] && source "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
				[ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ] && source '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
				[ -f /etc/zshenv ] && source /etc/zshenv
				[ -d ${pkgs.fzf} ] && source ${pkgs.fzf}/share/fzf/key-bindings.zsh
			'';
			initContent = lib.mkMerge [
				(lib.mkAfter ''
					fzf_tab_preview() {
						if [[ -d $path ]]; then
							${pkgs.eza}/bin/eza --icons=always --color=always "$1"
						else
							${pkgs.bat}/bin/bat -p --color=always "$1"
						fi
					}

					if [ -f "$HOME/.config/bat/themes/Catppuccin\ Mocha.tmTheme" ]; then
						mkdir -p "$HOME/.config/bat/themes"
						wget -P "$HOME/.config/bat/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Mocha.tmTheme
					fi
				'')
				(lib.mkAfter ''
					zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
					zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
					zstyle ':completion:*' menu no
					zstyle ':fzf-tab:*' use-fzf-default-opts yes
					zstyle ':fzf-tab:complete:*' fzf-preview 'if [[ -d $realpath ]]; then ${pkgs.eza}/bin/eza -1 --icons=always --color=always "$realpath"; else ${pkgs.bat}/bin/bat -p --color=always "$realpath"; fi'
					zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview '${pkgs.eza}/bin/eza -a --icons --color $realpath'
					zstyle ':fzf-tab:complete:cd:*' fzf-preview '${pkgs.eza}/bin/eza -a --icons --color $realpath'
					zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup

					bindkey '^R' fzf-history-widget
					bindkey '^[[1;5C' forward-word
					bindkey '^[[1;5D' backward-word
					bindkey '^[Oc' forward-word
					bindkey '^[Od' backward-word
					bindkey '^[[1;2D' beginning-of-line
					bindkey '^[[1;2C' end-of-line
					bindkey '^[[1;3D' beginning-of-line
					bindkey '^[[1;3C' end-of-line
					bindkey '^H' backward-kill-word
					bindkey -r '^['
				'')
			];
			loginExtra = ''
				eval "$(${pkgs.direnv}/bin/direnv hook zsh)"
				eval "$(${pkgs.starship}/bin/starship init zsh)"
			'';
			sessionVariables = {
				PATH = "$HOME/.nix-profile/bin:$HOME/.local/bin:/Library/Developer/CommandLineTools/Library/PrivateFrameworks/LLDB.framework/Versions/A/Resources/debugserver:$PATH";
				MANPAGER = "/bin/sh -c 'col -bx | bat -l man --style=plain --paging=always'";
				MANROFFOPT = "-c";
				FZF_CTRL_R_OPTS = "--layout reverse --bind='ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort' --header='Ctrl-Y pour copier'";
			};
		};
	};
}
