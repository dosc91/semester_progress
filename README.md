# semester_progress

This R script creates a tsv-file for automatized scheduling of tweets to run a bot like [Semester Progress](https://twitter.com/sem_progress) or [sem_progress_hhu](https://twitter.com/sem_prog_hhu). It is inspired by the scripts for Python and Perl created by Simon Meier-Vieracker [here](https://github.com/fussballlinguist/semester_progress).

Analogously to the originaly scripts, you just have to adjust the beginning and the end dates and times of the time period of your interest (e.g. a semester). The script then calculates the length of the time period in seconds, divides it into 100 parts, and creates a tweet with a progress bar for exactly the point in time at which a further percentage step is reached. Each tweet contains a randomly selected German interjection.

As explained by Simon Meier-Vieracker, the output is compatible with [autoChirp](https://autochirp.spinfo.uni-koeln.de/home):

> The format of the ouput is compatible with autoChirp, a small and easy-to-use webapplication to ease the scheduled publication of the tweets. Just create a new twitter account, log in at autoChirp, upload the tsv-file and there you go.
