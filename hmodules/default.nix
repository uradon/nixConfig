{ pkgs, lib, ...}: {
  imports = [
    ./kitty.nix
    ./nixvim.nix
    ./starship.nix
    ./watch_episode.nix
  ];   
}
