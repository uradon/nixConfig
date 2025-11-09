{ pkgs, lib, ...}: {
  imports = [
    ./nixvim.nix
    ./starship.nix
    ./nvfcfg.nix
    ./kitty.nix
  ];   
}
