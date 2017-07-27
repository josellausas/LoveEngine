--------------------
-- Group tests.
describe('Group', function()

	local Group = require 'src.objects.Group'
	local Kinematic = require 'src.objects.KinematicObject'

	it('should init with members', function()
		local list_of_objects = {
			Kinematic:new({x=10, y=10, speed=2, heading=1}),
			Kinematic:new({x=10, y=10, speed=2, heading=1}),
			Kinematic:new({x=10, y=10, speed=2, heading=1}),
		}
		local g = Group:new(list_of_objects)
		assert.is_equal(3, g:count())
	end)

	it('should add members', function()
		local g = Group:new({})
		assert.is_equal(0, g:count())
		-- Add a member
		g:add(Kinematic:new({x=10, y=10, speed=2, heading=1}))
		assert.is_equal(1, g:count())
		-- Add a member
		g:add(Kinematic:new({x=10, y=10, speed=2, heading=1}))
		assert.is_equal(2, g:count())

	end)

	it('should calcute the average position', function()
		local g = Group:new({})
		assert.is_equal(0, g:count())
		-- Add a member
		g:add(Kinematic:new({x=10, y=10, speed=2, heading=1}))
		-- Add a member
		g:add(Kinematic:new({x=-10, y=-10, speed=2, heading=1}))

		avg_x, avg_y = g:getAveragePosition()
		assert.is_equal(0, avg_x)
		assert.is_equal(0, avg_y)
	end)

end)
