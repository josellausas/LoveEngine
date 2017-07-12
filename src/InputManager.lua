----------------------------------------------
-- Input Manager.
-- Handles all input events and keeps a log

local InputManager = {
	log = nil
}


------------------------------
-- Initialize the manager.
-- Clears the log and clears everything
function InputManager:init()
	-- Restart the log
	self.log = {}
end


------------------------------
-- Handles a key pressed.
-- Invoke this when a keyPressed event has happened
-- @param key The key that was pressed
function InputManager:handleKeyPressed(key)
	print('Pressed: ' .. key)
end


------------------------------
-- Handle a key release
-- Invoke this when a key is Released
-- @param key The key that was released
function InputManager:handleKeyReleased(key)
	print('Relesed: ' .. key)
end


--------------------------------
-- Mouse Pressed.
-- On Mouse pressed event handler
-- @param button The button pressed
-- @param x The X coordinate on screen
-- @param y The Y coordinate on screen
function InputManager:handleMousePressed(button, x, y)

end


--------------------------------
-- Mouse Released.
-- On Mouse released event handler
-- @param button The button released
-- @param x The X coordinate on screen
-- @param y The Y coordinate on screen
function InputManager:handleMouseReleased(button, x, y)

end

function InputManager:isKeyDown(key)
	return love.keyboard.isDown(key)
end

------------------------------
-- Clean up.
-- Disposes and releases memory
function InputManager:shutdown()
	self.log = nil
end


return InputManager
