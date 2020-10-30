#!/usr/bin/env lua5.4

FS="\t"
OFS="\031" -- output field separator (unit)
ORS="\030" -- output record separator
ofs="\028" -- output file separator

for k,file in ipairs(arg) do
 io.write(file .. ofs)
 for line in io.lines(file) do
  io.write( line:gsub(FS,OFS) .. ORS )
 end
end
