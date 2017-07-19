describe('Vec2', function()
	local vec2 = require 'src.objects.Vec2'

	it('should create a new vector without parameters', function()
		v = vec2()
		assert.is_equal(0, v.x)
		assert.is_equal(0, v.y)
	end)

	it('should create a new vector with parameters', function()
		v = vec2(2,3)
		assert.is_equal(2, v.x)
		assert.is_equal(3, v.y)
	end)

	it('should get the length of a vector', function()
		v = vec2(10,10)
		h = v:magnitude()
		assert.is_equal(h, 14.142135623730951011)
	end)

	it('should get the normalized vector', function()
		v = vec2(10,10)
		nx, ny = v:normalize()
		assert.is_equal(nx, 0.70710678118654746172)
		assert.is_equal(ny, 0.70710678118654746172)
	end)
end)
