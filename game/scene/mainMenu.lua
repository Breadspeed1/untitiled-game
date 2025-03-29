local SceneManager = require("scene.sceneManager")
local InteractionRegion = require("ui.interactionRegion")
local MouseInteractions = require("ui.mouseInteractions")

---@class MainMenu : Scene
local MainMenu = require("util.object").inherit(require("scene.scene"))

local Instance = setmetatable({
	name = "MainMenu",
}, MainMenu)

---@type boolean
local hovered = false

---@type boolean
local subhovered = false

---@type MouseInteractionRegion.Mode
local subMode = "consume"

function MainMenu:enter(prev)
	love.graphics.setBackgroundColor(31 / 255, 35 / 255, 46 / 255, 1)
	print("entering main menu from " .. (prev or "none"))
end

local swapSubMode = function()
	if subMode == "consume" then
		subMode = "passthrough"
	else
		subMode = "consume"
	end
end

function MainMenu:update(dt)
	local x = love.graphics.getWidth() / 2
	local y = love.graphics.getHeight() / 2

	MouseInteractions:push(InteractionRegion.newCircle("consume", x, y, 250, function() end, function()
		hovered = true
	end, function()
		hovered = false
	end))

	MouseInteractions:push(InteractionRegion.newCircle(subMode, x, y, 125, function()
		swapSubMode()
	end, function()
		subhovered = true
	end, function()
		subhovered = false
	end))
end

function MainMenu:draw()
	if hovered then
		love.graphics.setColor(0.5, 0.5, 1)
	else
		love.graphics.setColor(1, 1, 1)
	end

	love.graphics.circle("fill", love.graphics.getWidth() / 2, love.graphics.getHeight() / 2, 250)

	if subhovered then
		love.graphics.setColor(1, 0.5, 0.5)
	else
		love.graphics.setColor(0.5, 0.5, 0.5)
	end

	love.graphics.circle("fill", love.graphics.getWidth() / 2, love.graphics.getHeight() / 2, 125)
end

function MainMenu:exit()
	print("exiting main menu")
end

function MainMenu:keypressed(key, scancode, isrepeat) end

return Instance
