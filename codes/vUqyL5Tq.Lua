--[[
luasysfs
Copyright (C) 2011 by Carl Ådahl

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
]]

lfs = require "lfs"

function readFile(path)
  local file = io.open(path, 'r')
  local line = file and file:read('*line')
  file:close()
  return line
end

local sysmt = {}

function sysmt.__index(table, key)
  
  -- First see if the table is cached.  
  local val = rawget(table,key)
  if val ~= nil then
    return val
  end
  
  local path = table.path .. "/" .. key
  local mode = lfs.attributes(path).mode
  
  if mode == "directory" or mode == "link" then
    -- Generate a new dir table and cache it.
    val = setmetatable({ path = path }, sysmt)
    rawset(table,key,val)
  elseif mode == "file" then
    -- Grab the contents of the file and convert to number.
    val = readFile(path)
    val = tonumber(val) or val
  end
  
  return val
end

return setmetatable({ path = "/sys" }, sysmt)