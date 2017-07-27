---------------------------------------------------------------
-- Analytics and Log reporting.
-- Modular reporting and logging.
local mqtt = require 'src.MQTT'


------------------------------------------------------------------
-- Resets the analytic's counts.
-- @return {} a new counter table.
local function reset_counts()
	return {
		engine_init = 0,
		engine_shutdown = 0,
		created_objects = 0,
	}
end


------------------------------------------------------------------
-- Analytics Module.
-- Logs and publishes to the different log channels.
local Analytics = {
	enabled = true,
	--- The minimum log level to register. 0 = info, 1 = warning, 2 = critical
	log_level = 0,
	--- Should it log to mqtt.
	is_mqtt_enabled = true,
	--- Should it print to console
	is_console_enabled = false,
	--- A table that keeps count of things
	counts = reset_counts()
}


----------------------------------------------------------------------------
-- Digests a message that is ready for publishing.
-- Publishes to the different logging channels depending if they are enabled.
local function digest_message(message)
	if Analytics.is_console_enabled == true then
		print(message)
	end

	if Analytics.is_mqtt_enabled == true then
		-- TODO: Change this once we have a better mqtt client
		mqtt:init("192.168.1.117", "game/analytics", 0, nil)
		mqtt:publish(message)
		mqtt:shutdown()
	end
end


---------------------------------------------------------------------------
-- Logs a text message.
-- Logs a message if the log_level is high enough.
function Analytics:log(message, log_level)
	-- Only log if we are anabled
	if not self.enabled then return nil end

	-- Default log_level = 0
	if not log_level then log_level = 0 end

	-- Check if log is important enough
	if log_level >= self.log_level then
		digest_message(message)
	end
end


------------------------------------------------------------------------
-- Logs an event.
-- Logs a predefined event with custom actions.
-- @param object_name The name of the object that triggers the event
-- @param event_name The name of the event.
-- @param opts A table of options.
function Analytics:event(object_name, event_name, opts)
	-- Check for nil opts error
	if not opts then opts = {} end

	-- Handle Engine events
	if object_name == 'Engine' then
		if event_name == 'init' then
			-- Count the number of inits
			self.counts.engine_init = self.counts.engine_init + 1
			-- Log the event
			digest_message("Engines initilized: " .. self.counts.engine_init)
		elseif event_name == 'shutdown' then
			-- Count the shutdowns
			self.counts.engine_shutdown = self.counts.engine_shutdown + 1
			-- Digest the message
			digest_message("Engines shutdown: " .. self.counts.engine_shutdown)
		end
	end
end


return Analytics
