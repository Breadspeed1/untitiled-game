---@class SceneManager
---@field private scenes table<string, Scene>
---@field private currentScene Scene?
---@field private nextScene Scene?
local SceneManager = {
	scenes = {},
}

---add a new scene
---@param scene Scene
function SceneManager:addScene(scene)
	self.scenes[scene.name] = scene
end

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
		local prev
		if not self.currentScene then
			self.currentScene = self.nextScene
		else
			self.currentScene:exit()
			prev = self.currentScene.name
			self.currentScene = self.nextScene
		end

		self.nextScene = nil
		self.currentScene:enter(prev)
	end

	self.currentScene:update(dt)
end

function SceneManager:draw()
	if self.currentScene then
		self.currentScene:draw()
	end
end

function SceneManager:mousemoved(x, y, dx, dy)
	if self.currentScene then
		self.currentScene:mousemoved(x, y, dx, dy)
	end
end

function SceneManager:mousepressed(x, y, btn)
	if self.currentScene then
		self.currentScene:mousepressed(x, y, btn)
	end
end

function SceneManager:keypressed(key, scancode, isrepeat)
	if self.currentScene then
		self.currentScene:keypressed(key, scancode, isrepeat)
	end
end

return SceneManager
