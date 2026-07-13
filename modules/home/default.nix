{ lib, ...}: {
  imports = [
    ./kitty.nix
    ./starship.nix
    ./watch_episode.nix
    ./rebuild.nix
    ./nixvim.nix
    ./suckless.nix
  ];   
}
