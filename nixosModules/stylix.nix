{ pkgs, lib, config, ... }:

{

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/katy.yaml"; 
    autoEnable = true;
  };

}
