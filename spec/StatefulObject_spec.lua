describe('StatefulObject', function()
	local Stateful = require 'src.objects.StatefulObject'
	local States = require 'src.States'

	it('Can change states', function()
		local obj = Stateful:new()
		assert.is_not_nil(obj)
		obj:change_state(States.SEEKER)
	end)
end)
