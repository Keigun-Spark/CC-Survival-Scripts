local library = require("library")
local tArgs = {...}

function mineSquence(width, height, depth, side)
	if side == "right" then
		if height % 3 == 0 then
			library.move.up()
			row = height - 3
			for j=1, depth do
				library.move.forward()
				library.tools.dig("up")
				library.tools.dig("down")
			end
			for i=1, width do
				while row >= 1 do
					library.move.up("3")
					row = row - 3
					library.move.turnAround()
					for k=1, depth - 1 do
						library.move.forward()
						library.tools.dig("up")
						library.tools.dig("down")
					end
				end
				library.move.turnRight()
				library.move.forward()
				library.tools.dig("up")
				library.tools.dig("down")
				library.move.turnRight()
				library.tools.inventorySort()
				library.tools.dropJunk()
				row = height - 3
				while row >= 1 do
					library.move.down("3")
					row = row - 3
					library.move.turnAround()
					for k=1, depth - 1 do
						library.move.forward()
						library.tools.dig("up")
						library.tools.dig("down")
					end
				end
				library.move.turnLeft()
				library.move.forward()
				library.tools.dig("up")
				library.tools.dig("down")
				library.move.turnLeft()
				library.tools.inventorySort()
				library.tools.dropJunk()
			end
		elseif height % 2 == 0 then
			row = height - 2
			for j=1, depth do
				library.move.forward()
				library.tools.dig("up")
			end
			for i=1, width do
				while row >= 1 do
					library.move.up("2")
					row = row - 2
					library.move.turnAround()
					for k=1, depth - 1 do
						library.move.forward()
						library.tools.dig("up")
					end
				end
				library.move.turnRight()
				library.move.forward()
				library.tools.dig("up")
				library.move.turnRight()
				library.tools.inventorySort()
				library.tools.dropJunk()
				row = height - 2
				while row >= 1 do
					library.move.down("2")
					row = row - 2
					library.move.turnAround()
					for k=1, depth - 1 do
						library.move.forward()
						library.tools.dig("down")
					end
				end
				library.move.turnLeft()
				library.move.forward()
				library.tools.dig("down")
				library.move.turnLeft()
				library.tools.inventorySort()
				library.tools.dropJunk()
			end
		elseif height % 1 == 0 then
			row = height - 1
			for j=1, depth do
				library.move.forward()
			end
			for i=1, width do
				while row >= 1 do
					library.move.up()
					row = row - 1
					library.move.turnAround()
					for k=1, depth - 1 do
						library.move.forward()
					end
				end
				library.move.turnRight()
				library.move.forward()
				library.move.turnRight()
				library.tools.inventorySort()
				library.tools.dropJunk()
				row = height - 1
				while row >= 1 do
					library.move.down()
					row = row - 1
					library.move.turnAround()
					for k=1, depth - 1 do
						library.move.forward()
					end
				end
				library.move.turnLeft()
				library.move.forward()
				library.move.turnLeft()
				library.tools.inventorySort()
				library.tools.dropJunk()
			end
		end
	elseif side == "left" then
		if height % 3 == 0 then
			library.move.up()
			row = height - 3
			for j=1, depth do
				library.move.forward()
				library.tools.dig("up")
				library.tools.dig("down")
			end
			for i=1, width do
				while row >= 1 do
					library.move.up("3")
					row = row - 3
					library.move.turnAround()
					for k=1, depth - 1 do
						library.move.forward()
						library.tools.dig("up")
						library.tools.dig("down")
					end
				end
				library.move.turnLeft()
				library.move.forward()
				library.tools.dig("up")
				library.tools.dig("down")
				library.move.turnLeft()
				library.tools.inventorySort()
				library.tools.dropJunk()
				row = height - 3
				while row >= 1 do
					library.move.down("3")
					row = row - 3
					library.move.turnAround()
					for k=1, depth - 1 do
						library.move.forward()
						library.tools.dig("up")
						library.tools.dig("down")
					end
				end
				library.move.turnRight()
				library.move.forward()
				library.tools.dig("up")
				library.tools.dig("down")
				library.move.turnRight()
				library.tools.inventorySort()
				library.tools.dropJunk()
			end
		elseif height % 2 == 0 then
			row = height - 2
			for j=1, depth do
				library.move.forward()
				library.tools.dig("up")
			end
			for i=1, width do
				while row >= 1 do
					library.move.up("2")
					row = row - 2
					library.move.turnAround()
					for k=1, depth - 1 do
						library.move.forward()
						library.tools.dig("up")
					end
				end
				library.move.turnLeft()
				library.move.forward()
				library.tools.dig("up")
				library.move.turnLeft()
				library.tools.inventorySort()
				library.tools.dropJunk()
				row = height - 2
				while row >= 1 do
					library.move.down("2")
					row = row - 2
					library.move.turnAround()
					for k=1, depth - 1 do
						library.move.forward()
						library.tools.dig("down")
					end
				end
				library.move.turnRight()
				library.move.forward()
				library.tools.dig("down")
				library.move.turnRight()
				library.tools.inventorySort()
				library.tools.dropJunk()
			end
		elseif height % 1 == 0 then
			row = height - 1
			for j=1, depth do
				library.move.forward()
			end
			for i=1, width do
				while row >= 1 do
					library.move.up()
					row = row - 1
					library.move.turnAround()
					for k=1, depth - 1 do
						library.move.forward()
					end
				end
				library.move.turnLeft()
				library.move.forward()
				library.move.turnLeft()
				library.tools.inventorySort()
				library.tools.dropJunk()
				row = height - 1
				while row >= 1 do
					library.move.down()
					row = row - 1
					library.move.turnAround()
					for k=1, depth - 1 do
						library.move.forward()
					end
				end
				library.move.turnRight()
				library.move.forward()
				library.move.turnRight()
				library.tools.inventorySort()
				library.tools.dropJunk()
			end
		end
	end
end

if type(tonumber(tArgs[1])) ~= "number" and type(tonumber(tArgs[2])) ~= "number" and type(tonumber(tArgs[3])) ~= "number" and type(tostring(tArgs[4])) ~= "right" and type(tostring(tArgs[4])) ~= "left" then
	term.clear()
	term.setCursorPos(1,1)
	error("Width, height, depth and side are required! (Example: '5 5 10 right') [5 blocks wide, 5 block heigh, 10 blocks deep and to the right of turtle]")
end

local start = library.data.copyTable(library.data.coords)
library.data.saveData("/.save", "/start_pos", start)
library.storage.avoidChest()
mineSquence(tonumber(tArgs[1]), tonumber(tArgs[2]), tonumber(tArgs[3]), (tostring(tArgs[4])))
library.move.moveTo(start.x, start.y, start.z)
library.storage.drop(library.tools.maxSlots)
fs.delete("/.save")