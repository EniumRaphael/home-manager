#!/bin/sh

if [ $(uname -a | grep NixOS) ]
	
fi

if [ ! -d ~/.local/share/nvim/lazy/lazy.nvim ]; then
	git clone https://github.com/folke/lazy.nvim.git ~/.local/share/nvim/lazy/lazy.nvim
fi

if [ ! -d "$HOME/.config/nvim" ]
	git clone git@github.com:EniumRaphael/neovimconf.git ~/.config/nvim
fi
