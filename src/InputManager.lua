----------------------------------------------
-- Input Manager.
-- Handles all input events and keeps a log
local Events = require('src.Events')
local ColMan = require 'src.CollisionManager'

local InputManager = {
	log = nil,
	on_mouse_released = Events.newEvent(),
	on_mouse_pressed = Events.newEvent(),
	on_shift_pressed = Events.newEvent(),
	on_shift_released = Events.newEvent(),
	on_w_released = Events.newEvent(),
	on_mouse_released_ui = Events.newEvent(),
}


------------------------------
-- Initialize the manager.
-- Clears the log and clears everything
function InputManager:init()
	-- Restart the log
	self.log = {}
	-- These are event dispatchers. Call :trigger() to dispatch the event.
	self.on_mouse_released = Events.newEvent()
	self.on_mouse_pressed = Events.newEvent()
	self.on_shift_pressed = Events.newEvent()
	self.on_shift_released = Events.newEvent()
	self.on_w_released = Events.newEvent()
	self.on_mouse_released_ui = Events.newEvent()
end


------------------------------
-- Handles a key pressed.
-- Invoke this when a keyPressed event has happened
-- @param key The key that was pressed
function InputManager:handleKeyPressed(key)
	if key == 'lshift' or key=='rshift' then
		self.on_shift_pressed:trigger()
	end
end


------------------------------
-- Handle a key release
-- Invoke this when a key is Released
-- @param key The key that was released
function InputManager:handleKeyReleased(key)
	-- TODO: Remove this later
	if key == 'escape' then
		love.event.quit()
	end
	if key == 'lshift' or key=='rshift' then
		self.on_shift_released:trigger()
	end
	if key == 'w' then
		self.on_w_released:trigger()
	end
end


--------------------------------
-- Mouse Pressed.
-- On Mouse pressed event handler
-- @param button The button pressed
-- @param x The X coordinate on screen
-- @param y The Y coordinate on screen
function InputManager:handleMousePressed(button, x, y)
	self.on_mouse_pressed:trigger(button, x, y)
end


--------------------------------
-- Mouse Released.
-- On Mouse released event handler
-- @param button The button released
-- @param x The X coordinate on screen
-- @param y The Y coordinate on screen
function InputManager:handleMouseReleased(button, x, y)
	ui_collision_list = ColMan:get_ui_collisions(x,y)

	if #ui_collision_list > 0 then
		-- Trigger UI events for mouse
		self.on_mouse_released_ui:trigger(button, x,y)
	else
		-- Trigger game events for mouse
		self.on_mouse_released:trigger(button, x, y)
	end


end


-------------------------------------------------
-- Handles key down.
-- A key has been pressed
function InputManager:isKeyDown(key)
	return love.keyboard.isDown(key)
end


------------------------------
-- Clean up.
-- Disposes and releases memory
function InputManager:shutdown()
	self.log = nil
	-- All objects should de-register their actions
	--  from these events before this happens
	self.on_mouse_released = nil
	self.on_mouse_pressed = nil
	self.on_shift_pressed = nil
	self.on_shift_released = nil
end


return InputManager
