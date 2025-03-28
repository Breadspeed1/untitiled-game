local Object = {}

---Create a new Object
---@return table
function Object.new()
	local obj = {}
	obj.__index = obj
	return obj
end

---Create a new object which inherits from another object
---@param super table the super class
---@return table
function Object.inherit(super)
	local obj = Object.new()
	obj.super = super
	return setmetatable(obj, super)
end

return Object
