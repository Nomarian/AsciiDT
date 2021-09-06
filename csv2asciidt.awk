#!/usr/bin/awk -f

# Setting CSVEVENFIELDS to anything will warn if fields are uneven
# Setting CSVEVENFIELDS to 2 will exit
# Setting FILESEPARATOR will output the ascii file separator in between each file
# ftm I've never had to use this so its not modifiable
# Setting OFS will output that OFS
# Setting ORS will output that ORS

# ---------- Units/csv.awk

# Will convert all tokens into a field

BEGIN {
 FS		= "\037"
 
 OFS	= ENVIRON["OFS"] ? ENVIRON["OFS"] : "\x1f" # output field separator
 ORS	= ENVIRON["ORS"] ? ENVIRON["ORS"] : "\x1e" # output record separator
}

lastfile != FILENAME {
 if (ENVIRON["FILESEPARATOR"]) {
  printf FILENAME "\x1c" # output file separator
  lastfile=FILENAME
 }
}

# Multi-Line String
 # csvrecord is empty AND stringisodd ||
  # OR csvrecord is not empty and string is anything or StringIsEven
(!csvrecord && /^("[^"]*"|[^"])*"[^"]*$/) || (csvrecord && /^([^"]|"[^"]*")*$/) {
 csvrecord = csvrecord $0 ORS; NR--; next
}

{
 csvrecord = csvrecord $0
 $0="" # I think this erases NF but it differs between awks

 # Can't split(/","/) so this if is a workaround
  # also this regex looks long and complicated, its just /^z*$|^z*,z$/
  # z is match [not a comma or quotes]| quotation
 if ( csvrecord ~ /^([^",]*|"([^",]|"")*")*$|^(([^",]*|"([^",]|"")*")*,([^",]*|"([^",]|"")*")*)+$/ ) {
	NF = split(csvrecord,csvfields,/,/) # This works if theres no ","
	for ( i=1;i<=NF;i++ ) $i = csvfields[i]
  } else {
   while( match(csvrecord,/^([^",]|"([^"]|"")*")*,/) ){
	$(++NF)		= substr(csvrecord,RSTART,RLENGTH-1)
	csvrecord	= substr(csvrecord,RSTART+RLENGTH)
   }
	$(++NF) = csvrecord
 }
 csvrecord = ""
}

!lnf { lnf = NF }
NF != lnf {
 if (ENVIRON["CSVEVENFIELDS"]>0)
  printf("Record %i has an uneven number of fields\n",NR) > "/dev/stderr"

 if (ENVIRON["CSVEVENFIELDS"]==2) exit 1
}

END {
 divider = "---------------------------"

 if (csvrecord) {
	printf("Unterminated record\t%i\n%sRecord:\n%s\n\n",NR,divider,csvrecord) > "/dev/stderr"
	exit 1
 }
}

# clear double "" which means a single "
# get rid of the starting " and ending " if any
{ # there should be an option indicating the type of csv file, sometimes this isn't necessary
 for (i=NF+1;--i;) {
  if ($i ~ /^".+"$/) $i = substr($i,2,length($i)-2 ) # enough for most occassions
  # sub(/^"/,"",$i);sub(/"$/,"",$i)
  gsub(/""/,"\"",$i)
 }
 print
}

