{ config, pkgs, inputs, ... }:

{

  home.username = "katya";
  home.homeDirectory = "/home/beefpad";
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
   
  ];

  home.file = {

 };

 home.sessionVariables = {
    # EDITOR = "emacs";
  };

  programs.home-manager.enable = true;
}
