{ config, pkgs, lib, ...}: {
  imports = [
    ./stylix.nix
    ./sddm.nix
    ./haVideo.nix
    ./ffmpeg-service.nix
    ./fonts.nix
    ./happ-module.nix
  ];   
}
