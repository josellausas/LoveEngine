-----------------------------------
-- UI Text Window.
-- TextWindow
-- ==========
-- A Window that can draw text.

local class = require 'middleclass'
local Window = require 'src.objects.Window'
local color = require 'colorise'

local TextWindow = class('TextWindow', Window)



----------------------------------------------------------------
-- Creates a new TextWindow.
-- Creates a new text window of the given width.
-- A `text_list` can be passed in via the `opts` parameter
-- to populate the text to be displayed.
-- @return *TextWindow* A new `TextWindow` instance
function TextWindow:initialize(width, height, opts)
	if not opts then opts = {} end
	Window.initialize(self, width, height, opts)
	self.text_list = opts.text_list or {}
	self.align = opts.alig or "left"
	self.new_line_height = opts.line_height or 20
	self.font_color = opts.font_color or "#FFFFFF"
end


----------------------------------------------------------------
-- Resets the text.
-- Clears the text list.
function TextWindow:reset_text()
	self.text_list = {}
end


----------------------------------------------------------------
-- Add text.
-- Adds text to the Text window
function TextWindow:add_text(text)
	if not text then return nil end
	table.insert(self.text_list, text)
end



function TextWindow:text_count()
	return #self.text_list
end



function TextWindow:draw()
	Window.draw(self)

	love.graphics.setColor(color.hex2rgb(self.font_color))
	-- Loop the text and draw
	for index, text in ipairs(self.text_list) do
		-- Determine where the text will go
		local xCoord = self.x
		local yCoord = self.y + (index-1) * self.new_line_height

		-- Only draw within our height
		if yCoord < (self.y + self.height) then
			love.graphics.printf(text, xCoord, yCoord, self.width, self.align)
		end
	end


end


return TextWindow
