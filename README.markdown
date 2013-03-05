Photostream
=======

Makes it easer to access photos from your Photo Stream on a Mac.

This probably requires you to activate the Photo Stream in your iCloud
System Preferences.


How does it work?
------

When Photo Stream is active, the pictures actually get downloaded to your Mac,
but in a hard-to-navigate nested directory structure of hashes.

This tool just creates a new directory with hard links to all the files in that
nested directory structure. It uses `launchd` to monitor when new photos appear
and resyncs the directory any time a new photo appears on your computer.

We have to use hard links so that the Finder will display the image with a
thumbnail.
