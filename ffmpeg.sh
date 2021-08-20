ffmpeg \
    -re -f lavfi -i "movie=filename=/root/cover.gif:loop=0, setpts=N/(FRAME_RATE*TB)" \
    -thread_queue_size 512 -i "https://radio.goop.house/radio/8000/radio.mp3" \
    -map 0:v:0 -map 1:a:0 \
    -map_metadata:g 1:g \
    -vf drawtext="fontfile=/root/VinMonoPro-Light.ttf: \
        box=1: boxcolor=black@0.5: boxborderw=20: \
        textfile=/root/song.txt: reload=1: fontcolor=white: fontsize=(h/30): x=w-tw-30:y=h-th-30" \
    -vcodec libx264 -pix_fmt yuv420p -preset superfast -r 25 -g $((25 * 2)) -b:v 1500k \
    -acodec libmp3lame -ar 44100 -threads 6 -qscale:v 3 -b:a 320000 -bufsize 512k \
    -f flv "[INSERT yt livestream key]"
