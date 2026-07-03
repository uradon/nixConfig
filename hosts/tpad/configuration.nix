{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default 
    ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.auto-optimise-store = true;
  
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "tpad"; # Define your hostname.

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Moscow";

  
  services = {
    displayManager.ly.enable = true;
    xserver = {
      enable = true;
      windowManager.qtile.enable = true;     
    };
    picom.enable = true;
  };  
  dwm.enable = true;

  services.xserver.xkb.layout = "us";


  
   services.pipewire = {
     enable = true;
     pulse.enable = true;
   };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

   users.users.max = {
     isNormalUser = true;
     extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
     packages = with pkgs; [
       tree
     ];
     shell = pkgs.bash;
     home = "/home/max";
   };
  home-manager = {
    backupFileExtension = "backup"; 
    extraSpecialArgs = { inherit inputs; };
    users = {
      "max" =  {
         imports = [
           ./home.nix
           inputs.self.outputs.hmodules.default
         ];
       };
    };
  };

  programs.firefox.enable = true;
  programs.mtr.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
   environment.systemPackages = with pkgs; [
     vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     wget
     git
   ];

  environment.variables = { 
    NIX_CONF_DIR = "$HOME/nixConfig/";
    
  };

   services.openssh.enable = true;


  system.stateVersion = "26.05"; # Did you read the comment?

}

