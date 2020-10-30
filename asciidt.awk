
BEGIN {
 FS="\x1f" # field separator (unit)
 RS="\x1e" # record separator
 fileseparator="\x1c" # file separator
}

$0 ~ fileseparator {
 match($0,"^.+" fileseparator)
 file = substr($0,RSTART,RLENGTH-1)
 $0 = substr($0,RSTART+RLENGTH) # resets NF and so on
}
