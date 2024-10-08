{
    description = "UnsaddledDog's flake with support for nixos, nix and darwin";

    inputs = {
        nixpkgs = {
            url = "github:NixOS/nixpkgs/nixpkgs-unstable";
        };

        nix-darwin = {
            url = "github:LnL7/nix-darwin";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        home-manager = {
  	        url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        nixvim = {
            url = "github:nix-community/nixvim";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        hyprland = {
            url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
        };

        hyprland-plugins = {
            url = "github:hyprwm/hyprland-plugins";
            inputs.hyprland.follows = "hyprland";
        };

        hyprpanel = {
            url = "github:Jas-SinghFSU/HyprPanel";
        };

        rose-pine-hyprcursor = {
            url = "github:ndom91/rose-pine-hyprcursor";
        };
    };

    outputs = { self, nix-darwin, nixpkgs, home-manager, nixvim, hyprland, hyprpanel, ... }@inputs: {
        darwinConfigurations.darwin = nix-darwin.lib.darwinSystem {
            system = "x86_64-darwin";
            modules = [
                ./hosts/darwin/configuration.nix	
                home-manager.darwinModules.home-manager {
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
                    home-manager.users.gergo = import ./hosts/darwin/home.nix;
                    home-manager.extraSpecialArgs = { inherit inputs; };
                }
            ];
        };

        nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = {inherit inputs;};
            modules = [
                ./hosts/nixos/configuration.nix
                ./overlays
                home-manager.nixosModules.home-manager {
                    home-manager = {
                        useGlobalPkgs = true;
                        useUserPackages = true;
                        users.gergo = import ./hosts/nixos/home.nix;
                        extraSpecialArgs = { inherit inputs; };
                    };
                }
            ];
        };

        homeConfigurations.linux = home-manager.lib.homeManagerConfiguration {
            pkgs = nixpkgs.legacyPackages.x86_64-linux;
            extraSpecialArgs = {inherit inputs ;};
            modules = [
                ./hosts/linux/home.nix
            ];
        };
    };
}
