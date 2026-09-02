for f in *.mkv; do
  ffmpeg -init_hw_device vaapi=va:/dev/dri/renderD128 -hwaccel vaapi -hwaccel_device va -hwaccel_output_format vaapi -i "$f" \
  -filter_complex "[0:v]hwdownload,format=p010le,subtitles=filename='${f%.mkv}.ass':original_size=1920x1080,hwupload[v]" \
  -filter_hw_device va -map "[v]" -map 0:a -c:v hevc_vaapi -rc_mode CQP -qp 18 -profile:v main10 -c:a copy "${f%.mkv}.mp4"
done

