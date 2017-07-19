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
	self.object_list = opts.object_list or {}
	self.align = opts.alig or "left"
	self.new_line_height = opts.line_height or 20
	self.font_color = opts.font_color or "#FFFFFF"
	self.selected_color = opts.selected_color or "#FF3333"
	self.window_title = opts.window_title or 'TextWindow'
	self.selected_index = nil
	self.on_mouse_release_action = Input.on_mouse_released_ui:addAction(function(button, x, y)
		-- React to mouse collision!
		local text_index = self:get_text_index_for_point(x,y)

		if text_index then
			if text_index == 0 then
				self.selected_index = nil
				ll:log("Clicked on: " .. self.window_title)
			else
				self.selected_index = text_index
				ll:log("Clicked on text #" .. text_index)
			end
		else
			self.selected_index = nil
			ll:log("Clicked on TextWindow")
		end
	end)

	-- TODO: Add margins
end

----------------------------------------------
-- Gets the text_list index for the given point
-- Determines which text from the list was clicked.
-- @param x The x coord.
-- @param y The y coord.
-- @return The text_list index or nil. Returns 0 if title was clicked
function TextWindow:get_text_index_for_point(x,y)
	-- The Tilte was clicked
	if y > self.y and y < (self.y + self.new_line_height) then
		return 0
	end

	for index,text in ipairs(self.text_list) do
		local minY = self.y + (index * self.new_line_height)
		local maxY = minY + self.new_line_height

		if y > minY and y < maxY then
			return index
		end
	end

	return nil
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
function TextWindow:add_text(text, object)
	if not text then return nil end
	if not object then object = {} end
	table.insert(self.text_list, text)
	table.insert(self.object_list, object)
end


----------------------------------------------------------------
-- The number of texts in the text_list.
-- Returns the number of texts inside the text_list
-- @return The number of texts
function TextWindow:text_count()
	return #self.text_list
end


function TextWindow:get_selected()
	-- If nothing is selected, then return nil
	if not self.selected_index then return nil end
	-- Return the object @ selected_index
	return self.object_list[self.selected_index]
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

		-- Draw a different color for selected text
		if index == self.selected_index then
			love.graphics.setColor(color.hex2rgb(self.selected_color))
		else
			love.graphics.setColor(color.hex2rgb(self.font_color))
		end

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
