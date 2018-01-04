local std = require("stdlua")

local item = class 
{
	public = 
	{
		value = nil,
		next = nil,
		prev = nil
	}
}

function item:construct(prev, next, data)
	self.value = data
	self.prev = prev
	self.next = next
end

local deque = class
{ "deque",
	public =
	{
		first = item(),
		last = item(),
		numElements = 0
	}
}

function deque:construct()
	self.first.next= self.last
	self.last.prev = self.first
end

function deque:size()
	return self.numElements
end

function deque:push_front(obj)
	local new = item(self.first, self.first.next, obj)
	
	if self.first.next then
		self.first.next.prev = new
	end
	
	self.first.next = new
	self.numElements = self.numElements + 1
	
	if self.numElements == 1 then
		self.last.prev = new
	end
end

function deque:push_back(obj)
	local new = item(self.last.prev, self.last, obj)
	
	if self.last.prev then
		self.last.prev.next = new
	end
	
	self.last.prev = new
	self.numElements = self.numElements + 1
	
	if self.numElements == 1 then
		self.first.next = new
	end
end

function deque:at(idx)
	local item = self.first
	for i = 1, idx, 1 do
		if item == nil then -- FIXME Exception?
			return nil
		end
		
		item = item.next
	end
	
	return item.value
end

function deque:erase(first, last)
	-- Find first element
	local item = self.first
	for i = 1, first, 1 do
		if item == nil then -- FIXME Exception?
			return nil
		end
		
		item = item.next
	end
	
	if last then
		for i = first, last, 1 do
			item.prev.next = item.next
			item.next.prev = item.prev
		end
	else
		item.prev.next = item.next
		item.next.prev = item.prev
	end
end

function deque:front() -- FIXME Exception?
	if self:size() > 0 then
		return self.first.next.value
	end
end

function deque:back() -- FIXME Exception?
	if self:size() > 0 then
		return self.last.prev.value
	end
end

function deque:pop_front() -- FIXME Exception?
	if self:size() > 0 then
		self.first.next = self.first.next.next
		self.first.next.prev = self.first
	end
end

function deque:pop_back() -- FIXME Exception?
	if self:size() > 0 then		
		self.last.prev = self.last.prev.prev
		self.last.prev.next = self.last
	end
end

return deque