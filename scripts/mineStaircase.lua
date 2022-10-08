local library = require("library")
local tArgs = {...}

local function mineSquence(steps, direction)
	for i=1, steps do
		if direction == "up" then
			while turtle.detectUp() do
				library.tools.dig("up")
			end
			library.move.forward()
			library.move.up()
		elseif direction == "down" then
			while turtle.detectDown() do
				library.tools.dig("down")
			end
			library.move.forward()
			library.move.down()
		end
		library.tool.inventorySort()
		library.tools.dropJunk()
	end
end

if type(tonumber(tArgs[1])) ~= "number" and type(tostring(tArgs[2])) ~= "up" and type(tostring(tArgs[2])) ~= "down" then
	term.clear()
	term.setCursorPos(1,1)
	error("Define step amount and direction! (Example: '10 up') [10 steps, upwards]")
end

local start = library.data.copyTable(library.data.coords)
library.data.saveData("/.save", "/start_pos", start)
mineSquence(tonumber(tArgs[1]), tostring(tArgs[2]))
fs.delete("/.save")