---------------------------------------------
-- Main Interface.
-- This is the main API for interacting with the game.
-- The engine is the one in charge of creating and managing objects in the game.
-- Renders the things in the right order.
local RenderObject = require('src.objects.RenderObject')
local KinematicObject = require('src.objects.KinematicObject')
local Engine = {
	--- Stores all objects created
	all_objects = {}, -- These are strong links
	static_objects = {}, -- Weak links
	moving_objects = {}, -- Weak links
	elapsed_time = 0
}

----------------------------
-- Clears all internals.
-- Clears and resets all members.
function Engine:reset()
	self.all_objects = {}
	self.static_objects = {}
	self.moving_objects = {}
	self.elapsed_time = 0
end


-------------------------------------
-- Initialize the Engine
-- Run this before anything else.
-- Dont forget to shut down!
function Engine:init()
	Engine:reset()
end


-------------------------------------
-- Update the Engine.
-- Gets called every frame
-- @param dt Delta Time. Time since last frame was shown
function Engine:update(dt)
	-- Time buckets
	self.elapsed_time = self.elapsed_time + dt
end


-------------------------------------
-- Renders all the things.
-- All the things get rendered
function Engine:draw()
	for _, drawable in ipairs(self.all_objects) do
		drawable:draw()
	end
end


---------------------------------------------
-- Creates a new Game object.
-- Creates a new object of the given type, using
-- the given options. The engine keeps track of all
-- created objects and renders them in the right order.
function Engine:create(obj_type, opts)
	local created_obj = nil
	if obj_type == "obj" then
		created_obj = RenderObject:new(opts)
		table.insert(self.all_objects, created_obj)
		table.insert(self.static_objects, created_obj)
	elseif obj_type == "mov" then
		created_obj = KinematicObject:new(opts)
		table.insert(self.all_objects, created_obj)
		table.insert(self.moving_objects, created_obj)
	end
	return created_obj
end


-----------------------------------------
-- Returns a table of all the objects
-- @treturn {RenderObject,...} A list of all RenderObjects created with the Engine
function Engine:getAllObjects()
	return self.all_objects
end


---------------------------------------
-- Release memory.
-- Releases all the objects and memory
function Engine:shutdown()
	-- Loop all objects and dispose
	self.moving_objects = nil
	self.static_objects = nil
	for _,obj in ipairs(self.all_objects) do
		obj = nil
	end
	Engine:reset()
end

return Engine
