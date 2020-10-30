#!/usr/bin/awk -f

BEGIN {
 FS=""
 OFS="\x1f" # output field separator (unit)
 ORS="\x1e" # output record separator
 ofs="\x28" # output file separator
}

lastfile != FILENAME {
 printf FILENAME ofs
 lastfile=FILENAME
}

{
 gsub(/\t/,OFS)
 print
}
