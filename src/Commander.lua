-------------------------------------------------------------------------------
-- Commands Manager. Receives commands and executes them.
local MQTT = require("luamqttc/client")

local opts = {
	url = '192.168.1.117',
	channel = 'commands',
	client_id = 'LoveEngine',
	will_topic = 'live/love-engine',
	will_qos = 1,
	will_retain = true,
	will_message = '0'
}

local Commander = {
	mqtt_client = nil,
	error_message = nil,
}

local on_message_received = function(topic, data, packet_id, dup, qos, retained)
	print(data)
end

function Commander:init()
	self.mqtt_client = MQTT.new(opts.client_id)
	self.mqtt_client:connect(
		opts.url,
		1883,
		{timeout=1 }
	)
	-- Subscribe to the thing
	-- Publish that we are here
	self.mqtt_client:subscribe(opts.channel, 2, on_message_received)

	while (self.error_message == nil) do
  		self.mqtt_client:message_loop(1)
	end

	self:shutdown();
end

function Commander:shutdown()
	if (error_message == nil) then
 		mqtt_client:unsubscribe(args.topic)
  		mqtt_client:disconnect()
	else
  		print(error_message)
	end

	self.mqtt_client = nil
	self.error_message = nil
end

function Commander:execute(command)
	print (command)
end

return Commander
