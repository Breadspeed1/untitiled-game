local SceneManager = require("scene.sceneManager")

---@class TestScene : Scene
local TestScene = require("util.object").inherit(require("scene.scene"))

function TestScene.new()
	return setmetatable({
		name = "TestScene",
	}, TestScene)
end

function TestScene:enter(prev)
	love.graphics.setBackgroundColor(31 / 255, 35 / 255, 46 / 255, 1)
	print("entering test scene from " .. (prev or "none"))
end

function TestScene:update(dt) end

function TestScene:draw()
	local size = math.abs(math.sin(love.timer.getTime() / 2) * 500)

	love.graphics.rectangle(
		"fill",
		love.graphics.getWidth() / 2 - size / 2,
		love.graphics.getHeight() / 2 - size / 2,
		size,
		size
	)
end

function TestScene:exit()
	print("exiting main menu")
end

function TestScene:mousepressed(x, y, btn)
	SceneManager:setScene("MainMenu")
end

return TestScene
