#! /bin/bash

VBR="1500k"
FPS="24"
QUAL="superfast"

YOUTUBE_URL="rtmp://a.rtmp.youtube.com/live2"
KEY="9kcr-pva6-dhp5-k2q4-2wyb"

VIDEO_SOURCE="/root/cover.gif"
AUDIO_SOURCE="https://radio.goop.house/radio/8000/radio.mp3"
NP_SOURCE="/root/song.txt"
FONT="/root/VinMonoPro-Light.ttf"

ffmpeg \
    -re -f lavfi -i "movie=filename=$VIDEO_SOURCE:loop=0, setpts=N/(FRAME_RATE*TB)" \
    -thread_queue_size 512 -i "$AUDIO_SOURCE" \
    -map 0:v:0 -map 1:a:0 \
    -map_metadata:g 1:g \
    -vf drawtext="fontfile=$FONT: \
        box=1: boxcolor=black@0.5: boxborderw=20: \
        textfile=$NP_SOURCE: reload=1: fontcolor=white: x=(w-text_w)/2: y=(h-text_h)/2" \
    -vcodec libx264 -pix_fmt yuv420p -preset $QUAL -r $FPS -g $(($FPS * 2)) -b:v $VBR \
    -acodec libmp3lame -ar 44100 -threads 6 -qscale:v 3 -b:a 320000 -bufsize 512k \
    -f flv "$YOUTUBE_URL/$KEY"
