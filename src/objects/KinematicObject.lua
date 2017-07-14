---------------------------------------------------
-- A moving object.
-- An object that can move and knows how to update and draw itself.
-- Must call the update()  and draw() functions on this every frame.
local class = require 'middleclass'
local RenderObject = require('src.objects.RenderObject')
local TextureObject = require('src.objects.TextureObject')
local rotate90 = math.rad(90)

local KinematicObject = class('KinematicObject', TextureObject)


-------------------------------------------------
-- Creates a new Kinematic Object.
-- The options can be:
-- - speed
-- - heading
-- @param opts {} The options for the object
function KinematicObject:initialize(opts)
	opts = opts or {}
	-- Invoke parent's constructor
	TextureObject.initialize(self, opts)

	-- Setup a Kineti object
	self.speed = opts.speed or 0
	self.heading = opts.heading or 0
	self.lifetime = 0

end


--------------------------------
-- Set forward vector.
-- Set heading to a forward vector with X and Y components.
-- Converts a foward vector to radians. The vector mush be normalized!!!
function KinematicObject:setHeading(x,y)
	self.heading = math.atan2(y, x)
end


-------------------------------------------
-- Update.
-- Heartbeat
-- @param dt Delta Time. Time since last update
function KinematicObject:update(dt)
	-- Alive timer update
	self.lifetime = self.lifetime + dt

	-- Move forwards with our speed
	local fwdVector = {
		x = math.cos(self.heading),
		y = math.sin(self.heading)
	}

	-- YUM YUM YUM! Kinematics! Update our position in the world
	self.x = self.x + (fwdVector.x * self.speed * dt)
	self.y = self.y + (fwdVector.y * self.speed * dt)
end


-------------------------------------------
-- Draw.
-- Draws itself
function KinematicObject:draw()
	if self.image then
		love.graphics.draw(
			self.image,
			self.x, self.y,
			self.heading + rotate90,
			self.scale.x, self.scale.y,
			self.image_spec.offX, self.image_spec.offY
		)
	else
		RenderObject.draw(self)
	end
end


-------------------------------------------
-- Distance squared to position.
-- Returns the distance to a point squared.
-- @param x The x coord of the point.
-- @param y The y coord of the point.
-- @return The distance to the point squared.
function KinematicObject:distSqToPosition(x,y)
	-- Get a vector from us to the target (distVector)
	local distX = x - self.x
	local distY = y - self.y
	local squaredDistance = (distX * distX) + (distY * distY) -- Good 'ol Pythagoras
	return squaredDistance
end


------------------------------------------------
-- Check collision with circle.
-- Determines if this position is inside the circle.
-- Does not take into considetaion it's own radius.
-- @param circle The circle {x,y,radius}
-- @return True if inside, False if outside.
function KinematicObject:isInsideCircle(circle)
	local x,y = circle.x, circle.y
	local radius = circle.radius

	-- If a distance vector betweer our position and
	-- the circle is smaller than the radius, we are inside
	local distSq = self:distSqToPosition(x, y)
	local radiusSq = radius * radius
	return (distSq < radiusSq)
end

return KinematicObject
