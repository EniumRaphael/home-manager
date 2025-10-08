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

  outputs =
    inputs@{
      catppuccin,
      home-manager,
      hyprland,
      nixpkgs,
      nixvim,
      zen-browser,
      ...
    }:
    let
      mkHomeConfig =
        {
          name,
          system,
          modulePath,
        }:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            catppuccin.homeModules.catppuccin
            modulePath
          ];
          extraSpecialArgs = {
            inherit system inputs;
            nixvim = nixvim.packages.${system}.default;
            zen-browser = if system == "aarch64-darwin" then null else zen-browser.packages.${system}.default;
          };
        };
    in
    {
      homeConfigurations = {
        "hm-server" = mkHomeConfig {
          name = "hm-server";
          system = "x86_64-linux";
          modulePath = ./host/server.nix;
        };
        "hm-fix" = mkHomeConfig {
          name = "hm-fix";
          system = "x86_64-linux";
          modulePath = ./host/fix.nix;
        };
        "hm-root" = mkHomeConfig {
          name = "hm-root";
          system = "x86_64-linux";
          modulePath = ./host/root.nix;
        };
        "hm-cluster" = mkHomeConfig {
          name = "hm-cluster";
          system = "x86_64-linux";
          modulePath = ./host/cluster.nix;
        };
        "hm-mac" = mkHomeConfig {
          name = "hm-mac";
          system = "aarch64-darwin";
          modulePath = ./host/mac.nix;
        };
        "hm-asahi" = mkHomeConfig {
          name = "hm-asahi";
          system = "aarch64-linux";
          modulePath = ./host/asahi.nix;
        };
        "hm-rasberry" = mkHomeConfig {
          name = "hm-rasberry";
          system = "aarch64-linux";
          modulePath = ./host/rasberry.nix;
        };
      };
      homeModules = {
        server = ./host/server.nix;
        fix = ./host/fix.nix;
        root = ./host/root.nix;
        cluster = ./host/cluster.nix;
        mac = ./host/mac.nix;
        asahi = ./host/asahi.nix;
        rasberry = ./host/rasberry.nix;
      };
    };
}
