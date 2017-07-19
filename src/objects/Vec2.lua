local class = require 'middleclass'

local Vec2 = class('Vec2')


------------------------------------------------
-- Creates a new Vector.
-- Returns a new 2D vector.
-- @param x The x component. Defaults to 0.
-- @param y the y component. Defaults to 0.
function Vec2:initialize(x,y)
	self.x = x or 0
	self.y = y or 0
end


------------------------------------------------------------
-- Returns the magnitude squared.
-- @return Magnitude * Magnitude.
function Vec2:magnitudeSqr()
	return (self.x * self.x) + (self.y * self.y)
end


--------------------------------------------------
-- Returns the magnitude.
-- Returns the length of the vector.
function Vec2:magnitude()
	-- |a| = sqrt((ax * ax) + (ay * ay) + (az * az))
	return math.sqrt(self:magnitudeSqr())
end


------------------------------------------
-- Returns a normalized unit vector.
-- The vector normalized.
function Vec2:normalize()
	local magnitude = self:magnitude()
	-- Do not divide by 0!!!
	if (magnitude == 0) then
		return 0,0
	end
	return self.x / magnitude, self.y / magnitude
end


return Vec2
