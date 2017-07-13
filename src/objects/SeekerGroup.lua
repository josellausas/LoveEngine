------------------------------------------------------
-- A group of objects that seeks a target.
local class = require 'middleclass'
local Group = require 'src.objects.Group'

local SeekerGroup = class('SeekerGroup', Group)


--------------------------------------------------------
-- A group that seeks out a target.
-- A coordinated group that steers torwards the target
function SeekerGroup:initialize(target, opts)
	Group.initialize(self, {}, opts)
	self.target = target
end


---------------------------------------------------------------------------
-- Update the group intelligence.
-- Seeks to make the distance from itself to the target smaller each step.
-- @param dt Delta Time.
function SeekerGroup:update(dt)
	Group.update(self, dt)
	-- Our goal is to minimize this distance
	local dist_to_target_sq = self:distSqToPosition(self.target.x, self.target.y)
	local avg_dist_to_target_sq = self:distSqToPosition(self:getAveragePosition())
end


---------------------------------------------------------------------------
-- Draws itself.
-- Draws the group debug info, target, etc.
function SeekerGroup:draw()
	Group.draw(self)

	-- TODO: Draw a mark on the target
end
