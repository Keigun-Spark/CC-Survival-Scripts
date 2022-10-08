local library = require("library")
local tArgs = {...}

function mineSquence(width, height, depth, side)
	
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