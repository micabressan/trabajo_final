--Fixed RemoteSpy by Internecivus
--Credit to Autumn for the original
--If I see this shit floating around on v3rm with others taking credit for it I'm not making any more fancy toys for you

--May still buggy, but I've gotta head to sleep now so I'm releasing what I've got so far.

local enabled = {
  -- Set any of these objects to false to stop logging them
  BindableEvent = false;
  BindableFunction = false;
  RemoteEvent = true;
  RemoteFunction = true;
}

local ignore = {
  -- Any remotes matching the names listed below will be ignored
  Event = true;
}

local meta,oldmeta = getrawmetatable(game),{}
for i,v in next,meta do oldmeta[i] = v end
function formatargs(args,showkeys)
  if type(args) ~= "table" then args = {args} end
  if #args == 0 then return "N/A" end
  local strargs = {}
  for k,v in next,args do
      local argstr = ""
      if type(v) == "string" then
          argstr = "\"" .. v .. "\""
      elseif type(v) == "table" then
          argstr = "{" .. formatargs(v,true) .. "}"
      else
          argstr = tostring(v)
      end
      if showkeys and type(k) ~= "number" then
          table.insert(strargs,k.."="..argstr)
      else
          table.insert(strargs,argstr)
      end
  end
  return table.concat(strargs, ", ")
end
local realmethods = {}
realmethods.Fire = Instance.new("BindableEvent").Fire
realmethods.Invoke = Instance.new("BindableFunction").Invoke
realmethods.FireServer = Instance.new("RemoteEvent").FireServer
realmethods.InvokeServer = Instance.new("RemoteFunction").InvokeServer
meta.__namecall = function(t,...)
  local args = {...}
  local k = args[#args]
  if (k == "Fire" or k == "Invoke" or k == "FireServer" or k == "InvokeServer") and (enabled[t.ClassName] and not ignore[t.Name]) then
          ret = oldmeta.__namecall(t,...)
          table.remove(args)
          copystring(t.ClassName.." called!\nPath: "..t:GetFullName().."\n".."Args: "..formatargs(args).."\nReturn: "..formatargs(ret)) --change copystring to the copystring function, or leave it as be if it's the same
         warn(t.ClassName.." called!\nPath: "..t:GetFullName().."\n".."Args: "..formatargs(args).."\nReturn: "..formatargs(ret))
          return ret
  else
      return oldmeta.__namecall(t,...)
  end
end