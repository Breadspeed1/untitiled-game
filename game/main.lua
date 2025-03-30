local SceneManager = require("scene.sceneManager")
local MouseInteractions = require("ui.mouseInteractions")

function love.load()
	SceneManager:addScene(require("scene.mainMenu"))
	SceneManager:addScene(require("scene.testScene"))

	SceneManager:setScene("MainMenu")
end

function love.update(dt)
	MouseInteractions:update()
	SceneManager:registerUI()
	SceneManager:update(dt)
end

function love.draw()
	SceneManager:draw()
end

function love.mousemoved(x, y, dx, dy)
	SceneManager:mousemoved(x, y, dx, dy)
	MouseInteractions:mouseMoved(x, y, dx, dy)
end

function love.mousepressed(x, y, btn)
	SceneManager:mousepressed(x, y, btn)
	MouseInteractions:mouseClicked(x, y, btn)
end

function love.keypressed(key, scancode, isrepeat)
	SceneManager:keypressed(key, scancode, isrepeat)
end
