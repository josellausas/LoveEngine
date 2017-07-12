----------------------------------------------
-- Input Manager.
-- Handles all input events and keeps a log
local InputManager = {
	log = nil
}
local RenderObject = require('src.objects.RenderObject')

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

function InputManager:handleMousePressed(button, x, y)
end

function InputManager:handleMouseReleased(button, x, y)
	Engine:create('obj', {
		x = x,
		y = y,
		label = 'object01'
	})
end

------------------------------
-- Clean up.
-- Disposes and releases memory
function InputManager:shutdown()
	self.log = nil
end

return InputManager
