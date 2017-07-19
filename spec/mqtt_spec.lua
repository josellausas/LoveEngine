describe('MQTT Client', function()
	local mqtt = require 'mqtt'

	before_each(function()

		mqtt:init("192.168.1.117", "game", 0, nil)

	end)


	after_each(function()

		mqtt:shutdown()

	end)

	it('should publish to a channel', function()
		-- Publish a message
		mqtt:publish("Testing Game's MQTTT publish")
	end)

	it('should subscribe to a channel', function()

		pending("subscribe to a channel")

	end)


	it('should register a last will', function()

		pending("register a last will")

	end)

end)
