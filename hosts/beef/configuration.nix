
{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
    ];

 
   #nix.settings.substituters = [ "https://aseipp-nix-cache.global.ssl.fastly.net" ];


  networking.proxy.default = "http://127.0.0.1:10809";
  services.v2raya.enable = true;
  services.happ.enable = true;
  nixpkgs.config.allowUnfree = true;
  security.polkit.enable = true;

  
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.kernelModules = [ "amdgpu" ];


  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.nameservers = [ "1.1.1.1" "8.8.8.8" ];
  networking.search = [ "local" ];

  networking.hostName = "beef"; # define your hostname.

  nix.settings.auto-optimise-store = true;


  programs.mtr.enable = true;



  networking.networkmanager.enable = true;

  time.timezone = "Europe/Moscow";

  i18n.defaultlocale = "en_us.utf-8";

  i18n.extralocalesettings = {
    lc_address = "en_us.utf-8";
    lc_identification = "en_us.utf-8";
    lc_measurement = "en_us.utf-8";
    lc_monetary = "en_us.utf-8";
    lc_name = "en_us.utf-8";
    lc_numeric = "en_us.utf-8";
    lc_paper = "en_us.utf-8";
    lc_telephone = "en_us.utf-8";
    lc_time = "en_us.utf-8";
  };

  

  services.xserver.enable = true;


  #services.displaymanager.sddm.enable = true;
  #services.desktopmanager.plasma6.enable = true;

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
    pulse.enable = true;
    
  };


    

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

  
  
  
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  #nixpkgs.overlays = [
  #  (self: super: {
  #    openblas = super.openblas.overrideAttrs (oldAttrs: {
  #      # Disable the test suite to prevent the checkPhase from hanging
  #      doCheck = false;
  #    });
  #  })
  #];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; 
    dedicatedServer.openFirewall = true; 
  };
  fileSystems."/mnt/secondary" =
  { 
      device = "/dev/disk/by-partuuid/ab301ed4-486e-40f0-b569-e50f0cd31511";
      fsType = "ext4";
      options = [ "nofail" ];
  }; 

  
  hardware.enableAllFirmware = true;	  
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
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
    dnsutils
    jq
    binutils
    amdgpu_top
    gdb
    unrar
  ];

  hardware.graphics.enable = true;
  
  system.stateVersion = "25.11";  

  #lm studio build fails 
  
 
  #ffmpeg-thingy 

  ffmpeg-service.enable = true; 
  sway.enable = true;
  autorice.enable = false;



 
}
