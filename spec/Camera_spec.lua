_G.love = {
	graphics = {
		push = function() end,
		rotate = function(r) end,
		scale = function(x,y) end,
		translate = function(x,y) end,
		pop = function() end
	},
}

describe('Camera', function()
	local Camera = require('src.Camera')

	it('can be set', function()
		local c = Camera:new()
		c:set()
	end)

	it('can be unset', function()
		local c = Camera:new()
		c:unset()
	end)

	it('can move', function()
		local c = Camera:new()
		c:move(9, 7)
	end)

	it('can rotate', function()
		local c = Camera:new()
		c:rotate(0.3)
	end)

	it('can scale', function()
		local c = Camera:new()
		c:scale(1,1)
		c:setScale(1,1)
	end)

	it('can set position', function()
		local c = Camera:new()
		c:setPosition(1,1)
	end)

	it('can convert mouse position relative to camera', function()
		local c = Camera:new()
		local x,y = c:mousePosition(10,10)
	end)

	it('can update its position', function()
		local c = Camera:new()
		c:update(0.0001, {left=1,right=1,up=1,down=1})
	end)
end)

