#!/bin/bash
echo Number of args: $#
if [ $# -lt 1 ]; then
    echo "Usage: " $0 " <track.mp3>"
    echo "        where <track.mp3> is the mp3 to convert"
    exit 1
fi

BASENAME=$(basename $1)
OUTPUT="${BASENAME%%.*}"-iv."${BASENAME#*.}"
echo Creating $OUTPUT...
echo

# convert mp3 to wav
lame --decode $1 source.wav

# generate various silences and sounds
sox -n -r 44100 -c 2 start.wav synth 0.25 sine 1000
sox -n -r 44100 -c 2 silence10s.wav trim 0.0 10
sox -n -r 44100 -c 2 silence100ms.wav trim 0.0 0.2
sox -n -r 44100 -c 2 silence29s.wav trim 0.0 29
sox -n -r 44100 -c 2 sine.wav synth 0.25 sine 1400.0

# make initial wav
sox silence10s.wav start.wav silence100ms.wav start.wav temp.wav


LEN=`soxi -D temp.wav`
SOURCELEN=`soxi -D source.wav`
LONGENOUGH=`echo "$LEN > $SOURCELEN" | bc`

# append silence/interval until length is bigger than source length
until [ "$LONGENOUGH" -eq "1" ]; do
   sox temp.wav silence29s.wav sine.wav interval.wav
   cp interval.wav temp.wav
   LEN=`soxi -D temp.wav`
# progress indicator
   echo $LEN
   LONGENOUGH=`echo "$LEN > $SOURCELEN" | bc`
done

# mix intervals and music
sox -m interval.wav source.wav source-iv.wav

# convert wav to mp3 with reasonable quality
lame -h source-iv.wav $OUTPUT

# cleanup
rm source.wav
#rm start.wav
#rm silence*.wav
#rm sine.wav
rm source-iv.wav
rm temp.wav
