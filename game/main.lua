local SceneManager = require("scene.sceneManager")

function love.load()
	SceneManager:addScene(require("scene.mainMenu").new())
	SceneManager:addScene(require("scene.testScene").new())

	SceneManager:setScene("MainMenu")
end

function love.update(dt)
	SceneManager:update(dt)
end

function love.draw()
	SceneManager:draw()
end

function love.mousemoved(x, y, dx, dy)
	SceneManager:mousemoved(x, y, dx, dy)
end

function love.mousepressed(x, y, btn)
	SceneManager:mousepressed(x, y, btn)
end

function love.keypressed(key, scancode, isrepeat)
	SceneManager:keypressed(key, scancode, isrepeat)
end
