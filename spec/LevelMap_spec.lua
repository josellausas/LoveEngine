describe('LevelMap', function()

	local LevelMap = require 'src.objects.LevelMap'

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
end)
