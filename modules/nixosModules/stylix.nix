{ inputs, self, ... }:

{
  flake.nixosModules.stylix = { pkgs, lib, config, ... }: {
   imports = [
      inputs.stylix.nixosModules.stylix
    ];
    options.autorice.enable =
      lib.mkEnableOption "enables stylix";

    config = lib.mkIf config.autorice.enable {
      stylix = {
        enable = true;
        base16Scheme = "${pkgs.base16-schemes}/share/themes/katy.yaml";
        image = ../wallpaper.jpg;
      };
    };
  };
}
