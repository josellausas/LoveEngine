local Manager = {
	registered_objects = nil,
	moving_objects = nil,
	static_objects = nil,
	ui_objects = nil,
}

function Manager:init()
	self.registered_objects = {}
	self.moving_objects = {}
	self.static_objects = {}
	self.ui_objects = {}
end

function Manager:register(obj)
	table.insert(self.registered_objects, obj)
end

function Manager:register_ui(obj)
	self:register(obj)
	-- Register for mouse events
	table.insert(self.ui_objects, obj)
end

function Manager:register_moving(obj)
	self:register(obj)
	table.insert(self.moving_objects, obj)
end

function Manager:register_static(obj)
	self:register(obj)
	table.insert(self.static_objects, obj)
end

function Manager:get_ui_collisions(x,y)
	local found = {}
	for index, ui_object in ipairs(self.ui_objects) do
		if ui_object:isPointInside(x,y) == true then
			table.insert(found, ui_object)
		end
	end
	return found
end

function Manager:shutdown()
	-- TODO: Dispose of things here
end


return Manager
