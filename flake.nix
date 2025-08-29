{
  description = "Full nixos configuration of home-manager";

  inputs = {
    catppuccin.url = "github:catppuccin/nix";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    hyprland.url = "github:hyprwm/Hyprland";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixvim.url = "github:EniumRaphael/nixvim";
  };

  outputs = inputs@{ catppuccin, home-manager, hyprland, nixpkgs, nixvim
    , zen-browser, ... }: {
      homeConfigurations = {
        "hm-server" = let
          system = "x86_64-linux";
          pkgs = nixpkgs.legacyPackages.${system};
        in home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ catppuccin.homeModules.catppuccin ./host/server.nix ];
          extraSpecialArgs = {
            inherit system inputs;
            nixvim = nixvim.packages.${system}.default;
            zen-browser = zen-browser.packages.${system}.default;
          };
        };
        "hm-fix" = let
          system = "x86_64-linux";
          pkgs = nixpkgs.legacyPackages.${system};
        in home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ catppuccin.homeModules.catppuccin ./host/fix.nix ];
          extraSpecialArgs = {
            inherit system inputs;
            nixvim = nixvim.packages.${system}.default;
            zen-browser = zen-browser.packages.${system}.default;
          };
        };
        "hm-root" = let
          system = "x86_64-linux";
          pkgs = nixpkgs.legacyPackages.${system};
        in home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ catppuccin.homeModules.catppuccin ./host/root.nix ];
          extraSpecialArgs = {
            inherit system inputs;
            nixvim = nixvim.packages.${system}.default;
            zen-browser = zen-browser.packages.${system}.default;
          };
        };
        "hm-cluster" = let
          system = "x86_64-linux";
          pkgs = nixpkgs.legacyPackages.${system};
        in home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ catppuccin.homeModules.catppuccin ./host/cluster.nix ];
          extraSpecialArgs = {
            inherit system inputs;
            nixvim = nixvim.packages.${system}.default;
            zen-browser = zen-browser.packages.${system}.default;
          };
        };
        "hm-mac" = let
          system = "aarch64-darwin";
          pkgs = nixpkgs.legacyPackages.${system};
        in home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ catppuccin.homeModules.catppuccin ./host/mac.nix ];
          extraSpecialArgs = {
            inherit system inputs;
            nixvim = nixvim.packages.${system}.default;
            zen-browser = null;
          };
        };
        "hm-asahi" = let
          system = "aarch64-linux";
          pkgs = nixpkgs.legacyPackages.${system};
        in home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ catppuccin.homeModules.catppuccin ./host/asahi.nix ];
          extraSpecialArgs = {
            inherit system inputs;
            nixvim = nixvim.packages.${system}.default;
            zen-browser = zen-browser.packages.${system}.default;
          };
        };
        "hm-rasberry" = let
          system = "aarch64-linux";
          pkgs = nixpkgs.legacyPackages.${system};
        in home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ catppuccin.homeModules.catppuccin ./host/rasberry.nix ];
          extraSpecialArgs = {
            inherit system inputs;
            nixvim = inputs.nixvim.packages.${system}.default;
            zen-browser = inputs.zen-browser.packages.${system}.default;
          };
        };
      };
    };
}
