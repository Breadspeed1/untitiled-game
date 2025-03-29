local SceneManager = require("scene.sceneManager")
local InteractionRegion = require("ui.interactionRegion")
local MouseInteractions = require("ui.mouseInteractions")

---@class TestScene : Scene
local TestScene = require("util.object").inherit(require("scene.scene"))

local Instance = setmetatable({
	name = "TestScene",
}, TestScene)

---@type boolean
local hovered = false

function TestScene:enter(prev)
	love.graphics.setBackgroundColor(31 / 255, 35 / 255, 46 / 255, 1)
	print("entering test scene from " .. (prev or "none"))
end

function TestScene:update(dt)
	local size = math.abs(math.sin(love.timer.getTime() / 2) * 500)
	local x = love.graphics.getWidth() / 2 - size / 2
	local y = love.graphics.getHeight() / 2 - size / 2

	MouseInteractions:push(InteractionRegion.newRectangle("consume", x, y, size, size, function()
		SceneManager:setScene("MainMenu")
	end, function()
		hovered = true
	end, function()
		hovered = false
	end))
end

function TestScene:draw()
	if hovered then
		love.graphics.setColor(1, 0.5, 0.5)
	else
		love.graphics.setColor(1, 1, 1)
	end

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
	print("exiting test scene")
end

function TestScene:mousepressed(x, y, btn) end

return Instance
