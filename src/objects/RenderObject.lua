-----------------------------------------
-- Base Class for rendering objects.
local class = require 'middleclass'
local color = require('colorise')
local defaults = {
	radius = 20
}

local RenderObject = class('RenderObject')


-----------------------
-- Creates a new RenderObject.
-- The options are:
-- - x: position x
-- - y: position y
-- - is_debug: debug flag
-- - radius: the radius for the draw circle
-- - label: (optional) a string representation of the object
-- @param opts The options for a render object
function RenderObject:initialize(opts)
	if opts == nil then opts = {} end
	self.x = opts.x or 0
	self.y = opts.y or 0
	self.is_debug = opts.is_debug or false
	self.radius = opts.radius or 20
	self.label = opts.label or nil
	self.color = opts.color or '#AA7239'
end


-----------------------------------
-- Renders the object.
-- The object draws itself at the x and y position.
-- Renders a circle and debug information if enabled.
function RenderObject:draw()
	-- Draw in place
	love.graphics.setColor(color.hex2rgb(self.color))
	love.graphics.circle("line", self.x, self.y, self.radius)
	love.graphics.setColor(0, 0, 0)
	if self.label then
		love.graphics.print(self.label, self.x, self.y)
	end
end

function RenderObject:release()
	-- Release things here
end


return RenderObject
