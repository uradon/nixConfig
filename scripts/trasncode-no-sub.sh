for f in *.mkv; do
  ffmpeg -hwaccel vaapi -hwaccel_device /dev/dri/renderD128 -hwaccel_output_format vaapi -i "$f" \
  -map 0:v -map 0:a -c:v hevc_vaapi -rc_mode CQP -qp 25 -c:a copy "${f%.mkv}.mp4"
done

