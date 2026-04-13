{
  description = "bdossantos dotfiles — managed with nix-darwin and home-manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:nix-community/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      nix-darwin,
      home-manager,
      ...
    }:
    let
      supportedDarwinSystems = [
        "aarch64-darwin"
        "x86_64-darwin"
      ];

      supportedLinuxSystems = [
        "x86_64-linux"
        "aarch64-linux"
      ];

      mkDarwinConfiguration =
        system:
        nix-darwin.lib.darwinSystem {
          inherit system;
          modules = [
            ./darwin.nix
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              # Keep packages in ~/.nix-profile/bin for compatibility with
              # the manually managed PATH in .profile
              home-manager.useUserPackages = false;
              home-manager.users.bdossantos = import ./home.nix;
            }
          ];
        };

      mkHomeConfiguration =
        system:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          modules = [ ./home.nix ];
        };
    in
    {
      darwinConfigurations = builtins.listToAttrs (
        map (system: {
          name = system;
          value = mkDarwinConfiguration system;
        }) supportedDarwinSystems
      );

      homeConfigurations = builtins.listToAttrs (
        map (system: {
          name = system;
          value = mkHomeConfiguration system;
        }) supportedLinuxSystems
      );
    };
}
