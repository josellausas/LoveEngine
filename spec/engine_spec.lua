------------------------------------
-- Specification for Love Engine.
-- Unit tests for Engine features
-- @author jose@josellausas.com

local Engine 	= require('src.Engine')
local LevelMap 	= require('src.objects.LevelMap')


---------------------------------------
-- Creates a mock image for testing.
-- @treturn Image An image
local function mock_image(width, height)
	local image = {
		width = width,
		height = height,
	}

	function image:getDimensions()
		return self.width, self.height
	end

	return image
end


describe('Engine', function()

	before_each(function()
		Engine:init()
	end)

	after_each(function()
		Engine:shutdown()
	end)

	it('should create objects and keep track', function()
		local circle = Engine:create("obj", {
			label="object01",
			posX=0, posY=0,
			radius=20,
			color='#3c3c3c',
			border=4
		})

		-- Should equal the number of created things
		local allObjects = Engine:getAllObjects()
		assert.is_equal(#allObjects, 1)
	end)

	it('should create render objects with different options', function()

		local circle = Engine:create("obj", {
			label="object01",
			x=100, y=101,
			radius=20,
			color='#3c3c3c',
			border=4
		})
		assert.is_equal(circle.x, 100)
		assert.is_equal(circle.y, 101)
		assert.is_equal(circle.radius, 20)

		local circle02 = Engine:create("obj", {
			x=100, y=101,
			radius=20,
			color='#3c3c3c',
			border=4
		})
		circle02.label = "object02"
		assert.is_equal(circle02.x, 100)
		assert.is_equal(circle02.y, 101)
		assert.is_equal(circle02.radius, 20)
		assert.is_equal(circle02.label, "object02")
		assert.is_equal(circle02.is_debug, false)

	end)

	it('should create a Window', function()
		local old_count = #Engine.ui_objects
		local w = Engine:create('window', {width=300, height=300, x=100, y=100})
		assert.is_not_nil(w)
		assert.is_equal(old_count + 1, #Engine.ui_objects)
	end)

	it('should create a group', function()
		local option_list = {
			{x = 0,y = 0,speed = 20,heading = 1,},
			{x = 0,y = 0,speed = 20,heading = 1,},
			{x = 0,y = 0,speed = 20,heading = 1,},
		}
		local g = Engine:createGroupWithOptions(option_list)
		assert.is_not_nil(g)
		assert.is_equal(3, g:count())
	end)
end)
