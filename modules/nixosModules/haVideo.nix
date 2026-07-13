{ pkgs, lib, config, ... }: {
  
  #hardware accelerated video
  
  options = { 
    haVideo.enable =
      lib.mkEnableOption "enables hardware accelerated video";
  };
  
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
}
