local RectComponent = require("ui.uiComponent")

---@class Button : RectComponent
---@field text string
---@field color rgba
local Button = require("util.object").inherit(RectComponent)

---@alias rgba { r: number, g: number, b: number, a: number }

local DEFAULT_PRIMARY = {
	r = 149 / 255,
	g = 197 / 255,
	b = 172 / 255,
	a = 1,
}

---Create a new button
---@param text string
---@param x number
---@param y number
---@param width number
---@param height number
---@param onClick fun(x: number, y: number, btn: number)
---@param color rgba
---@return Button
function Button.new(text, x, y, width, height, onClick, color)
	local base = RectComponent.new(function() end, "consume", onClick, x, y, width, height) --[[@as Button]]

	setmetatable(base, Button)

	base.drawFn = function(x, y, width, height, isHovered)
		base:drawBtn(x, y, width, height, isHovered)
	end

	base.text = text
	base.color = color

	return base
end

function Button.newPrimary(text, x, y, width, height, onClick)
	return Button.new(text, x, y, width, height, onClick, DEFAULT_PRIMARY)
end

function Button:center()
	local w = love.graphics.getWidth()
	local h = love.graphics.getHeight()
	self:setPosition(w / 2 - self.width / 2, h / 2 - self.height / 2)
end

function Button:drawBtn(x, y, w, h, isHovered)
	local textHeight = love.graphics.getFont():getHeight()
	local textWidth = love.graphics.getFont():getWidth(self.text)

	local div = 1

	if isHovered then
		div = 1.3
	end

	love.graphics.setColor(self.color.r / div, self.color.g / div, self.color.b / div, self.color.a)

	love.graphics.rectangle("fill", x + 1, y + 1, w - 1, h - 1)

	love.graphics.setColor(0, 0, 0, 1)

	love.graphics.print(self.text, x + w / 2 - textWidth / 2, y + h / 2 - textHeight / 2)

	love.graphics.setLineWidth(8)

	love.graphics.rectangle("line", x, y, w, h)
end

return Button
