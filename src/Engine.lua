local RenderObject = require('src.RenderObject')
---------------------------------------------
-- Main Interface.
-- This is the main API for interacting with the game.
-- The engine is the one in charge of creating and managing objects in the game.
-- Renders the things in the right order.
local Engine = {
	--- Stores all objects created
	all_objects = {},
	elapsed_time = 0
}


-------------------------------------
-- Initialize the Engine
-- Run this before anything else.
-- Dont forget to shut down!
function Engine:init()
	self.all_objects = {}
	self.elapsed_time = 0
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
	local created_obj = RenderObject:new(opts)
	-- Keep track of the thing
	table.insert(self.all_objects, created_obj)
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
	for _,obj in ipairs(self.all_objects) do
		obj = nil
	end

	self.all_objects = {}
end

return Engine
