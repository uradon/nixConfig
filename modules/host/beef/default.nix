{ self, inputs, ... }: {
  flake.nixosConfigurations.beef = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.beefConfiguration
      self.nixosModules.myHomeManager
      self.nixosModules.niri
    ];
  };
}
