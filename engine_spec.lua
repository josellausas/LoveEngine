------------------------------------
-- Specification for Love Engine.
-- Unit tests for Engine features
-- @author jose@josellausas.com
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

		local rect = Engine:create("rect", {
			label="object02",
			posX=100, posY=100,
			width=20, height=10
		})

		-- Should equal the number of created things
		local allObjects = Engine:getAllObjects()
		assert.is_equal(#allObjects, 2)

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

	it('should create TexturedObjects with the same options', function()

	end)
end)
