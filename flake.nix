{
	description = "Full nixos configuration of home-manager";

	inputs = {
		catppuccin.url = "github:catppuccin/nix";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		hyprland.url = "github:hyprwm/Hyprland";
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		nixvim.url = "github:EniumRaphael/nixvim";
		zen-browser.url = "github:EniumRaphael/zen-flake";
	};

	outputs = inputs @ {
			catppuccin,
			home-manager,
			hyprland,
			nixpkgs,
			nixvim,
			zen-browser,
			...
		}:
		let
			system = "x86_64-linux";
			pkgs = nixpkgs.legacyPackages.${system};
		in {
			homeConfigurations."raphael" = home-manager.lib.homeManagerConfiguration {
				inherit pkgs;
				modules = [
					catppuccin.homeManagerModules.catppuccin
					./home.nix
				];

				# Optionally use extraSpecialArgs
				# to pass through arguments to home.nix
				extraSpecialArgs = {
					inherit system;
					inherit inputs;
					nixvim = nixvim.packages.${system}.default;
					zen-browser = zen-browser.packages.${system}.zen-browser;
				};
			};
		};
}
