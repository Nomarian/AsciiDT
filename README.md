# Ascii Delimited Text Format

# Synopsis

This basically converts many file formats to ascii delimited text.


# Description

ascii delimited text is an intermediary format which uses control characters to delimit the file.


# Benefits

Using control characters to label means there is no need for parsing. This leads to a speedup in some cases and the handling by any programming language without a requirement for huge libraries.


# Formats

when you use format2asciidt, the characters should behave like so.


## CSV
 Record Separator: 1E (Record Separator)
 Field Separator: 1F (Unit Separator)

## TSV
 Record Separator:  1E (Record Separator)
 Field Separator:	1F (Unit Separator)


# Bugs
 There is an assumption that the text will not have the control characters


 Having the characters would mean having an escape character. defeating the purpose of the format


# Examples

 ./csv2asciidt.awk file.csv | awk 'BEGIN {RS="\x1e";FS="\x1f"}'
