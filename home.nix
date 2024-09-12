# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    home.nix                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: rparodi <rparodi@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/09/12 11:35:56 by rparodi           #+#    #+#              #
#    Updated: 2024/09/12 18:50:03 by rparodi          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

{ config, pkgs, lib, ... }:

let
	installation = import ./modules/install.nix { inherit config pkgs lib; };
	settings = import ./modules/settings.nix { inherit config pkgs lib; };
in
{
	imports = [
		installation
		settings
	];
}
