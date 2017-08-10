----------------------------------------
-- Stateful Object.
-- A State machine that can move around the game.
local class = require 'middleclass'
local States = require 'src.States'
local KinematicObject = require 'src.objects.KinematicObject'

local StatefulObject = class('StatefulObject', KinematicObject)

----------------------------------------
-- Creates a new Stateful Object.
function StatefulObject:initialize(opts)
	KinematicObject.initialize(self, opts)
	current_state = States.STATE
end

----------------------------------------
-- Update.
function StatefulObject:update(dt)
	KinematicObject.update(self, dt)
	current_state.update(self, dt)
end

----------------------------------------
-- Draw
function StatefulObject:draw()
	KinematicObject.draw(self)
end

----------------------------------------
-- Change State.
function StatefulObject:change_state(state)
	current_state.on_exit(self)
	current_state = state
	current_state.on_enter(self)
end


return StatefulObject
