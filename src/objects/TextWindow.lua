-----------------------------------
-- UI Text Window.
-- TextWindow
-- ==========
-- A Window that can draw text.

local class = require 'middleclass'
local Window = require 'src.objects.Window'
local color = require 'colorise'
local Input = require 'src.InputManager'
local ll = require 'src.Analytics'

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
	self.window_title = opts.window_title or 'TextWindow'
	self.on_mouse_release_action = Input.on_mouse_released_ui:addAction(function(button, x, y)
		-- React to mouse collision!
		ll:log("Clicked on: " .. self.window_title)
	end)

	-- TODO: Add margins
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


----------------------------------------------------------------
-- The number of texts in the text_list.
-- Returns the number of texts inside the text_list
-- @return The number of texts
function TextWindow:text_count()
	return #self.text_list
end


----------------------------------------------------------------
-- Draws itself.
-- Draws the base window, then loops the `text_list` and draws
-- text that fits inside the window.
function TextWindow:draw()
	-- Call parent's behavior
	Window.draw(self)

	-- Do not draw anything if we are closed
	if not self.is_open then return end

	-- Set our color
	love.graphics.setColor(color.hex2rgb(self.font_color))

	-- Draw title
	love.graphics.printf(self.window_title, self.x, self.y, self.width, "center")

	-- Loop the text_list and draw
	for index, text in ipairs(self.text_list) do
		-- Determine where the text will go
		local xCoord = self.x
		local yCoord = self.y + (index) * self.new_line_height

		-- Only draw within our height
		if yCoord < (self.y + self.height) then
			love.graphics.printf(text, xCoord, yCoord, self.width, self.align)
		end
	end
end

function TextWindow:release()
	Input.on_mouse_released_ui:removeAction(self.on_mouse_release_action)
	Window.release(self)
end


return TextWindow
