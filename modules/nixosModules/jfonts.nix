{ config, lib, pkgs, ... }:

{
  options.jfonts = {
    enable = lib.mkEnableOption "enable correct kanji fonts";
  };

  config = lib.mkIf config.jfonts.enable {
    
    fonts.packages = with pkgs; [
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
      mplus-outline-fonts.osdnRelease
    ];

    fonts.fontconfig.defaultFonts = {
      monospace = [ "DejaVu Sans Mono" "Noto Sans Mono CJK JP" ];
      sansSerif = [ "DejaVu Sans" "Noto Sans CJK JP" ];
      serif = [ "DejaVu Serif" "Noto Serif CJK JP" ];
    };
  };

}
