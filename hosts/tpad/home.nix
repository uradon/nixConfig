{ config, pkgs, inputs, ... }:

{

  home.username = "max";
  home.homeDirectory = "/home/max";
  imports = [ 
  ];
  home.stateVersion = "25.05"; # Please read the comment before changing.
  nixpkgs.config.allowUnfree = true;

  programs.bash = {
  enable = true;
  initExtra = ''
    eval "$(starship init bash)"
  '';
  };

  starship = {
    enable = true;
    style = "fancy";
  };


  kitty.enable = true; 
     
  home.packages = [
    pkgs.discord
    pkgs.zathura
    pkgs.texliveFull
    pkgs.gh
    pkgs.steam-run
    pkgs.qbittorrent
    pkgs.code-cursor
    pkgs.vscode
    pkgs.jetbrains.goland
    pkgs.obsidian
    pkgs.jetbrains.clion
    pkgs.steam
    pkgs.brave
    pkgs.caligula
 ];

  home.file = {

 };

 home.sessionVariables = {
    # EDITOR = "emacs";
  };

  programs.home-manager.enable = true;
}
