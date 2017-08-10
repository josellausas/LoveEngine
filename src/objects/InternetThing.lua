local class = require 'middleclass'
local KinematicObject = require 'src.objects.KinematicObject'

local Thing = class('Thing')

function Thing:initialize(ip, name, state, kinematic)
	self.state = state or {}
	self.name = name
	self.ip = ip
	self.avatar = kinematic or KinematicObject:new()
end

function Thing:update(dt)
	self.avatar:update(dt)
end

function Thing:draw()
	self.avatar:draw()
end


return Thing
