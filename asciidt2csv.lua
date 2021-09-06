#!/usr/bin/env lua

local FS	= os.getenv"FS" and os.getenv"FS" or "\x1f"
local OFS	= ","
local RS	= os.getenv"RS" and os.getenv"RS" or "\x1e"

-- set differently in case of windows or mac
local ORS	= os.getenv"ORS" and os.getenv"ORS" or "\n"

-- todo buffered
local function main(file)
 local f = io.open(file)
 -- this should be a buffer
 for record in f:read"a":gmatch("[^" .. RS .. "]+") do
  local fields,i = {},1
  for field in record:gmatch("[^" .. FS .. "]+") do
   field = '"' .. field:gsub('"','""') .. '"' -- create fields a la standard "" style
   fields[i],i = field,i+1
  end

  io.write(
   table.concat(fields,OFS) .. ORS
  )
 end
end

main(arg[1])

for i=2,#arg do 
 if os.getenv"FILESEPARATOR" then io.write"\x1c" end
  main(file)
end
