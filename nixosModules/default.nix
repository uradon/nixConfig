{ config, pkgs, lib, ...}: {
  imports = [
    ./stylix.nix
    ./sddm.nix
    ./haVideo.nix
    ./ffmpeg-service.nix
    ./fonts.nix
    ./ai.nix
    ./happ-module.nix
  ];   
}
