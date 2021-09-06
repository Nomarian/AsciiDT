#!/usr/bin/awk -f

BEGIN {
 q = "\""
 FS		= ENVIRON["FS"] ? ENVIRON["FS"] : "\x1f"
 OFS	= ","
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
 # create fields a la standard "" style
 for (i=NF+1;--i;) {
  gsub(/"/,q q,$i) # by RFC, a " is ""
  $i = q $i q 
 }
 print
}

