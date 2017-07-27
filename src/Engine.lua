---------------------------------------------------------
-- Game engine.
-- Game Engine
-- ===========
-- This is the main API for interacting with the game.
-- The engine is the one in charge of creating and managing objects in the game.
-- Renders the things in the right order.
local RenderObject = require('src.objects.RenderObject')
local KinematicObject = require('src.objects.KinematicObject')
local LevelMap = require('src.objects.LevelMap')
local Camera = require('src.Camera')
local Input = require('src.InputManager')
local Colors = require('src.Colors')
local Group = require('src.objects.Group')
local TextWindow = require('src.objects.TextWindow')
local ColMan = require 'src.CollisionManager'
local ll = require('src.Analytics')

local Engine = {
	--- The map grid for the game
	level_map = nil,
	--- The game's camera. The "player's eye"
	camera = nil,
	--- Keeps track of all the objects for the game
	all_objects = {}, -- These are strong links
	--- These do not move. Do not call :update() on them
	static_objects = {}, -- Weak links
	--- Kinematic Objects. These move and have an update(dt) function
	moving_objects = {}, -- Weak links
	--- UI Objects. Draws on top of everything and is not relative to the camera
	ui_objects = {},
	--- How long has the game been running. A dt timebucket
	elapsed_time = 0,
	--- Some user preferences.
	config = {
		upKey = 'up',
		downKey = 'down',
		leftKey = 'left',
		rightKey = 'right',
		createWindowKey = 'w',
	},
	--- Calback event handle for mouse event. Must be released
	on_mouse_released = nil,
	--- Callback event handle. Must be released
	on_shift_pressed = nil,
	--- Callback event handle. Must be relased
	on_shift_released = nil,
	--- Callback for creating window
	on_create_window = nil,
	--- The game's state
	game_state = nil,
	--- A debug TextWindow
	debug_window = nil,

}



-------------------------------------------------------------------------------
-- Callback for click event.
-- Reacts to the user releasing the mouse button.
-- @function handleClick.
-- @param button The mouse button released.
-- @param x The x screen coordinate (not game coordinate)
-- @param y The y screen coordinate (not game coordinate)
local handleClick = function(button, x, y)
	-- Take into account the camera to get the correct coordinates
	local gameX, gameY = Engine.camera:mousePosition(x,y)

	if Engine.game_state.is_shift_down then
		local  e = Engine:create('obj', {x=gameX, y=gameY, color='#cccccc'})
		table.insert(Engine.game_state.created_while_shift, e)
	else
		Engine:create('obj', {x=gameX, y=gameY})
	end
end


-------------------------------------------------------------------------------
-- Callback for shift pressed event.
-- Creates a new table for storing
local shift_was_pressed = function()
	Engine.game_state.created_while_shift = {}
	Engine.game_state.is_shift_down = true
end


-------------------------------------------------------------------------------
-- Callback for shift released event.
-- Creates a new group of objects from the objects that where created
--  while holding shift.
local shift_was_released = function()
	Engine.game_state.is_shift_down = false

	-- Create a group with that
	local g = Group:new(Engine.game_state.created_while_shift, {})
	g.x, g.y = g:getAveragePosition()
	g.label = 'avg=('..g.x..','..g.y..')'
	g.color = '#ff0000'

	table.insert(Engine.all_objects, g)

	Engine.game_state.created_while_shift = nil
end


-------------------------------------------------------------------------------
-- Callback for the window being created.
local on_create_window = function()
	if not Engine.debug_window then
		Engine.debug_window = Engine:create('window', {
			window_title = "Object List",
			x=20, y=20,
			width=200, height=400,
			text_list = {
			},
		})
	end

	if Engine.game_state.is_debug_window_shown == true then
		Engine.debug_window:hide()
		Engine.game_state.is_debug_window_shown =
		not Engine.game_state.is_debug_window_shown
	else
		Engine.debug_window:show()
		Engine.game_state.is_debug_window_shown =
		not Engine.game_state.is_debug_window_shown
	end
end


-------------------------------------------------------------------------------
-- Clears all internals.
-- Clears and resets all members.
function Engine:reset()
	self.all_objects = {}
	self.static_objects = {}
	self.moving_objects = {}
	self.ui_objects = {}
	self.elapsed_time = 0
	self.level_map = LevelMap:new(
		10, 10,
		100,
		{ background_color='#2A7E43', line_color='#AA4839' }
	)
	self.camera = Camera:new({scale=1})
	if self.on_mouse_released then
		Input.on_mouse_released:removeAction(self.on_mouse_released)
		self.on_mouse_released = nil
	end
	self.on_mouse_released = Input.on_mouse_released:addAction(handleClick)
	self.on_shift_pressed = Input.on_shift_pressed:addAction(shift_was_pressed)
	self.on_shift_releasedft = Input.on_shift_released:addAction(shift_was_released)
	self.on_create_window = Input.on_w_released:addAction(on_create_window)
	self.game_state = {
		is_shift_down = false,
		created_while_shift = {},
		is_debug_window_shown = false,
	}
end


-------------------------------------------------------------------------------
-- Initialize the Engine
-- Run this before anything else.
-- Dont forget to shut down!
function Engine:init()
	self:reset()
	ColMan:init()
	ll:event('Engine', 'init')
end


-------------------------------------------------------------------------------
-- Update the Engine.
-- Gets called every frame
-- @param dt Delta Time. Time since last frame was shown
function Engine:update(dt)
	-- Time buckets
	self.elapsed_time = self.elapsed_time + dt

	-- Update the camera
	self.camera:update(dt, {
		left = Input:isKeyDown(self.config.leftKey),
		right = Input:isKeyDown(self.config.rightKey),
		up = Input:isKeyDown(self.config.upKey),
		down = Input:isKeyDown(self.config.downKey),
	})

	-- TODO: Update the objects here
end


-------------------------------------------------------------------------------
-- Renders all the things.
-- All the things get rendered
function Engine:draw()
	self.camera:set()
		-- This is relative to the camera
		-- First the floor
		self.level_map:draw()
		for _, drawable in ipairs(self.all_objects) do
			drawable:draw()
		end
	self.camera:unset()
	-- Draw GUI here
	for _, drawable in ipairs(self.ui_objects) do
		drawable:draw()
	end
end


-------------------------------------------------------------------------------
-- Registers an object for being displayed in the debug window.
-- @param obj The object to be monitored.
function Engine:register_for_debug(obj)
	if not self.debug_window then
		self.debug_window = self:create('window', {
			window_title = "Object List",
			x=20, y=20,
			width=200, height=400,
			text_list = {
			},
		})
	end
	self.debug_window:add_text(obj.id, obj)
end


-------------------------------------------------------------------------------
-- Creates a new Game object.
-- Creates a new object of the given type, using
-- the given options. The engine keeps track of all
-- created objects and renders them in the right order.
function Engine:create(obj_type, opts)
	local created_obj = nil

	-- Create a normal type of object

	if obj_type == "obj" then
		created_obj = RenderObject:new(opts)
		table.insert(self.all_objects, created_obj)
		table.insert(self.static_objects, created_obj)
		created_obj.id = 'obj'..#self.all_objects
		self:register_for_debug(created_obj)


	-- Create a moving type of object
	elseif obj_type == "mov" then
		created_obj = KinematicObject:new(opts)
		table.insert(self.all_objects, created_obj)
		table.insert(self.moving_objects, created_obj)
		created_obj.id = 'obj'..#self.all_objects
		self:register_for_debug(created_obj)

	elseif obj_type == "window" then
		created_obj = TextWindow:new(opts.width, opts.height, opts)
		table.insert(self.ui_objects, created_obj)
		created_obj.id = 'ui'..#self.ui_objects
		-- Register for UI collision
		ColMan:register_ui(created_obj)
	end

	-- Give it an ID
	created_obj.label = created_obj.id
	ll:log('Created: "' .. created_obj.label .. '"')
	return created_obj
end


-------------------------------------------------------------------------------
-- Creates a Group of from a table of options.
-- Creates a Group of Kinematic objects from a table of options.
-- @param groupList *{}* A table of tables with named options.
-- @treturn Group A new group with the created Kinematic Objects inside.
function Engine:createGroupWithOptions(groupList)
	local created_list = {}
	for k,option in ipairs(groupList) do
		local newThing = KinematicObject:new(option)
		table.insert(created_list, newThing)
	end
	return Group:new(created_list, {})
end


-------------------------------------------------------------------------------
-- Returns a table of all the objects
-- @treturn {RenderObject,...} A list of all RenderObjects
--  created with the Engine
function Engine:getAllObjects()
	return self.all_objects
end


-------------------------------------------------------------------------------
-- Executes a string as a create() command.
-- Unpacks and loads the string as a table. The
-- table should follow this format:
-- @usage
-- Engine:exec_command("'create', {'obj', {x=0,y=0} }")
function Engine:exec_command(message_command)
	-- Convert the stirng to a Lua table
	local command_function = assert(loadstring(message_command))
	local command_table = command_function()
	local command_type, command = unpack(command_table)

	if command_type == 'create' then
		local obj_type, opts = unpack(command)
		local created_obj = self:create(obj_type, opts)
	else
		-- Unkown command
		ll:log("Unkwon command: " .. message_command)
	end
end


-------------------------------------------------------------------------------
-- Release memory.
-- Releases all the objects and memory
function Engine:shutdown()
	ColMan:shutdown()
	-- Check for action and release
	if self.on_mouse_released then
		Input.on_mouse_released:removeAction(self.on_mouse_released)
		self.on_mouse_released = nil
	end

	-- Check for action and release
	if self.on_shift_up then
		Input.on_shift_pressed:removeAction(self.on_shift_down)
		self.on_shift_down = nil
	end

	-- Check for action and release
	if self.on_shift_up then
		Input.on_shift_released:removeAction(self.on_shift_up)
		self.on_shift_up = nil
	end

	-- Release create window callback
	if self.on_create_window then
		Input.on_w_released:removeAction(self.on_create_window)
		self.on_create_window = nil
	end

	-- Loop all objects and dispose
	self.moving_objects = nil
	self.static_objects = nil
	for _,obj in ipairs(self.all_objects) do
		obj = nil
	end

	-- Setup with freshest things
	self:reset()

	ll:event('Engine', 'shutdown')
end


return Engine
