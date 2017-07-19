describe('Windows >', function()
	local Window = require 'src.objects.Window'

	describe('Window', function()
		it('should create a new instance.', function()
			local w = Window:new()
			assert.is_not_nil(w)
			assert.is_not_nil(w.width, 'missing "width" variable.')
			assert.is_not_nil(w.height, 'missing "height" variable.')
			assert.is_not_nil(w.draw_mode, 'missing "draw_mode" variable.')
			assert.is_not_nil(w.rect_color, 'missing "rect_color" variable.')
		end)

		it('should create a new instance with custom params.', function()
			local width = 300
			local height = 400
			local w = Window:new(width, height, {rect_color = '#0000FF'})
			assert.is_not_nil(w)
			assert.is_equal(w.width, width, "different widths.")
			assert.is_equal(w.height, height, "different heights.")
			assert.is_equal('#0000FF', w.rect_color)
		end)

		it('should detect a point inside', function()
			local w = Window:new(100,100)

			--- { x, y, expected_result }
			local test_data = {
				{-1, -1, false},
				{0, 0, true},
				{1, 1, true},
				{99, 99, true},
				{100, 0, true},
				{100, 100, true},
				{101, 99, false},
			}

			for index, data in ipairs(test_data) do
				local x, y, expected_result = unpack(data)
				local result = w:isPointInside(x,y)
				assert.is_equal(expected_result, result, "Failed on index: " .. index)
			end

		end)
	end)

	describe('TextWindow', function()
		local TextWindow = require 'src.objects.TextWindow'

		it('should add text', function()
			local w = TextWindow:new(300, 300, {
				text_list = {"uno", "dos", "tres"},
				x = 20, y = 300,
			})

			assert.is_equal(3, w:text_count())
			assert.is_equal(20, w.x)
			assert.is_equal(300, w.y)

			w:add_text("cuatro")
			assert.is_equal(4, w:text_count())

			w:reset_text()
			assert.is_equal(0, w:text_count())
		end)
	end)
end)
