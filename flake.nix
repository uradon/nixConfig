{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
       url = "github:nix-community/nixvim/nixos-26.05";
       inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
  };

  outputs = { nixpkgs, stylix, nixvim, ... }@inputs: {
   
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
