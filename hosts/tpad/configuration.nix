{ config, pkgs, inputs, ... }:


{
  imports =
    [ 
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
    ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;



  networking.hostName = "tpad"; 
  nix.settings.experimental-features = [ "nix-command" "flakes"];
  networking.networkmanager.enable = true;
  networking.firewall.checkReversePath = "strict";

  networking.firewall.trustedInterfaces = [ "virbr0" ];

  time.timeZone = "Europe/Moscow";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };

  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.xkbOptions = "grp:alt_shift_toggle";
  services.xserver.xkb = {
    layout = "us, ru";
    variant = "";
  };

  services.printing.enable = true;


  haVideo.enable = false; 

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
   
  };


  users.users.max = {
    isNormalUser = true;
    description = "nixos";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };
  
  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "max" = {
	imports = [
	  ./home.nix
	  inputs.self.outputs.hmodules.default
	];
      };
    };  
  };

  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "max";

  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  programs.firefox.enable = true;
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = ["max"];
  nixpkgs.config.allowUnfree = true;
  
  programs.steam = { 
    enable = true;
    remotePlay.openFirewall = true; 
    dedicatedServer.openFirewall = true; 
  };

  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
  };

  environment.systemPackages = with pkgs; [
    vim 
    wget
    neovim
    telegram-desktop
    fastfetch
    mpv
    fastfetch
    mtr
    nekoray
    spotify
    gimp3
    git
    tmux
    ffmpeg
    img2pdf
    virtiofsd
    libvirt-glib
    zip
    clash-verge-rev
    gnome-tweaks
    
    #qt5_512
    # nvf build
    #inputs.self.packages.${pkgs.system}.default 
  ];
  
  virtualisation = {
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
  };


  programs.nekoray = {
    enable = true; 
    tunMode.enable = true; 
  };

  environment.variables.EDITOR = "nvim";
  console = {
    font = "ter-u32n";
    packages = with pkgs; [ terminus_font ];
  };

  system.stateVersion = "25.05"; 
}
