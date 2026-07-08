{ config, pkgs, inputs, ... }:

{

  home.username = "max";
  home.homeDirectory = "/home/max";
  imports = [ 
  ];
  home.stateVersion = "26.05"; # Please read the comment before changing.
  nixpkgs.config.allowUnfree = true;




  suckless.enable = true; 
  kitty.enable = true; 
  home.packages = [
    pkgs.qbittorrent
    pkgs.fastfetch
    pkgs.mpv
    pkgs.yt-dlp
    pkgs.exiftool
    pkgs.phoronix-test-suite
    pkgs.stress-ng
    pkgs.qalculate-qt
    pkgs.anki-bin
    #pkgs.qtcreator
    #pkgs.qt5.qtbase
    pkgs.telegram-desktop
    pkgs.spotify
    #pkgs.discord
   ];

  home.file = {

 };
 programs.bash.enable = true;
 home.sessionVariables = {
    # EDITOR = "emacs";
  };

  programs.home-manager.enable = true;
}
