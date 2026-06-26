{
  description = "Full nixos configuration of home-manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/master";

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hytale-launcher = {
      url = "github:JPyke3/hytale-launcher-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    orca-slicer-flake = {
      url = "github:EniumRaphael/orca-slicer-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:EniumRaphael/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      catppuccin,
      home-manager,
      nixpkgs,
      nixvim,
      noctalia,
      orca-slicer-flake,
      zen-browser,
      ...
    }:
    let
      lib = nixpkgs.lib;

      pkgsFor =
        system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };

      mkHomeConfig =
        { system, modulePath, gpg ? null }:
        let
          pkgs = pkgsFor system;
          sys = pkgs.stdenv.hostPlatform.system;
        in
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            catppuccin.homeModules.catppuccin
            inputs.noctalia.homeModules.default
            modulePath
          ];
          extraSpecialArgs = {
            inherit inputs;
            gpgFingerprint = gpg;
            orca-slicer-pkg =
              if orca-slicer-flake.packages ? ${sys} then orca-slicer-flake.packages.${sys}.default else null;
            nixvim = nixvim.packages.${sys}.default;
            zen-browser = if zen-browser.packages ? ${sys} then zen-browser.packages.${sys}.default else null;
          };
        };

      hosts = {
        server = {
          system = "x86_64-linux";
          path = ./host/server.nix;
        };
        framework = {
          system = "x86_64-linux";
          path = ./host/framework.nix;
          gpg = "7E68 D47E EEE8 16AB 5C22  3E06 C0D7 7521 C860 610C";
        };
        fix = {
          system = "x86_64-linux";
          path = ./host/fix.nix;
        };
        root = {
          system = "x86_64-linux";
          path = ./host/root.nix;
        };
        cluster = {
          system = "x86_64-linux";
          path = ./host/cluster.nix;
        };
        mac = {
          system = "aarch64-darwin";
          path = ./host/mac.nix;
        };
        asahi = {
          system = "aarch64-linux";
          path = ./host/asahi.nix;
        };
        rasberry = {
          system = "aarch64-linux";
          path = ./host/rasberry.nix;
        };
      };

    in
    {
      homeConfigurations = lib.mapAttrs (
        _: h:
        mkHomeConfig {
          system = h.system;
          modulePath = h.path;
          gpg = h.gpg;
        }
      ) hosts;

      homeModules = lib.mapAttrs (_: h: h.path) hosts;
    };
}
