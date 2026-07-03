{ config, pkgs, lib, ...}: {
  imports = [
    ./stylix.nix
    #./sddm.nix
    ./haVideo.nix
    ./ffmpeg-service.nix
    ./jfonts.nix
    ./happ-module.nix
    ./dwm.nix
  ];   
}
