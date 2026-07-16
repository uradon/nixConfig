{ self, inputs,  ... }:

{

  flake.homeConfigurations.beef = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = import inputs.nixpkgs { system = "x86_64-linux"; };
    modules = [
      self.homeModules.beefHome
      {
        home.username = "beef";
        home.homeDirectory = "/home/beef";
      }
    ];
  };

  flake.homeModules.beefHome = { pkgs, ... }: {

    imports = [
      self.homeModules.default
    ];


    home.stateVersion = "25.11";

    nixpkgs.config.allowUnfree = true;

    programs.bash.enable = true;

    programs.watch_episode.enable = true;

    kitty.enable = true;

    home.packages = with pkgs; [
      qbittorrent
      kdePackages.kolourpaint
      gimp3
      fastfetch
      brave
      mpv
      yt-dlp
      exiftool
      phoronix-test-suite
      stress-ng
      tor
      qalculate-qt
      anki-bin
      telegram-desktop
      spotify
      libreoffice

     # later:
     # self.packages.${pkgs.system}.myKitty
    ];

  };
}
