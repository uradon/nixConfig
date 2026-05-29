
{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
    ];

 
  nix.settings = {
    # Replace the default list with Chinese mirrors, falling back to the official cache
    substituters = [
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
      "https://mirrors.ustc.edu.cn/nix-channels/store"
      "https://cache.nixos.org"
    ];
  };
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  boot.kernelPackages = pkgs.linuxPackages_latest;
  networking.hostName = "nixos"; # Define your hostname.

  nix.settings.auto-optimise-store = true;

  
  programs.mtr.enable = true;


  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Moscow";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  
  services.timesyncd.enable = true; 
  systemd.services.systemd-timesyncd.serviceConfig.TimeoutStopSec = "5s";

  services.xserver.enable = true;


  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.printing.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    
  };


  autorice.enable = true;
  
  users.users.beef = {
    isNormalUser = true;
    description = "beef";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
    packages = with pkgs; [
      kdePackages.kate
    ];
  };

  home-manager = {
    backupFileExtension = "backup";
    extraSpecialArgs = {
	inherit inputs;
    };
    users = {
      "beef"= {
        imports = [
          ./home.nix
	  inputs.self.outputs.hmodules.default  
        ];
      };
     };
       
  };
  programs.firefox.enable = true;

  nixpkgs.config.allowUnfree = true;
  
  
  
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;


  programs.steam.enable = true;
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    input.General.IdleTimeout = 1000;
  };
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    htop
    ffmpeg-full
    wf-recorder
    v2rayn
    proxychains
    qemu
    dnsmasq
    amnezia-vpn
    caligula
  
  ];

  
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;
  
  system.stateVersion = "25.11";  
  

  #ffmpeg-thingy 

  ffmpeg-service.enable = true; 


}
