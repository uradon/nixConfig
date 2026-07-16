{ self, ... }:

{
  flake.homeModules.default = {
    imports = [
      self.homeModules.kitty
      self.homeModules.nvim
      self.homeModules.rebuild
      self.homeModules.suckless
      self.homeModules.watchEpisode

    ];
  };
}
