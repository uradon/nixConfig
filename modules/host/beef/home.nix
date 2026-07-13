{ config, pkgs, inputs, ... }:

{

  home.username = "beef";
  home.homeDirectory = "/home/beef";
  imports = [ 
  ];
  home.stateVersion = "25.11"; # Please read the comment before changing.
  nixpkgs.config.allowUnfree = true;

  programs.bash = {
  enable = true;
 };

  
  programs.watch_episode.enable = true;

  kitty.enable = true; 
  home.packages = [
    pkgs.qbittorrent
    pkgs.kdePackages.kolourpaint
    pkgs.gimp3
    pkgs.fastfetch
    pkgs.brave
    pkgs.mpv
    pkgs.yt-dlp
    pkgs.exiftool
    pkgs.phoronix-test-suite
    pkgs.stress-ng
    pkgs.tor
    pkgs.qalculate-qt
    pkgs.anki-bin
    #pkgs.qtcreator
    #pkgs.qt5.qtbase
    pkgs.telegram-desktop
    pkgs.spotify
    pkgs.libreoffice
    #pkgs.discord
   ];

  home.file = {

 };

 home.sessionVariables = {
    # EDITOR = "emacs";
  };



  programs.home-manager.enable = true;
}
