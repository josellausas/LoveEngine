------------------------------------
-- Specification for Love Engine.
-- Unit tests for Engine features
-- @author jose@josellausas.com

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
	local Engine = require('src.Engine')

	it('should create objects and keep track', function()

		-- Initialize the damn thing
		Engine:init()

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

		-- This should clear the list of objects
		Engine:shutdown()
		local allObjects = Engine:getAllObjects()
		assert.is_equal(#allObjects, 0)
	end)

	it('should create render objects with different options', function()
		Engine:init()
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
			label="object02",
			x=100, y=101,
			radius=20,
			color='#3c3c3c',
			border=4
		})
		assert.is_equal(circle02.x, 100)
		assert.is_equal(circle02.y, 101)
		assert.is_equal(circle02.radius, 20)
		assert.is_equal(circle02.label, "object02")
		assert.is_equal(circle02.is_debug, false)
		Engine:shutdown()
	end)

	it('should create different types of objects', function()
		Engine:init()
		local circle02 = Engine:create("obj", {
			label="object02",
			x=100, y=101,
			radius=20,
			color='#3c3c3c',
			border=4
		})

		local movingThing = Engine:create("mov", {
			x = 0,
			y = 0,
			speed = 20,
			heading = 1,
			image = mock_image(300,200)
		})
		movingThing:update(12)
		assert.is_equal(movingThing.lifetime, 12)
		assert.is_not_equal(movingThing.x, 0)

		Engine:shutdown()
	end)
end)
