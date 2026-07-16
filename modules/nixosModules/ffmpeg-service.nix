{ inputs, self, ... }:

{
  flake.nixosModules.ffmpegService = { pkgs, lib, config, ... }: 
  let
    job_dir = "/srv/ffmpeg-jobs";
  in	
  {
    options.ffmpeg-service.enable =
      lib.mkEnableOption "enables ffmpeg job runner service";

    config = lib.mkIf config.ffmpeg-service.enable {
      users.groups.ffmpeg-runner = {};

      users.users.ffmpeg-usr = {
	isSystemUser = true;
	group = "ffmpeg-runner";
	home = job_dir;
	createHome = false;
      };
      
      systemd.paths.ffmpeg-watch = {
	wantedBy = [ "multi-user.target" ];
	pathConfig = {
	  PathChanged = "${job_dir}/incoming";
	  Unit = "ffmpeg-worker@.service";
	};
      };
      
      systemd.services."ffmpeg-worker@" = {
	description = "ffmpeg worker";
	serviceConfig = {
	  Type = "oneshot";
	  User = "ffmpeg-usr";
	  Group = "ffmpeg-runner";
	  ReadWritePaths = [ "${job_dir}" ];
	};

      path = [ pkgs.ffmpeg pkgs.coreutils ];

      script = ''
	shopt -s nullglob
	for file in ${job_dir}/incoming/*; do
	  [ -f "$file" ] || continue

	  name="$(basename "$file")"
	  input="${job_dir}/processing/$name"
	  output="${job_dir}/done/$name.mp4"

	  mv "$file" "$input"

	  ffmpeg -i "$input" "$output"
	done
      '';
      };
      
    };
  };
}
