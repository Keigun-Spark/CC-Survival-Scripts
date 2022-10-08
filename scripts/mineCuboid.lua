local library = require("library")
local tArgs = {...}

function mineSquence(width, height, depth, side)
	if side == "right" then
		if height % 3 == 0 then
			library.move.up()
			layer = height - 3
			row = width - 1
			library.move.forward()
			library.tools.dig("up")
			library.tools.dig("down")
			for i=1, width do
				while layer >= 1 do
					for j=1, depth - 1 do
						library.move.forward()
						library.tools.dig("up")
						library.tools.dig("down")
					end
					library.move.up(3)
					library.tools.dig("up")
					layer = layer - 3
					library.move.turnAround()
					for k=1, depth - 1 do
						library.move.forward()
						library.tools.dig("up")
						library.tools.dig("down")
					end
					row = row - 1
					if row > 0 then
						library.move.turnLeft()
						library.move.forward()
						library.tools.dig("up")
						library.tools.dig("down")
						library.move.turnLeft()
						library.tools.inventorySort()
						library.tools.dropJunk()
						for k=1, depth - 1 do
							library.move.forward()
							library.tools.dig("up")
							library.tools.dig("down")
						end
						library.move.down(3)
						library.tools.dig("down")
						layer = layer + 3
						library.move.turnAround()
						for k=1, depth - 1 do
							library.move.forward()
							library.tools.dig("up")
							library.tools.dig("down")
						end
						row = row - 1
					end
					if row > 0 then
						library.move.turnLeft()
						library.move.forward()
						library.tools.dig("up")
						library.tools.dig("down")
						library.move.turnLeft()
						library.tools.inventorySort()
						library.tools.dropJunk()
					end
				end
			end
		elseif height % 2 == 0 then
			layer = height - 2
			row = width - 1
			library.move.forward()
			library.tools.dig("up")
			for i=1, width do
				while layer >= 1 do
					for j=1, depth - 1 do
						library.move.forward()
						library.tools.dig("up")
					end
					library.move.up(2)
					library.tools.dig("up")
					layer = layer - 2
					library.move.turnAround()
					for k=1, depth - 1 do
						library.move.forward()
						library.tools.dig("up")
					end
					row = row - 1
					if row > 0 then
						library.move.turnLeft()
						library.move.forward()
						library.tools.dig("up")
						library.move.turnLeft()
						library.tools.inventorySort()
						library.tools.dropJunk()
						for k=1, depth - 1 do
							library.move.forward()
							library.tools.dig("up")
						end
						library.move.down(2)
						library.tools.dig("down")
						layer = layer + 2
						library.move.turnAround()
						for k=1, depth - 1 do
							library.move.forward()
							library.tools.dig("up")
						end
						row = row - 1
					end
					if row > 0 then
						library.move.turnLeft()
						library.move.forward()
						library.tools.dig("up")
						library.move.turnLeft()
						library.tools.inventorySort()
						library.tools.dropJunk()
					end
				end
			end
		elseif height % 1 == 0 then
			layer = height - 1
			row = width - 1
			library.move.forward()
			for i=1, width do
				while layer >= 1 do
					for j=1, depth - 1 do
						library.move.forward()
					end
					library.move.up()
					layer = layer - 1
					library.move.turnAround()
					for k=1, depth - 1 do
						library.move.forward()
					end
					row = row - 1
					if row > 0 then
						library.move.turnLeft()
						library.move.forward()
						library.move.turnLeft()
						library.tools.inventorySort()
						library.tools.dropJunk()
						for k=1, depth - 1 do
							library.move.forward()
						end
						library.move.down()
						layer = layer + 1
						library.move.turnAround()
						for k=1, depth - 1 do
							library.move.forward()
						end
						row = row - 1
					end
					if row > 0 then
						library.move.turnLeft()
						library.move.forward()
						library.move.turnLeft()
						library.tools.inventorySort()
						library.tools.dropJunk()
					end
				end
			end
		end
	elseif side == "left" then
		if height % 3 == 0 then
			library.move.up()
			layer = height - 3
			row = width - 1
			library.move.forward()
			library.tools.dig("up")
			library.tools.dig("down")
			for i=1, width do
				while layer >= 1 do
					for j=1, depth - 1 do
						library.move.forward()
						library.tools.dig("up")
						library.tools.dig("down")
					end
					library.move.up(3)
					library.tools.dig("up")
					layer = layer - 3
					library.move.turnAround()
					for k=1, depth - 1 do
						library.move.forward()
						library.tools.dig("up")
						library.tools.dig("down")
					end
					row = row - 1
					if row > 0 then
						library.move.turnRight()
						library.move.forward()
						library.tools.dig("up")
						library.tools.dig("down")
						library.move.turnRight()
						library.tools.inventorySort()
						library.tools.dropJunk()
						for k=1, depth - 1 do
							library.move.forward()
							library.tools.dig("up")
							library.tools.dig("down")
						end
						library.move.down(3)
						library.tools.dig("down")
						layer = layer + 3
						library.move.turnAround()
						for k=1, depth - 1 do
							library.move.forward()
							library.tools.dig("up")
							library.tools.dig("down")
						end
						row = row - 1
					end
					if row > 0 then
						library.move.turnRight()
						library.move.forward()
						library.tools.dig("up")
						library.tools.dig("down")
						library.move.turnRight()
						library.tools.inventorySort()
						library.tools.dropJunk()
					end
				end
			end
		elseif height % 2 == 0 then
			layer = height - 2
			row = width - 1
			library.move.forward()
			library.tools.dig("up")
			for i=1, width do
				while layer >= 1 do
					for j=1, depth - 1 do
						library.move.forward()
						library.tools.dig("up")
					end
					library.move.up(2)
					library.tools.dig("up")
					layer = layer - 2
					library.move.turnAround()
					for k=1, depth - 1 do
						library.move.forward()
						library.tools.dig("up")
					end
					row = row - 1
					if row > 0 then
						library.move.turnRight()
						library.move.forward()
						library.tools.dig("up")
						library.move.turnRight()
						library.tools.inventorySort()
						library.tools.dropJunk()
						for k=1, depth - 1 do
							library.move.forward()
							library.tools.dig("up")
						end
						library.move.down(2)
						library.tools.dig("down")
						layer = layer + 2
						library.move.turnAround()
						for k=1, depth - 1 do
							library.move.forward()
							library.tools.dig("up")
						end
						row = row - 1
					end
					if row > 0 then
						library.move.turnRight()
						library.move.forward()
						library.tools.dig("up")
						library.move.turnRight()
						library.tools.inventorySort()
						library.tools.dropJunk()
					end
				end
			end
		elseif height % 1 == 0 then
			layer = height - 1
			row = width - 1
			library.move.forward()
			for i=1, width do
				while layer >= 1 do
					for j=1, depth - 1 do
						library.move.forward()
					end
					library.move.up()
					layer = layer - 1
					library.move.turnAround()
					for k=1, depth - 1 do
						library.move.forward()
					end
					row = row - 1
					if row > 0 then
						library.move.turnRight()
						library.move.forward()
						library.move.turnRight()
						library.tools.inventorySort()
						library.tools.dropJunk()
						for k=1, depth - 1 do
							library.move.forward()
						end
						library.move.down()
						layer = layer + 1
						library.move.turnAround()
						for k=1, depth - 1 do
							library.move.forward()
						end
						row = row - 1
					end
					if row > 0 then
						library.move.turnRight()
						library.move.forward()
						library.move.turnRight()
						library.tools.inventorySort()
						library.tools.dropJunk()
					end
				end
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