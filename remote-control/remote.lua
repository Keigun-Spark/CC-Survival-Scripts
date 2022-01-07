--[[
This program controls the program turtle.lua via the rednet API

todo:
start status update corroutine on connect and end on disconnect
]]
local complete = require("cc.completion")

-- find modem and open rednet or error
if peripheral.find("modem") then
	peripheral.find("modem", rednet.open)
else
	error("Modem not found.",0)
end

-- color pallet
local bColor = colors.black
local tColor = colors.white
local cColor = colors.white
if term.isColor() then
	tColor = colors.blue
	cColor = colors.green
end

local currentID = nil
local currentStatus = nil
local aliases = {}
local standardReplys = {
	ready = "ready",
	busy = "busy",
	running = "running",
	done = "done",
}

-- save table data to a file
local function saveData(dir, file, tbl)
	if type(tbl) ~= "table" then
		print("Wrong data type.")
		return
	end
	if not fs.exists(dir) then
		fs.makeDir(dir)
	end
	local handle = fs.open(dir..file, "w")
	tbl = textutils.unserialise(tbl)
	handle.write(tbl)
	handle.close()
end

-- load table data from a file
local function loadData(dir, file)
	if fs.exists(dir..file) then
		local handle = fs.open(dir..file, "r")
		local tbl = handle.readAll()
		handle.close()
		tbl = textutils.serialise(tbl)
		return tbl
	end
	return false
end

-- takes a string and splits it at a space and returns it in a table as strings and numbers
local function parse(str)
	local tbl = {}
	for word in string.gmatch(str, "([^ ]+)") do
		word = tonumber(word) or word
		table.insert(tbl,word)
	end
	return tbl
end

-- waits for a response from specified id
local function waitForResponse(id)
	local rID,response
	for i=1,3 do
		rID,response = rednet.receive(nil,2)
		if rID == id then
			return response
		end
	end
end

-- clears the screen
local function clear()
	term.clear()
	term.setCursorPos(1,1)
end

-- list of commands available
local function help()
	if currentID then
		print("discconect")
		print("")
	else
		print("connect <id/name>")
	end
	print("exit")
	print("clear")
end

-- sets the alias and label of the connected turtle
local function setAlias(name)
	rednet.send(currentID, "setAlias "..name)
	local recipt = waitForResponse(currentID)
	if recipt ~= standardReplys.done then
		return
	end
	aliases[name] = currentID
	saveData("/.save", "/aliases", aliases)
end

-- gets the label and sets the alias of the connected turtle
local function getAlias()
	rednet.send(currentID, "getAlias")
	local msg = waitForResponse(currentID)
	if msg == "nil" then
		msg = nil
	else
		aliases[msg] = currentID
		saveData("/.save", "/aliases", aliases)
	end
	return msg
end

-- standard world actions for the connected turtle
local function sendCommand(com)
	local comList = {
		"forward",
		"back",
		"turnLeft",
		"turnRight",
		"up",
		"down",
		"dig",
		"digUp",
		"digDown",
		"place",
		"placeUp",
		"placeDown",
	}
	if not com then
		return comList
	else
		for i = 1, #comList do
			if com == comList[i] then
				rednet.send(currentID, com)
				local response = waitForResponse(currentID)
				if response ~= standardReplys.done then
					print(response)
				end
				return
			end
		end
		printError("Not a command")
	end
end

-- disconnects from the connected turtle
local function disconnect()
	rednet.send(currentID,"disconnect")
	local response = waitForResponse(currentID)
	if response == standardReplys.done then
		currentID = nil
	end
end

-- will keep the session alive once implemented
local function status()
	while true do
		if currentID then
			rednet.send(currentID,"status")
			repeat
				local id,msg = rednet.receive(nil,2)
				if not id or not msg then
					disconnect()
					print("Disconnected")
					return
				end
				currentStatus = status
			until id == currentID
		end
		print(currentStatus)
		sleep(2)
	end
end

-- connects to turtle and intiates session
local function connect(id)
	local hCommand = {}
	local commandList = {
		"clear",
		"disconnect",
		"getAlias",
		"help",
		"setAlias ",
		"turtle ",
	}
	local converter = {
		["clear"] = clear,
		["disconnect"] = disconnect,
		["getAlias"] = getAlias,
		["help"] = help,
		["setAlias"] = setAlias,
		["turtle"] = sendCommand,
	}
	if type(id) == "string" then
		if aliases[id] then
			id = aliases[id]
		else
			printError("Alias isn't registered.")
			return
		end
	end
	rednet.send(id, "connect")
	local response = waitForResponse(id)
	if response == standardReplys.done then
		currentID = id
	end
	local name = getAlias()
	while currentID do
		term.setTextColor(cColor)
		if name then
			term.write(name.."> ")
		else
			term.write(tostring(currentID).."> ")
		end
		local command = read(nil,hCommand,function(text) if text ~= "" then return complete.choice(text,commandList) elseif text == "turtle " then return complete.choice(text,sendCommand()) end end)
		if command == "" then
			command = nil
		end
		if hCommand[#hCommand] ~= command and command then
			table.insert(hCommand,command)
		end
		if command then
			command = parse(command)
			if command[1] == "exit" then
				disconnect()
				return true
			elseif converter[command[1]] then
				if #command > 1 then
					converter[command[1]](command[2])
				else
					converter[command[1]]()
				end
			end
		end
	end
end

local hConnect = {}

aliases = loadData("/.save", "/aliases")

-- main loop
while true do
	local converter = {
		["connect"] = connect,
		["help"] = help,
		["clear"] = clear
	}
	local commandList = {
		"clear",
		"connect ",
		"help",
	}
	term.setBackgroundColor(bColor)
	term.setTextColor(tColor)
	term.write("> ")
	local command = read(nil,hConnect,function(text) if text ~= "" then return complete.choice(text,commandList) end end)
	if command == "" then
		command = nil
	end
	if hConnect[#hConnect] ~= command and command then
		table.insert(hConnect,command)
	end
	if command then
		command = parse(command)
		if command[1] == "exit" then
			rednet.close()
			return
		elseif converter[command[1]] then
			local exit
			if #command > 1 then
				exit = converter[command[1]](command[2])
			else
				exit = converter[command[1]]()
			end
			if exit then
				rednet.close()
				return
			end
		end
	end
end
