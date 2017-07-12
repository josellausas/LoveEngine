------------------------------------------------
-- Entry point for game.
-- This is the entry poing to the Love game
-- @author jose@josellausas.com
local Engine = require('src.Engine')
local InputManager = require('src.InputManager')


-------------------------------------------------------
-- The windows width
--
-- @return number The width in pixels
-------------------------------------------------------
local function getWidth()
	return love.graphics.getWidth()
end


-------------------------------------------------------
-- The window's height
--
-- @return number The height in pixels
-------------------------------------------------------
local function getHeight()
	return love.graphics.getHeight()
end


---------------------------
-- Load Game.
-- Loads and initializes the game
function love.load()
	InputManager:init()
	Engine:init()
end


------------------------
-- Update Game.
-- The game loop, updates all physics
-- @tparam float Time since last frame
function love.update(dt)
	Engine:update(dt)
end


----------------------
-- Draw Game.
-- Renders the scene after the update
function love.draw()
	Engine:draw()
end


function love.quit()
	-- Before quits runs this:
	Engine:shutdown()
	InputManager:shutdown()
end


----------------------------------------
-- Handles the focus event
-- @param f Indicates if we have focus
function love.focus(f)
	if not f then
		print("Lost focus")
	else
		print("Gained focus")
		print("Window dimensions = { " .. getWidth() .. " , " .. getHeight() .. " } ")
	end
end


----------------------------------------------------
-- Handles mouse presses.
--
-- @param x **(Number)** The x coordinate
-- @param y **(Number)** The y coordinate
-- @param button **(Button)** the button pressed
----------------------------------------------------
function love.mousepressed(x,y,button)
	InputManager:handleMousePressed(button, x, y)
end


---------------------------------------------------------
-- Mouse button has been released.
function love.mousereleased(x,y,button)
	InputManager:handleMouseReleased(button, x, y)
end


-------------------------
-- A key has been presed.
function love.keypressed(key)
	InputManager:handleKeyPressed(key)
end


----------------------------------------
-- Handles heyboard input
--
-- @param key The key that was pressed
----------------------------------------
function love.keyreleased(key)
	InputManager:handleKeyReleased(key)
end
