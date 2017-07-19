-------------------------------------------------------------------------------
-- MQTT Client.
-- A MQTT Client for publishing and receiving network messages.
local mqtt_client = {
	--- Topic to publish to.
	topic = nil,
	--- Quality of service.
	qos = 0,
	--- Last will callback function.
	last_will = nil,
	--- A log of the messages received.
	log = {},
	--- The MQTT broker host address. Defaults to `localhost`
	host = "localhost",
}


---------------------------------------------------------------------------
-- Initilizes the client.
-- Must be called before using the client.
-- @param host The address of the MQTT broker. Defaults to `localhost`
-- @param topic The channel to publish to. Defaults to `love`
-- @param qos The quality of service (0, 1 or 2). Defaults to 0
-- @param last_will A callback function. To be executed as a last will.
function mqtt_client:init(host, topic, qos, last_will)
	self.host = host or "localhost"
	self.topic = topic or 'love'
	self.qos = qos or 0
	self.last_will = last_will or function() print 'Last will' end
end


---------------------------------------------------------------------------
-- Publish a message.
-- Publishes a message to the current topic.
-- @param message The message payload to be published.
-- @return Returns nil if unsuccesfull.
function mqtt_client:publish(message)
	if not self.topic then
		print 'Init the client first!'
		return nil
	end

	-- TODO: Use Paho MQTT client instead of this hack
    local command = 'mosquitto_pub -h "'..self.host..'" -t "'..self.topic..'" -m "'..message..'"'
	os.execute(command)
end


-------------------------------------------------------
-- Shutdowns the client.
-- Must be called when done with the client to free-up resources.
function mqtt_client:shutdown()
	self.log = nil
end


return mqtt_client
