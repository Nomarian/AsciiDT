# Ascii Delimited Text Format

# Synopsis

This basically converts many file formats to ascii delimited text.


# Description

ascii delimited text is a format which uses control characters to delimit the file, any special characters is labeled as such and should be handled by a simple gsub.


# Benefits

Using control characters to label means there is no need for parsing. This leads to a speedup in some cases and the handling by any programming language without a requirement for huge libraries.

# Formats

## CSV
 Record Separator: 1E (Record Separator)
 Field Separator: 1f (Unit Separator)


# Examples

 ./csv2asciidt.awk file.csv | awk 'BEGIN {RS="\x1e";FS="\x1f"}'
