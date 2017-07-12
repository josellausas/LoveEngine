----------------------------------------------
-- Input Manager.
-- Handles all input events and keeps a log
local Events = require('src.Events')
local InputManager = {
	log = nil,
	on_mouse_released = nil,
	on_mouse_pressed = nil,
	on_key_pressed = nil,
	on_key_released = nil,
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
	self.on_key_pressed = Events.newEvent()
	self.on_key_released = Events.newEvent()
end


------------------------------
-- Handles a key pressed.
-- Invoke this when a keyPressed event has happened
-- @param key The key that was pressed
function InputManager:handleKeyPressed(key)
	self.on_key_pressed:trigger(key)
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
	self.on_key_released:trigger(key)
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
	self.on_mouse_released:trigger(button, x, y)
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
	self.on_key_pressed = nil
	self.on_key_released = nil
end


return InputManager
