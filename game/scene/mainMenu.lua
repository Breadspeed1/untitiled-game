local RectComponent = require("ui.uiComponent")
local Button = require("ui.button")

---@class MainMenu : Scene
local MainMenu = require("util.object").inherit(require("scene.scene"))

local Instance = setmetatable({
	name = "MainMenu",
}, MainMenu)

local testBtn = Button.newPrimary("START!", 0, 0, 300, 100, function()
	print("erm guys?")
end)

testBtn:center()

function MainMenu:enter(prev)
	love.graphics.setBackgroundColor(31 / 255, 35 / 255, 46 / 255, 1)
end

function MainMenu:update(dt) end

function MainMenu:draw()
	testBtn:draw()
end

function MainMenu:registerUI()
	testBtn:registerUI()
end

function MainMenu:exit()
	print("exiting main menu")
end

function MainMenu:keypressed(key, scancode, isrepeat) end

return Instance
