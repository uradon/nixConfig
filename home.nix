{ config, pkgs, inputs, ... }:

{
  home.username = "max";
  home.homeDirectory = "/home/max";
  imports = [ inputs.nixvim.homeModules.nixvim ];
  home.stateVersion = "25.05"; # Please read the comment before changing.
  

  programs.bash = {
  enable = true;
  initExtra = ''
    eval "$(starship init bash)"
  '';
  };
  

  programs.nixvim = {
    enable = true; 
    opts = {
      shiftwidth = 2;
      relativenumber = true;
    };
  };
  

  programs.kitty = {
    enable = true;
    settings = {
      confirm_os_window_close = 0;
      dynamic_background_opacity = true;
      enable_audio_bell = false;
      mouse_hide_wait = "-1.0";
      window_padding_width = 10;
      background_blur = 5;
      symbol_map = "U+E0A0-U+E0FF,U+2600-U+26FF Symbols Nerd Font";
    };
  }; 
  programs.starship = {
    enable = true;
    settings = {
      format = "[$os]($style)$directory$character";
      character = {
	format = "> ";
      };

      os = {
	disabled = false;
	style = "bold blue";
	symbols = {
	  NixOS = " "; 
	};
      };
      directory.read_only = "";
      #directory.read_only = "󰌾";
    };
  };
  home.packages = [
    pkgs.starship
    pkgs.kitty
 ];

  home.file = {

 };

 home.sessionVariables = {
    # EDITOR = "emacs";
  };

  programs.home-manager.enable = true;
}
