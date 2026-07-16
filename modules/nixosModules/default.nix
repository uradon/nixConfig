{ self, ... }:

{
  flake.nixosModules.default = {
    imports = [
      self.nixosModules.dwm
      self.nixosModules.ffmpegService
      self.nixosModules.haVideo
      self.nixosModules.happModule
      self.nixosModules.JFonts
      self.nixosModules.stylix
      self.nixosModules.sway
    ];
  };
}
