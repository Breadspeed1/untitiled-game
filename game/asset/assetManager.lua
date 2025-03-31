---@class AssetManager
---@field fonts table<string, table<number, love.Font>>
local AssetManager = {
	fonts = {},
}

local DEFAULT_SIZE = 48
local DEFAULT_NAME = "yoster"

---Load a new font from a file
---@param name string
function AssetManager:loadFont(name, size)
	local fileName = "assets/fonts/" .. name .. ".ttf"
	if not self.fonts[name] then
		self.fonts[name] = {
			[size] = love.graphics.newFont(fileName, size),
		}
	elseif not self.fonts[name][size] then
		self.fonts[name][size] = love.graphics.newFont(fileName, size)
	end
end

---Retrieve a font
---@param name string
---@param size number
---@return love.Font
function AssetManager:getFont(name, size)
	if not self.fonts[name] or not self.fonts[name][size] then
		self:loadFont(name, size)
	end

	return self.fonts[name][size]
end

function AssetManager:getDefault()
	return AssetManager:getFont(DEFAULT_NAME, DEFAULT_SIZE)
end

return AssetManager
