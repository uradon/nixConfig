{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
       url = "github:nix-community/nixvim";
       inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
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
