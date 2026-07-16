{ inputs, self, ... }:


{
  flake.homeModules.watchEpisode = { config, pkgs, lib, ... }:
  let
    cfg = config.programs.watch_episode;
  in
  {    
    options.programs.watch_episode.enable = lib.mkEnableOption "mpv CLI tool";

    config = lib.mkIf cfg.enable {
      home.packages = [
	(pkgs.writeShellScriptBin "watch_episode" ''
	  num=$(printf "%02d" "$1")

	  file=$(find . -type f -name "*.mkv" | grep -E "([ ._-]|^)[Ee]?[0-9]*0?$num([ ._-]|$)" | head -n1)
	  
	  
	  mpv "$file" --sub-auto=fuzzy
	'')
      ];
    };
  };
}
