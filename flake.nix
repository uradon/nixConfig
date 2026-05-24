{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
       url = "github:nix-community/nixvim";
    };
    stylix = {
      url = "github:nix-community/stylix/release-25.11";
    };
    
  };

  outputs = { nixpkgs, stylix, ... }@inputs: {
   
    nixosConfigurations.beef = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
	stylix.nixosModules.stylix
        ./hosts/beef/configuration.nix
        ./nixosModules
      ];
    };

    hmodules.default = ./hmodules;
    
  };
}
