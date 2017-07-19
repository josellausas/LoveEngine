------------------------------------------
-- Window Class.
-- A window for UI.
local class = require 'middleclass'
local RenderObject = require 'src.objects.RenderObject'
local color = require 'colorise'

--- The Window Class
local Window = class('Window', RenderObject)


------------------------------------------------
-- Create a new Window.
-- Creates a new Window instance. Need to provide width and height.
-- @param width The window's width. The number of units wide.
-- @param height The window's height. The number of units tall.
-- @return *Window* A Window instance.
function Window:initialize(width, height, opts)
	if not opts then opts = {} end
	RenderObject.initialize(self, opts)
	self.width = width or 200
	self.height = height or 200
	self.rect_color = opts.rect_color or '#0000CC'
	self.draw_mode = opts.draw_mode or 'fill'
	self.is_open = opts.is_open or true
end


---------------------------------------------------------------
-- Draws itself.
-- Draws the window and if `is_debug` is on the base object ontop.
function Window:draw()
	if self.is_open then
		-- Draw ourselves
		love.graphics.setColor(color.hex2rgb(self.rect_color))
		love.graphics.rectangle( self.draw_mode, self.x, self.y, self.width, self.height )
	else
		-- TODO: Draw a closed representation
	end

	-- Draw parent
	if self.is_debug then
		Window.draw(self)
	end
end


---------------------------------------------------------------
-- Checks for collision with a point.
-- Returns true if point is inside Window.
-- @param x The x coordinate of the point.
-- @param y The y coorinate of the point.
function Window:isPointInside(x, y)
	if not self.is_open then
		-- TODO: Implement minimized version
		return false
	end

	-- Calculte x and y constraints
	local min_x = self.x 					-- Leftmost
	local min_y = self.y 					-- Topmost
	local max_x = self.x + self.width 		-- Rightmost
	local max_y = self.y + self.height 		-- Bottommost

	-- Needs to be inside x and y constraints
	if x >= min_x and x <= max_x then
		if y >= min_y and y <= max_y then
			-- Point is inside
			return true
		end
		-- Not inside
		return false
	end
	-- Not inside
	return false
end


---------------------------------------------------------------
-- Closes the window.
-- Plays the close animation and handles closing events.
function Window:close()
	self.is_open = false
end


---------------------------------------------------------------
-- Closes the window.
-- Plays the close animation and handles closing events.
function Window:close()
	self.is_open = true
end

return Window
