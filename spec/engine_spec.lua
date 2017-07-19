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
		Engine:shutdown()
	end)

	--[[
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

		-- Assert the list sizes
		assert.is_equal(#Engine.static_objects, 1)
		assert.is_equal(#Engine.moving_objects, 1)
		assert.is_equal(#Engine.all_objects, 2)

		Engine:shutdown()
	end)
	]]

	describe('LevelMap', function()
		it('shold create a grid', function()
			local map = LevelMap:new(10,20, 200, {})
			assert.is_equal(map.width, 10 * 200)
			assert.is_equal(map.height, 20 * 200)
		end)

		it('should find coords for points', function()
			local map = LevelMap:new(10,20, 200, {})
			assert.is_equal(map.width, 10 * 200)
			assert.is_equal(map.height, 20 * 200)

			local point00 = {x=0, y=0}
			local point01 = {x=-1, y=1}
			local point02 = {x=300, y=300}
			local point03 = {x=10*200, y=20*200}

			x00, y00 = map:getTileXY(point00.x, point00.y)
			assert.is_equal(0, x00)
			assert.is_equal(0, y00)

			x01, y01 = map:getTileXY(point01.x, point01.y)
			assert.is_equal(nil, x01)
			assert.is_equal(nil, y01)

			x02, y02 = map:getTileXY(point02.x, point02.y)
			assert.is_equal(1, x02)
			assert.is_equal(1, y02)

			x03, y03 = map:getTileXY(point03.x, point03.y)
			assert.is_equal(10, x03)
			assert.is_equal(20, y03)
		end)

		it('should find coords for points with offsets', function()
			xOffset = 1000
			yOffset = 1000

			local map = LevelMap:new(10,20, 200, {x_offset=xOffset, y_offset=yOffset})
			assert.is_equal(map.width, 10 * 200)
			assert.is_equal(map.height, 20 * 200)

			local point00 = {x=0 + xOffset, y=0 + yOffset}
			local point01 = {x=-1 + xOffset, y=1 + yOffset}
			local point02 = {x=300 + xOffset, y=300 + yOffset}
			local point03 = {x=10*200 + xOffset, y=20*200 + yOffset}

			x00, y00 = map:getTileXY(point00.x, point00.y)
			assert.is_equal(0, x00)
			assert.is_equal(0, y00)

			x01, y01 = map:getTileXY(point01.x, point01.y)
			assert.is_equal(nil, x01)
			assert.is_equal(nil, y01)

			x02, y02 = map:getTileXY(point02.x, point02.y)
			assert.is_equal(1, x02)
			assert.is_equal(1, y02)

			x03, y03 = map:getTileXY(point03.x, point03.y)
			assert.is_equal(10, x03)
			assert.is_equal(20, y03)
		end)

		it('should find coords for points with negative offsets', function()
			xOffset = -200
			yOffset = -200

			local map = LevelMap:new(10,20, 200, {x_offset=xOffset, y_offset=yOffset})
			assert.is_equal(map.width, 10 * 200)
			assert.is_equal(map.height, 20 * 200)

			local point00 = {x=0 + xOffset, y=0 + yOffset}
			local point01 = {x=-1 + xOffset, y=1 + yOffset}
			local point02 = {x=300 + xOffset, y=300 + yOffset}
			local point03 = {x=10*200 + xOffset, y=20*200 + yOffset}

			x00, y00 = map:getTileXY(point00.x, point00.y)
			assert.is_equal(0, x00)
			assert.is_equal(0, y00)

			x01, y01 = map:getTileXY(point01.x, point01.y)
			assert.is_equal(nil, x01)
			assert.is_equal(nil, y01)

			x02, y02 = map:getTileXY(point02.x, point02.y)
			assert.is_equal(1, x02)
			assert.is_equal(1, y02)

			x03, y03 = map:getTileXY(point03.x, point03.y)
			assert.is_equal(10, x03)
			assert.is_equal(20, y03)
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
end)
