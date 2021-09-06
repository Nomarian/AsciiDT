#!/usr/bin/awk -f

BEGIN {
 FS		= ENVIRON["FS"] ? ENVIRON["FS"] : "\x1f"
 OFS	= "\t"
 RS		= ENVIRON["RS"] ? ENVIRON["RS"] : "\x1e"
 ORS	= ENVIRON["ORS"] ? ENVIRON["ORS"] : "\n" # in case of windows or mac, set ORS
}

lastfile != FILENAME {
 if (ENVIRON["FILESEPARATOR"]) {
  printf FILENAME "\x1c" # output file separator
  lastfile=FILENAME
 }
}

{
 gsub(FS,OFS) # no clue why this is necessary
 print
}
