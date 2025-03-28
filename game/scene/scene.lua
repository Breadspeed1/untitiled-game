---@class Scene
---@field name string the name of the scene
local Scene = require("game.util.object").new()

---Create a new scene
---@param name any
---@return Scene
function Scene.new(name)
	return setmetatable({
		name = name,
	}, Scene)
end

---Enter the scene
function Scene:enter()
	error("Enter not implimented for scene " .. self.name)
end

---Update the scene
---@param dt number
function Scene:update(dt)
	error("Update not implemented for scene " .. self.name)
end

---Draw the scene
---@param self Scene
function Scene:draw()
	error("Draw not implemented for scene " .. self.name)
end

---Exit the scene
function Scene:exit()
	error("End not implemented for scene " .. self.name)
end

return Scene
