{ config, pkgs, inputs, ... }:

{

  home.username = "max";
  home.homeDirectory = "/home/max";
  imports = [ 
    inputs.nvf.homeManagerModules.default 
  ];
  home.stateVersion = "25.05"; # Please read the comment before changing.
  nixpkgs.config.allowUnfree = true;

  programs.bash = {
  enable = true;
  initExtra = ''
    eval "$(starship init bash)"
  '';
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
      format = "[$os]($style)$directory[$nix_shell]($style)$character";
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
      custom.nix_shell = {
	detect = ''[ -n "$IN_NIX_SHELL" ]'';  # Checks if in nix-shell
	style = "bold cyan";
	format = "(fg:#89c0d0) ";  # Light blue color, adjust as needed
      };
    };
  };

  

  #programs.nvf = {
  #   enable = true;
  #   settings = {
  #     vim = {
  #       options.shiftwidth = 2;
  #       autocomplete.nvim-cmp.enable = true; 
  #       autopairs.nvim-autopairs.enable = true;
  #       
  #       languages = {
  #         enableLSP = true;
  #         enableTreesitter = true; 
  #         texlab.enable = true;
  #         nix.enable = true;
  #         clang.enable = true;
  #       };
  #     };
  #   };
  # };


  home.packages = [
    pkgs.starship
    pkgs.kitty
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
 ];

  home.file = {

 };

 home.sessionVariables = {
    # EDITOR = "emacs";
  };

  programs.home-manager.enable = true;
}
