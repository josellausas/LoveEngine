------------------------------------------
-- Group Object.
-- Group mentality for objects.
local class = require 'middleclass'
local KinematicObject = require 'src.objects.KinematicObject'

local Group = class('Group', Kinematic)


------------------------------------------------------------
-- Creates a new RenderGroup
function Group:initialize(objects, opts)
	KinematicObject.initialize(self, opts)
	self.members = {}
	-- Copy objects to the table
	for k, obj in pairs(objects) do
		table.insert(self.members, obj)
	end
end


------------------------------------------------------------
-- Adds a member.
-- Adds a member to the group. It must be a KinematicObject
function Group:add(obj)
	table.insert(self.members, obj)
end


------------------------------------------------------------
-- Update.
-- Calls its parent for kinematic movement, then does something else
function Group:update(dt)
	KinematicObject.update(self, dt)
end


---------------------------------------------------
-- Draw.
-- Draws itself and no one else.
function Group:draw()
	KinematicObject.draw(self)
	-- TODO: Draw a mark on average position
end


------------------------------------
-- Returns the number of members
-- @return The number of members
function Group:count()
	return #self.members
end


----------------------------------------------------
-- Gets the average position for all the members
-- Calculates the math average of all positions for all members.
-- @return avgX, avgY. The average coordinates.
function Group:getAveragePosition()
	local averageX = 0
	local averageY = 0

	for _,member in pairs(self.members) do
		averageX = averageX + member.x
		averageY = averageY + member.y
	end

	averageX = averageX / #self.members
	averageY = averageY / #self.members

	return averageX, averageY
end


return Group
