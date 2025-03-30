local SceneManager = require("scene.sceneManager")
local InteractionRegion = require("ui.interactionRegion")
local MouseInteractions = require("ui.mouseInteractions")
local RectComponent = require("ui.uiComponent")

---@class MainMenu : Scene
local MainMenu = require("util.object").inherit(require("scene.scene"))

local Instance = setmetatable({
	name = "MainMenu",
}, MainMenu)

local size = 250

local testSquareComponent = RectComponent.new(
	function(x, y, width, height, isHovered)
		if isHovered then
			love.graphics.setColor(0.5, 0.5, 0.5)
		else
			love.graphics.setColor(1, 1, 1)
		end
		love.graphics.rectangle("fill", x, y, width, height)
	end,
	"consume",
	function()
		print("AHHH")
	end,
	love.graphics.getWidth() / 2 - size / 2,
	love.graphics.getHeight() / 2 - size / 2,
	size,
	size
)

function MainMenu:enter(prev)
	love.graphics.setBackgroundColor(31 / 255, 35 / 255, 46 / 255, 1)
	print("entering main menu from " .. (prev or "none"))
end

function MainMenu:update(dt)
	local curSize = math.abs(math.sin(love.timer.getTime() / 2) * size)
	local x = love.math.noise(love.timer.getTime() / 2) * 250 - 125
	local y = love.math.noise(-love.timer.getTime() / 2) * 250 - 125

	testSquareComponent:setDimensions(curSize, curSize)
	testSquareComponent:setPosition(
		love.graphics.getWidth() / 2 - curSize / 2 + x,
		love.graphics.getHeight() / 2 - curSize / 2 + y
	)
end

function MainMenu:draw()
	testSquareComponent:draw()
end

function MainMenu:registerUI()
	testSquareComponent:registerUI()
end

function MainMenu:exit()
	print("exiting main menu")
end

function MainMenu:keypressed(key, scancode, isrepeat) end

return Instance
