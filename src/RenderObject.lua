-----------------------------------------
-- Base Class for rendering objects.
local RenderObject = class('RenderObject')
local class = require 'middleclass'
local defaults = {
	radius = 20
}

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
	self.x = opts.x or 0
	self.y = opts.y or 0
	self.is_debug = opts.is_debug or false
	self.radius = opts.radius or 20
	self.label = opts.label or nil
end

-----------------------------------
-- Renders the object.
-- The object draws itself at the x and y position.
-- Renders a circle and debug information if enabled.
function RenderObject:draw()
	-- Draw in place
	love.graphics.setColor(255, 0, 0)
	love.graphics.circle("line", self.x, self.y, self.radius)
	love.graphics.setColor(0, 0, 0)
	if self.label then
		love.graphics.print(self.label, self.x, self.y)
	end
end


return RenderObject
