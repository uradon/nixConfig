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
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs"; 
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpgks.follows = "nixpgks";
    };

  };

  outputs = { self, nixpkgs, stylix, nvf, sops-nix, ... }@inputs: {
   
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./hosts/tpad/configuration.nix
	./nixosModules
      ];
    };
    hmodules.default = ./hmodules;
  };
}
