{ config, lib, pkgs, ... }:

{
  options.sway = {
    enable = lib.mkEnableOption "enable sway compositor";
  };

  config = lib.mkIf config.sway.enable {
    
    environment.systemPackages = with pkgs; [
      wl-clipboard # Copy/Paste functionality.
      mako # Notification utility.
      pulseaudio
    ];

    # Enables Gnome Keyring to store secrets for applications. 
    services.gnome.gnome-keyring.enable = true;

    # Enable Sway.
    programs.sway = {
      enable = true;
      wrapperFeatures.gtk = true;
    };



    security.pam.services = {
      greetd.enableGnomeKeyring = true;
      swaylock.enableGnomeKeyring = true;
    };	

    services.greetd = {                                                      
      enable = true;                                                         
      settings = {                                                           
	default_session = {                                                  
	  command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd sway";
	  user = "greeter";                                                  
	};                                                                   
      };                                                                     
    };

    users.users.yourusername.extraGroups = [ "video" ];
    programs.light.enable = true;
    
    

  };



}

