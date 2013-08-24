valiant
=======

A script for enhancing mp3 tracks for interval training (fitness)

What it does
------------
This script allows the user to add intervals (beeps) to an existing mp3 track.  This is useful for [Interval Training](http://en.wikipedia.org/wiki/Interval_training "Interval Training").
Currently it adds 2 beeps at the start of the track (10s in) followed by a single beep every 30s for the duration of the track.

Usage
-----
`./valiant.sh  track.mp3`
 where _track.mp3_ is the mp3 to convert

Dependencies
------------
* SoX − Sound eXchange, the Swiss Army knife of audio manipulation (`sudo apt-get install sox`)
* lame - create mp3 audio files (`sudo apt-get install lame`)

Known issues
------------
* Cannot handle spaces in filenames (!)

Wishlist
--------
* Should be able to span multiple tracks or at least concatenate multiple tracks.

