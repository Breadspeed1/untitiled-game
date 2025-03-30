---@class MouseInteractions
---@field regions MouseInteractionRegion[]
---@field lastX number?
---@field lastY number?
---@field curIndex number
---@field dx number
---@field dy number
local MouseInteractions = {
	regions = {},
	curIndex = 1,
	dx = 0,
	dy = 0,
}

function MouseInteractions:push(region)
	self.regions[self.curIndex] = region
	self.curIndex = self.curIndex + 1
end

function MouseInteractions:update()
	if not self.lastX then
		return
	end

	self:checkHover(self.lastX, self.lastY, self.dx, self.dy)
	self.dx = 0
	self.dy = 0
	self.curIndex = 1
end

function MouseInteractions:mouseMoved(x, y, dx, dy)
	self.lastX = x
	self.lastY = y
	self.dx = self.dx + dx
	self.dy = self.dy + dy
end

function MouseInteractions:checkHover(x, y, dx, dy)
	local consumedHover = false

	for i = self.curIndex - 1, 1, -1 do
		if self.regions[i]:isTriggered(x, y) and not consumedHover then
			self.regions[i]:notifyHover(x, y, dx, dy)
			if self.regions[i]:getMode() == "consume" then
				consumedHover = true
			end
		else
			self.regions[i]:notifyUnhover(x, y, dx, dy)
		end
	end
end

function MouseInteractions:mouseClicked(x, y, btn)
	self.lastX = x
	self.lastY = y

	for i = #self.regions, 1, -1 do
		if self.regions[i]:isTriggered(x, y) then
			self.regions[i]:notifyClick(x, y, btn)
			return
		end
	end
end

return MouseInteractions
