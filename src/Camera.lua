----------------------
-- Camera Object.
-- Controls what the user can see. Movement on the LevelMap
local class = require 'middleclass'

local Camera = class('Camera')


------------------------------------------
-- Creates a new Camera.
-- Can send the following options:
-- - x, y: X and Y coords
-- - scaleX, scaleY: Scale factors
-- - rotation: the rotation in radians
-- @params opts options table.
function Camera:initialize()
	self.x = 0
	self.y = 0
	self.scaleX = 4
	self.scaleY = 4
	self.rotation = 0
	self.speed = 800
end


---------------------------------------------
-- Sets the camera into the stack.
function Camera:set()
	love.graphics.push()
	love.graphics.rotate(-self.rotation)
	love.graphics.scale(1 / self.scaleX, 1 / self.scaleY)
	love.graphics.translate(-self.x, -self.y)
end


------------------------------------------------------
-- Removes the Camera from the stack.
function Camera:unset()
	love.graphics.pop()
end


---------------------------------------------
-- Moves the camera dx, dy amounts.
function Camera:move(dx, dy)
	self.x = self.x + dx
	self.y = self.y + dy
end


---------------------------------------------
-- Rotates the camera.
function Camera:rotate(dr)
	self.rotation = self.rotation + dr
end


---------------------------------------------
-- Changes the scale.
function Camera:scale(sx, sy)
	sx = sx or 1
	self.scaleX = self.scaleX + sx
	self.scaleY = self.scaleY + sy
end


---------------------------------------------
-- Sets the camera position.
function Camera:setPosition(x,y)
	self.x = x or self.x
	self.y = y or self.y
end


------------------------------------
-- Sets the camera scale.
function Camera:setScale(sx, sy)
	self.scaleX = sx or self.scaleX
	self.scaleY = sy or self.scaleY
end


---------------------------------------------------------------
-- Returns the mouse position relative to the camera.
function Camera:mousePosition(x,y)
	return x * self.scaleX + self.x , y * self.scaleY + self.y
end


----------
-- Determines how much it should move according to input
local function getMovementAmountFromInput(dt, speed, left, right, up, down)
	local moveAmount = dt * speed
	local deltaX = 0
	local deltaY = 0
	if left then
		deltaX = -moveAmount
	elseif right then
		deltaX = moveAmount
	end
	if up then
		deltaY = -moveAmount
	elseif down then
		deltaY = moveAmount
	end
	return deltaX, deltaY
end


---------
-- Updates the camera with input.
function Camera:update(dt, input)
	local dx, dy = getMovementAmountFromInput( dt, self.speed,
		input.left,
		input.right,
		input.up,
		input.down
	)

	self:move(dx, dy)
end

return Camera
