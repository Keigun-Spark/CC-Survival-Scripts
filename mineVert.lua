local data = require ("dataAPI")
local move = require("moveAPI")
local dig = require ("digAPI")
local tools = require("toolsAPI")
local tArgs = {...}

function mineSquence(height, start)
  while move.down() do
    if start.y - 2 == data.coord.y then
      if tools.findItem("minecraft:cobblestone") then
        turtle.placeUp()
      elseif tools.findItem("minecraft:dirt") then
        turtle.placeUp()
      end
    end
    dig.checkForOre()
  end
  if data.hasWireless then
    rednet.broadcast("Found Bedrock at Y: "..data.coord.y-1)
    rednet.broadcast("Returning to the Surface")
  end
  local y = start.y - data.coord.y
  for i=1,y do
    move.up()
    if i == y then
      tools.findItem("minecraft:cobblestone")
      turtle.placeDown()
    end
  end
end

if type(tArgs[1]) ~= "number" then
	term.clear()
	term.setCursorPos(1,1)
	error("Define height! (Example: '10') [10 blocks]")
end

local start = data.copyTable(data.coords)
data.saveData("/.save", "/start_pos", start)
mineSquence(tonumber(tArgs[1]), start)
move.moveTo(start.x, start.y, start.z)
fs.delete("/.save")
