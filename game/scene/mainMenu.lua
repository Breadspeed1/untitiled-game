local SceneManager = require("scene.sceneManager")

---@class MainMenu : Scene
local MainMenu = require("util.object").inherit(require("scene.scene"))

function MainMenu.new()
	return setmetatable({
		name = "MainMenu",
	}, MainMenu)
end

function MainMenu:enter(prev)
	love.graphics.setBackgroundColor(31 / 255, 35 / 255, 46 / 255, 1)
	print("entering main menu from " .. (prev or "none"))
end

function MainMenu:update(dt) end

function MainMenu:draw()
	love.graphics.circle(
		"fill",
		love.graphics.getWidth() / 2,
		love.graphics.getHeight() / 2,
		math.abs(math.sin(love.timer.getTime() / 2) * 250)
	)
end

function MainMenu:exit()
	print("exiting main menu")
end

function MainMenu:keypressed(key, scancode, isrepeat)
	SceneManager:setScene("TestScene")
end

return MainMenu
