local MouseInteractions = require("ui.mouseInteractions")
local InteractionRegion = require("ui.interactionRegion")

---@class RectComponent
---@field drawFn fun(x: number, y: number, width: number, height: number, isHovered: boolean)
---@field x number
---@field y number
---@field width number
---@field height number
---@field scale number
---@field interactionRegion MouseInteractionRegion
---@field hovered boolean
---@field clickCallback fun(x, y, btn)
local RectComponent = require("util.object").new()

---Create a new rectangle component
---@param x number starting x position
---@param y number starting y position
---@param width number starting width
---@param height number starting height
---@param drawFn fun(x: number, y: number, width: number, height: number, isHovered: boolean)
---@param hoverMode MouseInteractionRegion.Mode
---@param clickCallback fun(x, y, btn)
---@return RectComponent
function RectComponent.new(drawFn, hoverMode, clickCallback, x, y, width, height)
	local base = {
		drawFn = drawFn,
		x = x,
		y = y,
		width = width,
		height = height,
		clickCallback = clickCallback,
		hovered = false,
		scale = 1,
	}

	base.interactionRegion = InteractionRegion.newRectangle(
		hoverMode,
		function()
			return base.x
		end,
		function()
			return base.y
		end,
		function()
			return base.width * base.scale
		end,
		function()
			return base.height * base.scale
		end,
		clickCallback,
		function()
			base.hovered = true
		end,
		function()
			base.hovered = false
		end
	)

	return setmetatable(base, RectComponent)
end

---Set the position of the component
---@param x number
---@param y number
function RectComponent:setPosition(x, y)
	self.x = x
	self.y = y
end

---Set the height and width of the component
---@param width number
---@param height number
function RectComponent:setDimensions(width, height)
	self.width = width
	self.height = height
end

---Set the scale of the commponent
---@param scale number
function RectComponent:setScale(scale)
	self.scale = scale
end

---Draw the component to the screen
function RectComponent:draw()
	love.graphics.push("all")
	self.drawFn(self.x, self.y, self.width * self.scale, self.height * self.scale, self:isHovered())
	love.graphics.pop()
end

---Register the interaction region
function RectComponent:registerUI()
	MouseInteractions:push(self.interactionRegion)
end

---Check if the component is hovered
---@return boolean
function RectComponent:isHovered()
	return self.hovered
end

return RectComponent
