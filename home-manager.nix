{ config, pkgs, ... }:
{
  home-manager.users.maxon = {
    home.stateVersion = "24.11";

    home.packages = with pkgs; [
	vim
	firefox
	kitty
	mononoki
	mpv
	fastfetch
];
    
    programs.bash = {
      enable = true;

      initExtra = ''
        export PS1="\[\e[1;34m\]λ\[\e[0m\] \[\e[1;34m\]\w\[\e[0m\]\[\e[1;34m\]\$\[\e[0m\] " '';
    };

    programs.kitty = {
      enable = true;
      settings = {
	font_family = "Mononoki";
        font_size = 10;
        scrollback_lines = 10000;
      };
      extraConfig = ''
        foreground #ffffff
        background #1e1e2e

        # Black
        color0  #3b4252
        color8  #4c566a

        # Red
        color1  #bf616a
        color9  #bf616a

        # Green
        color2  #a3be8c
        color10 #a3be8c

        # Yellow
        color3  #ebcb8b
        color11 #ebcb8b

        # Blue
        color4  #81a1c1
        color12 #81a1c1

        # Magenta
        color5  #b48ead
        color13 #b48ead

        # Cyan
        color6  #88c0d0
        color14 #88c0d0

        # White
        color7  #e5e9f0
        color15 #eceff4
      '';
    };
  };
}
