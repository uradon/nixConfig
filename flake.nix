{
  description = "Nixos config flake";

  # I love niggers
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
    #zen-browser = {
    #  url = "github:youwen5/zen-browser-flake";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};
    
  };

  outputs = { nixpkgs, stylix, nixvim, ... }@inputs: 
  let 
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in
  {
    devShells.${system}.suckless = pkgs.mkShell {
      packages = with pkgs; [
	pkg-config
	libX11
	libXft
	libXinerama
	fontconfig
	freetype
	harfbuzz
	gcc
	gnumake
      ];
    };
   
    nixosConfigurations.beef = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
	stylix.nixosModules.stylix
        ./hosts/beef/configuration.nix
        ./nixosModules
      ];
    };
    nixosConfigurations.tpad = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        stylix.nixosModules.stylix
        ./hosts/tpad/configuration.nix
        ./nixosModules
      ];
    };
    

    hmodules.default = ./hmodules;
    
  };
}
