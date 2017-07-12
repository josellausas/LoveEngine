--------------------------------------
-- A Level Map.
-- The grid that represents the entire map grid on which the game can happen.
-- This acts as the contraints for the camera.
local class = require('middleclass')

local LevelMap = class('LevelMap')

---------------------------------------------------------------
-- Creates a new LevelMap.
-- Need to provide the number of tiles and size of tiles
function LevelMap:initialize(numTilesX, numTilesY, tileSize, opts)
	self.numTilesX = numTilesX
	self.numTilesY = numTilesY
	self.width = numTilesX * tileSize
	self.height = numTilesY * tileSize
	self.tileSize = tileSize
	-- TODO: Make color dynamic
	self.line_color = opts.line_color or '#ffffff'
	self.background_color = opts.background_color or '#000000'
	self.xOffset = opts.x_offset or 0
	self.yOffset = opts.y_offset or 0

	-- Boundaries
	self.minX = self.xOffset
	self.minY = self.yOffset
	self.maxX = self.xOffset + self.width
	self.maxY = self.yOffset + self.height
end

--------------------------------------------------------------------
-- Draws itself.
function LevelMap:draw()
	love.graphics.setColor(0, 128, 0)
	love.graphics.rectangle( "fill", self.xOffset, self.yOffset, self.width, self.height )
	love.graphics.setColor(0, 0, 0)
end

----------------------------------------
-- Get Tile XY.
-- Given a point returns the XY coords for a tile or nil if outside the level
function LevelMap:getTileXY(posX, posY)
	if posX < self.minX then return nil, nil end
	if posX > self.maxX then return nil, nil end

	if posY < self.minY then return nil, nil end
	if posY > self.maxY then return nil, nil end

	local xTile = math.floor((posX - self.xOffset) / self.tileSize)
	local yTile = math.floor((posY - self.yOffset) / self.tileSize)

	return xTile, yTile
end

return LevelMap
