{ pkgs, lib, config, inputs, ... }:

{
  imports = [inputs.stylix.nixosModules.stylix];
  
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/katy.yaml"; 
    autoEnable = true;
  };

}
