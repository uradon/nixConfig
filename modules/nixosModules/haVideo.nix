{ self, inputs,  ... }:

{
  flake.nixosModules.haVideo = { lib, config, pkgs, ... }: {

    options.haVideo.enable =
      lib.mkEnableOption "hardware accelerated video";

    config = lib.mkIf config.haVideo.enable {
      hardware.graphics = {
        enable = true;
        extraPackages = with pkgs; [
          intel-media-driver
          libvdpau-va-gl
        ];
      };

      environment.sessionVariables = {
        LIBVA_DRIVER_NAME = "iHD";
      };
    };

  };
}
