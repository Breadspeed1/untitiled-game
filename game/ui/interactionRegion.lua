---@alias MouseInteractionRegion.Mode "consume" | "passthrough"

---@class MouseInteractionRegion
---@field private detectionFunction fun(x: number, y: number): boolean
---@field private mode MouseInteractionRegion.Mode
---@field private clickCallback fun(x: number, y: number, btn: number)?
---@field private hoverCallback fun(x: number, y: number, dx: number, dy: number)?
---@field private unhoverCallback fun(x: number, y: number, dx: number, dy: number)?
local MouseInteractionRegion = require("util.object").new()

---Create a new rectangle detection function
---@param x number x coordinate of top left of the rectangle
---@param y number y coordinate of the top left of the rectangle
---@param height number height of the rectangle
---@param width number width of the rectangle
---@return fun(x: number, y: number): boolean #detection function
local rectangleFunction = function(x, y, width, height)
	return function(px, py)
		return px >= x and px <= (x + width) and py >= y and py <= (y + height)
	end
end

---Create a new circle detection function
---@param x number x coordinate of center of the circle
---@param y number y coordinate of the center of the circle
---@param r number radius of the circle
---@return fun(x: number, y: number): boolean #detection function
local cirlceFunction = function(x, y, r)
	local r2 = r ^ 2
	return function(px, py)
		return ((px - x) ^ 2 + (py - y) ^ 2) < r2
	end
end

---Create a new raw MouseInteractionRegion
---@param mode MouseInteractionRegion.Mode
---@param detectionFunction fun(x: number, y: number): boolean
---@param clickCallback fun(x: number, y: number, btn: number)?
---@param hoverCallback fun(x: number, y: number, dx: number, dy: number)?
---@param unhoverCallback fun(x: number, y: number, dx: number, dy: number)?
---@return MouseInteractionRegion
function MouseInteractionRegion.new(mode, detectionFunction, clickCallback, hoverCallback, unhoverCallback)
	return setmetatable({
		detectionFunction = detectionFunction,
		mode = mode,
		clickCallback = clickCallback,
		hoverCallback = hoverCallback,
		unhoverCallback = unhoverCallback,
	}, MouseInteractionRegion)
end

---Create a new rectangle MouseInteractionRegion
---@param mode MouseInteractionRegion.Mode
---@param x number x coordinate of top left of the rectangle
---@param y number y coordinate of the top left of the rectangle
---@param height number height of the rectangle
---@param width number width of the rectangle
---@param clickCallback fun(x: number, y: number, btn: number)?
---@param hoverCallback fun(x: number, y: number, dx: number, dy: number)?
---@param unhoverCallback fun(x: number, y: number, dx: number, dy: number)?
---@return MouseInteractionRegion
function MouseInteractionRegion.newRectangle(mode, x, y, width, height, clickCallback, hoverCallback, unhoverCallback)
	return MouseInteractionRegion.new(
		mode,
		rectangleFunction(x, y, width, height),
		clickCallback,
		hoverCallback,
		unhoverCallback
	)
end

---Create a new circle MouseInteractionRegion
---@param mode MouseInteractionRegion.Mode
---@param x number x coordinate of center of the cirlce
---@param y number y coordinate of the center of the circle
---@param r number radius of the circle
---@param clickCallback fun(x: number, y: number, btn: number)?
---@param hoverCallback fun(x: number, y: number, dx: number, dy: number)?
---@param unhoverCallback fun(x: number, y: number, dx: number, dy: number)?
---@return MouseInteractionRegion
function MouseInteractionRegion.newCircle(mode, x, y, r, clickCallback, hoverCallback, unhoverCallback)
	return MouseInteractionRegion.new(mode, cirlceFunction(x, y, r), clickCallback, hoverCallback, unhoverCallback)
end

function MouseInteractionRegion:notifyClick(x, y, btn)
	if self.clickCallback then
		self.clickCallback(x, y, btn)
	end
end

function MouseInteractionRegion:notifyHover(x, y, dx, dy)
	if self.hoverCallback then
		self.hoverCallback(x, y, dx, dy)
	end
end

function MouseInteractionRegion:notifyUnhover(x, y, dx, dy)
	if self.unhoverCallback then
		self.unhoverCallback(x, y, dx, dy)
	end
end

---Get the mode of this region
---@return MouseInteractionRegion.Mode
function MouseInteractionRegion:getMode()
	return self.mode
end

---Check if a position falls within the region
---@param x number
---@param y number
---@return boolean
function MouseInteractionRegion:isTriggered(x, y)
	return self.detectionFunction(x, y)
end

return MouseInteractionRegion
