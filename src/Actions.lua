----------------------------------------
-- Callbacks for user actions.
local Actions = {
	is_shift_down = false,
	created_while_shift = {}
}


function Actions:handleClick(button, x, y)
	-- Take into account the camera to get the correct coordinates
	local gameX, gameY = Engine.camera:mousePosition(x,y)

	if self.is_shift_down then
		local  e = Engine:create('obj', {x=gameX, y=gameY, color='#cccccc'})
		table.insert(self.created_while_shift, e)
	else
		Engine:create('obj', {x=gameX, y=gameY})
	end
end

return Actions
