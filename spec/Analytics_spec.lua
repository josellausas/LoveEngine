describe('Analytics', function()
	local ll = require('src.Analytics')
	it('should log a message', function()
		ll:log("Hola testing")
	end)

	it('should keep count of Engine events', function()
		local old_count = ll.counts.engine_init
		ll:event("Engine","init")
		assert.is_equal(old_count + 1, ll.counts.engine_init)
	end)
end)
