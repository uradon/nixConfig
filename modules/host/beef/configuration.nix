{ self, inputs, ... }: {
  
  flake.nixosModules.beefConfiguration = { pkgs, lib, ... }: {
    # import any other modules from here
    imports = [
      self.nixosModules.beefHardware
      self.nixosModules.default
    ];

     #nix.settings.substituters = [ "https://aseipp-nix-cache.global.ssl.fastly.net" ];

    #secret https://connliberty.com/connection/subs/d1e2af85-05f0-4ef9-928d-61ff77c95c53

    #networking.proxy.default = "http://127.0.0.1:10809";
    services.v2raya.enable = true;
    #services.happ.enable = true;
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

    home-manager.users.beef = self.homeModules.beefHome; 

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

    ffmpeg-service.enable = true; 
    #swayComp.enable = true;
    #autorice.enable = false;

  
  };

}
