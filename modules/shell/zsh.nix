{ config, pkgs, ... }:

let
	starship = import ./starship.nix { inherit config pkgs; };
	tmux = import ./tmux.nix { inherit config pkgs; };
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
	programs.zsh = {
		enable = true;
		autosuggestion = {
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
		enableCompletion = true;
		autocd = true;
	};

	programs.zoxide = {
		enable = true;
	};
	
	programs.direnv = {
		enable = true;
		nix-direnv = {
			enable = true;
		};
	};

	programs.git = {
		enable = true;
		userName  = "Raphael";
		userEmail = "rparodi@student.42.fr";
	};

	home.file.".zshrc".text = ''
	 	[ -f "$HOME/.zshenv" ] && source "$HOME/.zshenv";
		[ -f "$HOME/.zvars"  ] && source "$HOME/.zvars";
		
		export PATH="''$HOME/.nix-profile/bin:''$HOME/.local/bin:/Library/Developer/CommandLineTools/Library/PrivateFrameworks/LLDB.framework/Versions/A/Resources/debugserver:''$PATH"
		[ -f "$HOME/.nix-profile/etc/profile.d/nix.sh" ]  && source "$HOME/.nix-profile/etc/profile.d/nix.sh"
		if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
		  source '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
		fi
		[ -f "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" ] && source "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"

		export ZINIT_HOME="''${XDG_DATA_HOME:-''${HOME}/.cache/}/zinit/zinit.git"
		export MANPAGER="/bin/sh -c 'col -bx | bat -l man --style=plain --paging=always'"
		export MANROFFOPT="-c"

		[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
		[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
		source "''${ZINIT_HOME}/zinit.zsh"

		[ -f /etc/zshenv ] && source /etc/zshenv

		mkdir -p "$HOME/.zfunc"
		fpath+="$HOME/.zfunc"
		path+="${pkgs.comma}/bin/"

		[ ! -f "$HOME/.zfunc/_rustup" ] && { rustup completions zsh rustup |> "$HOME/.zfunc/_rustup" }
		[ ! -f "$HOME/.zfunc/_cargo" ] && { rustup completions zsh cargo |> "$HOME/.zfunc/_cargo" }


		zinit ice wait lucid; zinit light Aloxaf/fzf-tab
		zinit ice wait lucid; zinit light nix-community/nix-zsh-completions
		zinit ice wait lucid; zinit light z-shell/F-Sy-H
		zinit ice wait lucid; zinit light zsh-users/zsh-autosuggestions
		zinit ice wait lucid; zinit light zsh-users/zsh-syntax-highlighting

		zinit ice wait lucid as'completions'; zinit snippet OMZP::sudo
		zinit ice wait lucid as'completions'; zinit snippet OMZP::rust

		bindkey '^[[A' history-search-backward
		bindkey '^[[B' history-search-forward

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

		HISTSIZE=5000
		SAVEHIST=$HISTSIZE

		HISTFILE="$HOME/.zsh_history"
		mkdir -p "$(dirname "$HISTFILE")"
		HISTDUP=erase
		setopt SHARE_HISTORY
		setopt HIST_FCNTL_LOCK
		setopt HIST_IGNORE_SPACE
		setopt HIST_IGNORE_DUPS
		setopt HIST_IGNORE_ALL_DUPS
		unsetopt HIST_EXPIRE_DUPS_FIRST
		unsetopt EXTENDED_HISTORY

		zi for \
		  atload"zicompinit; zicdreplay" \
		  blockf \
		  lucid \
		  wait \
		zsh-users/zsh-completions

		zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
		zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
		zstyle ':completion:*' menu no
		zstyle ':fzf-tab:complete:cd:*' fzf-preview '${pkgs.eza}/bin/eza -a --icons --color $realpath'
		zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview '${pkgs.eza}/bin/eza -a --icons --color $realpath'

		eval "$(${pkgs.direnv}/bin/direnv hook zsh)"
		eval "$(${pkgs.starship}/bin/starship init zsh)"
	'';
}
