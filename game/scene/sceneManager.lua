---@class SceneManager
---@field scenes Scene[]
---@field currentScene Scene | nil
---@field nextScene Scene | nil
local SceneManager = {
	scenes = {},
}
---Set the scene for the next loop
---@param name string
function SceneManager:setScene(name)
	if not self.scenes[name] then
		error("Unknown scene " .. name)
	end

	self.nextScene = self.scenes[name]
end

---Update the scene manager
---@param dt number
function SceneManager:update(dt)
	if not self.currentScene and not self.nextScene then
		return
	end

	if self.nextScene then
		if not self.currentScene then
			self.currentScene = self.nextScene
		else
			self.currentScene:exit()
			self.currentScene = self.nextScene
		end

		self.nextScene = nil
		self.currentScene:enter()
	end

	self.currentScene:update(dt)
end
