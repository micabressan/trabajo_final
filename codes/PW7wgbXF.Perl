Alias name: run lua code
Pattern: ^lua (.*)$
Script: 

local f,e = loadstring("return "..matches[2])
if not f then
	f,e = assert(loadstring(matches[2]))
end

local r = f()
if r ~= nil then display(r) end