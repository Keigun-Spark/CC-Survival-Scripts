local tArgs = {...}

local lib = {
	timeout = 5,
	d = 0,
	hasWireless = false,
	direction = {[0] = "north", [1] = "east", [2] = "south", [3] = "west"},
	coords = {x = 0, y = 0,z = 0},
	maxSlots = 16,
	slot = 1,
}

local stack = {}

local inverter = {
	["forward"] = lib.backward,
	["back"] = lib.forward,
	["turnLeft"] = lib.turnRight,
	["turnRight"] = lib.turnLeft,
	["up"] = lib.down,
	["down"] = lib.up,
}

local converter = {
	["forward"] = lib.forward,
	["back"] = lib.backward,
	["turnLeft"] = lib.turnLeft,
	["turnRight"] = lib.turnRight,
	["up"] = lib.up,
	["down"] = lib.down,
}

local oreList = {
	"minecraft:iron_ore",
	"minecraft:coal_ore",
	"minecraft:gold_ore",
	"minecraft:diamond_ore",
	"minecraft:emerald_ore",
	"minecraft:copper_ore",
	"minecraft:lapis_ore",
	"minecraft:redstone_ore",
	"minecraft:deepslate_iron_ore",
	"minecraft:deepslate_coal_ore",
	"minecraft:deepslate_gold_ore",
	"minecraft:deepslate_diamond_ore",
	"minecraft:deepslate_emerald_ore",
	"minecraft:deepslate_copper_ore",
	"minecraft:deepslate_lapis_ore",
	"minecraft:deepslate_redstone_ore",
	"minecraft:nether_gold_ore",
	"minecraft:nether_quartz_ore",
	"minecraft:obsidian",
	"thermalfoundation:ore",
	"thermalfoundation:ore_fluid",
	"mekanism:oreblock",
	"matteroverdrive:dilithium_ore",
	"matteroverdrive:tritanium_ore",
	"thaumcraft:ore_cinbar",
	"thaumcraft:ore_quartz",
	"thaumcraft:ore_amber",
	"deepresonance:resonating_ore",
	"bigreactor:oreangelsite",
	"bigreactor:orebenitoite",
	"bigreactor:oreyellorite",
	"mca:rose_gold_ore",
	"railcraft:ore",
	"railcraft:ore_metal",
	"railcraft:ore_metal_poor",
	"railcraft:ore_magic",
	"ic2:resource",
	"fossil:fossil",
	"moreplanets:fronos_iron_ore",
	"moreplanets:fronos_gold_ore",
	"moreplanets:fronos_tin_ore",
	"moreplanets:fronos_copper_ore",
	"moreplanets:fronos_aluminium_ore",
	"moreplanets:fronos_lead_ore",
	"moreplanets:fronos_coal_ore",
	"moreplanets:fronos_lapis_ore",
	"moreplanets:fronos_diamond_ore",
	"moreplanets:fronos_emerald_ore",
	"moreplanets:fronos_redstone_ore",
	"moreplanets:fronos_silicon_ore",
	"moreplanets:fronos_quartz_ore",
	"moreplanets:extrailonite_ore",
	"moreplanets:setronium_ore",
	"moreplanets:sillenium_ore",
	"moreplanets:diona_tin_ore",
	"moreplanets:diona_copper_ore",
	"moreplanets:diona_aluminium_ore",
	"moreplanets:anti_gravity_ore",
	"moreplanets:goldenite_crystal_ore",
	"moreplanets:koentus_tin_ore",
	"moreplanets:koentus_copper_ore",
	"moreplanets:koentus_aluminium_ore",
	"moreplanets:koentus_iron_ore",
	"moreplanets:diremsium_ore",
	"moreplanets:zyptronium_ore",
	"moreplanets:cheese_milk_ore",
	"moreplanets:chalos_iron_ore",
	"moreplanets:chalos_tin_ore",
	"moreplanets:chalos_copper_ore",
	"moreplanets:chalos_alumiium_ore",
	"moreplanets:infected_iron_ore",
	"moreplanets:infected_gold_ore",
	"moreplanets:infected_tin_ore",
	"moreplanets:infected_copper_ore",
	"moreplanets:infected_aluminium_ore",
	"moreplanets:infected_coal_ore",
	"moreplanets:infected_lapis_ore",
	"moreplanets:infected_diamond_ore",
	"moreplanets:infected_emerald_ore",
	"moreplanets:infected_redstone_ore",
	"moreplanets:infected_silicon_ore",
	"moreplanets:infected_crystal_ore",
	"immersiveengineering:ore",
	"growthcraft:salt_ore",
	"aroma1997sdimension:miningore",
	"bewitchment:amethyst_ore",
	"bewitchment:garnet_ore",
	"bewitchment:opal_ore",
	"bewitchment:silver_ore",
	"bewitchment:salt_ore",
	"biomesoplenty:gem_ore",
	"tconstruct:ore"
}

local junkList = {
	"minecraft:dirt",
	"minecraft:gravel",
	"minecraft:cobblestone",
	"minecraft:cobbled_deepslate",
	"minecraft:tuff",
	"minecraft:andesite",
	"minecraft:diorite",
	"minecraft:granite",
}

local fuelList = {
	"minecraft:coal",
	"minecraft:coal_block",
	"minecraft:charcoal",
	"mekanism:block_charcoal",
	"minecraft:lava_bucket",
}

function lib.copyTable(tbl)
	if type(tbl) ~= "table" then
		error("The type of 'tbl' is not a table",2)
	end
	local rtbl = {}
	for k,v in pairs(tbl) do
		rtbl[k] = v
	end
	return rtbl
end

function lib.saveData(dir, path, tbl)
	if type(tbl) ~= "table" then
		error("The type of 'tbl' is not a table",2)
	elseif type(path) ~= "string" or type(dir) ~= "string" then
		error("The type of 'path' or 'dir' is not a string",2)
	end
	if not fs.exists(dir) then
		fs.makeDir(dir)
	end
	local f = fs.open(dir .. path, "w")
	f.write(textutils.serialize(tbl))
	f.close()
end

function lib.loadData(dir, path)
	if type(path) ~= "string" or type(dir) ~= "string" then
		error("The type of 'path' or 'dir' is not a string",2)
	end
	if fs.exists(dir) then
		local tbl = {}
		local f = fs.open(dir .. path, "r")
		tbl = f.readAll()
		tbl = textutils.unserialize(tbl)
		f.close()
		return tbl
	end
	return false
end

function lib.findItem(name)
	for i=1, lib.maxSlots do
		if turtle.getItemCount(i) ~= 0 then
			local item = turtle.getItemDetail(i).name
			if item == name then
				turtle.select(i)
				lib.slot = tonumber(i)
				return true
			end
		end
	end
	return false
end

function lib.inventorySort()
	local inv = {}
	for i=1, lib.maxSlots do
		inv[i] = turtle.getItemDetail(i)
	end
	for i=1, lib.maxSlots do
		if inv[i] and inv[i].count < 64 then
		for j=(i+1), lib.maxSlots do
			if inv[j] and inv[i].name == inv[j].name then
				if turtle.getItemSpace(i) == 0 then
					break
				end
				turtle.select(j)
				lib.slot = j
				local count = turtle.getItemSpace(i)
				if count > inv[j].count then
					count = inv[j].count
				end
				turtle.transferTo(i, count)
				inv[i].count = inv[i].count + count
				inv[j].count = inv[j].count - count
				if inv[j].count <= 0 then
					inv[j] = nil
			end
			end
		end
		end
	end
	for i=1, lib.maxSlots do
		if not inv[i] then
			for j=(i+1), lib.maxSlots do
				if inv[j] then
				turtle.select(j)
				lib.slot = j
				turtle.transferTo(i)
				inv[i] = lib.copyTable(inv[j])
				inv[j] = nil
				break
				end
			end
		end
	end
	turtle.select(1)
	lib.slot = 1
end


function lib.place(blockName, direction)
	lib.findItem(blockName)
	if direction == nil then
		turtle.place()
	elseif direction == "up" then
		turtle.placeUp()
	elseif direction == "down" then
		turtle.placeDown()
	end
end

function lib.dig(direction)
	if direction == nil then
		turtle.dig()
		os.sleep(0.4)
	elseif direction == "up" then
		turtle.digUp()
		os.sleep(0.4)
	elseif direction == "down" then
		turtle.digDown()
		os.sleep(0.4)
	end
end

function lib.dropJunk()
	for i=1, lib.maxSlots do
		if turtle.getItemCount(i) ~= 0 then
			local item = turtle.getItemDetail(i).name
			local isJunk = false
			for index, value in ipairs(junkList) do
				if item == value then
					isJunk = true
					break
				end
			end
			if isJunk then
				turtle.select(i)
				lib.slot = tonumber(i)
				turtle.dropUp()
			end
		end
	end
	lib.inventorySort()
end

function lib.findJunk(exclude)
	if exclude == nil then
		exclude = "nothing"
	end
	local isJunk = false
	for i=1, lib.maxSlots do
		if turtle.getItemCount(i) ~= 0 then
			local item = turtle.getItemDetail(i).name
			for index, value in ipairs(junkList) do
				if item == value and item ~= exclude then
					isJunk = true
					break
				end
			end
			if isJunk then
				turtle.select(i)
				lib.slot = tonumber(i)
				return isJunk
			end
		end
	end
	return isJunk
end

function lib.refuel()
	for index, value in ipairs(fuelList) do
		if lib.findItem(tostring(value)) then
			while turtle.getItemCount(lib.slot) >= 1 and turtle.getFuelLevel() < turtle.getFuelLimit() do
				turtle.refuel()
			end
			return true
		end
	end
	return false
end

function lib.turnLeft()
	turtle.turnLeft()
	lib.d = (lib.d - 1) % 4
	lib.saveData("/.save", "/face", {d = lib.d})
end

function lib.turnRight()
	turtle.turnRight()
	lib.d = (lib.d + 1) % 4
	lib.saveData("/.save", "/face", {d = lib.d})
end

function lib.turnAround()
	turtle.turnRight()
	turtle.turnRight()
	lib.d = (lib.d + 2) % 4
	lib.saveData("/.save", "/face", {d = lib.d})
end

function lib.face(direction)
	if type(direction) == "number" or "string" then
		if type(direction) == "string" then
			for k,v in pairs(lib.direction) do
				if v == direction then
					direction = k
					break
				end
			end
		end
		if direction == (lib.d + 2) % 4 then
			lib.turnAround()
			return true
		elseif direction == (lib.d - 1) % 4 then
			lib.turnLeft()
			return true
		elseif direction == (lib.d + 1) % 4 then
			lib.turnRight()
			return true
		elseif direction == lib.d then
			return true
		end
	end
	error("the type of 'direction' is not of type number, string or is invalid")
end

function lib.forward(times)
	if times == nil then
		times = 1
	end
	if times < 0 then
		lib.backward(-times)
	end
	for i=1, times do
		if not lib.refuel() and turtle.getFuelLevel() == 0 then
			while not lib.refuel() do
				term.clear()
				term.setCursorPos(1,1)
				print("Out of fuel!")
				if lib.hasWireless == true then
					rednet.broadcast("Out of fuel at X: "..lib.coords.x.." Y: "..lib.coords.y.." Z: "..lib.coords.z)
				end
				os.sleep(lib.timeout)
			end
		end
		while not turtle.forward() do
			local inspect = {turtle.inspect()}
			if inspect[1] and inspect[2].name == "minecraft:bedrock" then
				return false
			elseif inspect[1] and inspect[2].name ~= "minecraft:bedrock" then
				while turtle.detect() do
					lib.dig()
				end
			else
				turtle.attack()
			end
		end
		if lib.d == 0 then
			lib.coords.z = lib.coords.z - 1
		elseif lib.d == 1 then
			lib.coords.x = lib.coords.x + 1
		elseif lib.d == 2 then
			lib.coords.z = lib.coords.z + 1
		elseif lib.d == 3 then
			lib.coords.x = lib.coords.x - 1
		end
		lib.saveData("/.save", "/position", lib.coords)
	end
	return true
end

function lib.left(times)
	lib.turnLeft()
	lib.forward(times)
	lib.turnRight()
end

function lib.right(times)
	lib.turnRight()
	lib.forward(times)
	lib.turnLeft()
end

function lib.backward(times)
	if times == nil then
		times = 1
	end
	if times < 0 then
		lib.forward(-times)
	end
	for i=1, times do
		if not lib.refuel() and turtle.getFuelLevel() == 0 then
			while not lib.refuel() do
				term.clear()
				term.setCursorPos(1,1)
				print("Out of fuel!")
				if lib.hasWireless == true then
					rednet.broadcast("Out of fuel at X: "..lib.coords.x.." Y: "..lib.coords.y.." Z: "..lib.coords.z)
				end
				os.sleep(lib.timeout)
			end
		end
		turtle.back()
		if lib.d == 0 then
			lib.coords.z = lib.coords.z + 1
		elseif lib.d == 1 then
			lib.coords.x = lib.coords.x - 1
		elseif lib.d == 2 then
			lib.coords.z = lib.coords.z - 1
		elseif lib.d == 3 then
			lib.coords.x = lib.coords.x + 1
		end
		lib.saveData("/.save", "/position", lib.coords)
	end
end

function lib.up(times)
	if times == nil then
		times = 1
	end
	if times < 0 then
		lib.down(-times)
	end
	for i=1, times do
		if not lib.refuel() and turtle.getFuelLevel() == 0 then
			while not lib.refuel() do
				term.clear()
				term.setCursorPos(1,1)
				print("Out of fuel")
				if lib.hasWireless == true then
					rednet.broadcast("Out of fuel at X: "..lib.coords.x.." Y: "..lib.coords.y.." Z: "..lib.coords.z)
				end
				os.sleep(lib.timeout)
			end
		end
		while not turtle.up() do
			local inspect = {turtle.inspectUp()}
			if inspect[1] and inspect[2].name == "minecraft:bedrock" then
				return false
			elseif inspect[1] and inspect[2].name ~= "minecraft:bedrock" then
				lib.dig("up")
			else
				turtle.attackUp()
			end
		end
		lib.coords.y = lib.coords.y + 1
		lib.saveData("/.save", "/position", lib.coords)
	end
	return true
end

function lib.down(times)
	if times == nil then
		times = 1
	end
	if times < 0 then
		lib.up(-times)
	end
	for i=1, times do
		if not lib.refuel() and turtle.getFuelLevel() == 0 then
			while not lib.refuel() do
				term.clear()
				term.setCursorPos(1,1)
				print("Out of fuel")
				if lib.hasWireless == true then
					rednet.broadcast("Out of fuel at X: "..lib.coords.x.." Y: "..lib.coords.y.." Z: "..lib.coords.z)
				end
				os.sleep(lib.timeout)
			end
		end
		while not turtle.down() do
			local inspect = {turtle.inspectDown()}
			if inspect[1] and inspect[2].name == "minecraft:bedrock" then
				return false
			elseif inspect[1] and inspect[2].name ~= "minecraft:bedrock" then
				lib.dig("down")
			else
				turtle.attackDown()
			end
		end
		lib.coords.y = lib.coords.y - 1
		lib.saveData("/.save", "/position", lib.coords)
	end
	return true
end

function lib.moveTo(x, y, z)
	if x == "~" then
		x = lib.coords.x
	end
	if y == "~" then
		y = lib.coords.y
	end
	if z == "~" then
		z = lib.coords.z
	end
	if y > lib.coords.y then
		lib.up(y - lib.coords.y)
	end
	if x < lib.coords.x then
		lib.face(3)
		lib.forward(lib.coords.x - x)
	elseif x > lib.coords.x then
		lib.face(1)
		lib.forward(x - lib.coords.x)
	end
	if z < lib.coords.z then
		lib.face(0)
		lib.forward(lib.coords.z - z)
	elseif z > lib.coords.z then
		lib.face(2)
		lib.forward(z - lib.coords.z)
	end
	if y < lib.coords.y then
		lib.down(lib.coords.y - y)
	end
end

function lib.stackPop()
	local func = inverter[stack[#stack]]
	table.remove(stack)
	return func()
end

function lib.checkOreTable(tbl)
	if type(tbl) ~= "table" then
		error("'tbl' is not of type table", 2)
	end
	if tbl[1] == true then
		for k,v in pairs(oreList) do
			if tbl[2].name == oreList[k] then
				return true
			end
		end
	else
		return false
	end
end

function lib.veinMine(lastFunc)
	if type(lastFunc) == "function" or "string" then
		if type(lastFunc) == "function" then
			for k,v in pairs(converter) do
				if v == lastFunc then
					table.insert(stack, k)
					break
				end
			end
		end
		if lib.checkOreTable({turtle.inspectUp()}) then
			lib.up()
			return lib.veinMine(lib.up)
		elseif lib.checkOreTable({turtle.inspectDown()}) then
			lib.down()
			return lib.veinMine(lib.down)
		end
		for i=1, 4 do
			if lib.checkOreTable({turtle.inspect()}) then
				if i == 1 then
					lib.forward()
					return lib.veinMine(lib.forward)
				elseif i == 2 then
					return lib.veinMine(lib.turnLeft)
				elseif i == 3 then
					table.insert(stack, "turnLeft")
					return lib.veinMine(lib.turnLeft)
				elseif i == 4 then
					return lib.veinMine(lib.turnRight)
				end
			end
			lib.turnLeft()
		end
		if stack[#stack] == "turnLeft" then
			if stack[#stack] == stack[#stack-1] then
				lib.stackPop()
				lib.stackPop()
				lastFunc = stack[#stack]
				if #stack > 0 then
					return lib.veinMine(lastFunc)
				end
				return
			else
				lib.stackPop()
				lastFunc = stack[#stack]
				if #stack > 0 then
					return lib.veinMine(lastFunc)
				end
				return
			end
		else
			lib.stackPop()
			lastFunc = stack[#stack]
			if #stack > 0 then
				return lib.veinMine(lastFunc)
			end
			return
		end
	else
		error("'lastFunc' is not of type function or string", 2)
	end
end

function lib.checkForOre(value)
	if lib.checkOreTable({turtle.inspectUp()}) then
		lib.up()
		lib.veinMine(lib.up)
	end
	if lib.checkOreTable({turtle.inspectDown()}) then
		lib.down()
		lib.veinMine(lib.down)
	end
	lib.turnLeft()
	if lib.checkOreTable({turtle.inspect()}) then
		lib.forward()
		lib.veinMine(lib.forward)
	end
	lib.turnAround()
	if lib.checkOreTable({turtle.inspect()}) then
		lib.forward()
		lib.veinMine(lib.forward)
	end
	if value == "back_true" then
		lib.turnRight()
		if lib.checkOreTable({turtle.inspect()}) then
			lib.forward()
			lib.veinMine(lib.forward)
		end
		lib.turnAround()
		if lib.checkOreTable({turtle.inspect()}) then
			lib.forward()
			lib.veinMine(lib.forward)
		end
	else
		lib.turnLeft()
		if lib.checkOreTable({turtle.inspect()}) then
			lib.forward()
			lib.veinMine(lib.forward)
		end
	end
	return true
end

function mineSquence(depth, start)
	for i=1, depth do
		lib.down()
		if start - 2 == lib.coords.y then
			if lib.findJunk("minecraft:gravel") then
				turtle.placeUp(lib.slot)
			end
		end
		lib.checkForOre(tostring("back_true"))
		local tbl = {turtle.inspectDown()}
		if tbl[2].name == "minecraft:bedrock" then
			term.clear()
			term.setCursorPos(1,1)
			print("Found bedrock at "..lib.coords.y.." blocks deep,")
			print("returning to the surface!")
			if lib.hasWireless then
				rednet.broadcast("Found bedrock at "..lib.coords.y.." blocks deep,")
				rednet.broadcast("returning to the surface!")
			end
			local y = start - lib.coords.y
			lib.up(y)
			if lib.findJunk("minecraft:gravel") then
				turtle.placeDown(lib.slot)
				return
			end
		elseif start - depth == lib.coords.y then
			local y = start - lib.coords.y
			lib.up(y)
			if lib.findJunk("minecraft:gravel") then
				turtle.placeDown(lib.slot)
				return
			end
		end
		if turtle.getItemCount(16) >= 1 then
			lib.dropJunk()
		end
	end
end

if type(tonumber(tArgs[1])) ~= "number" then
	term.clear()
	term.setCursorPos(1,1)
	error("Define depth down! (Example: '10') [10 blocks down]")
end

local start = lib.copyTable(lib.coords)
lib.saveData("/.save", "/start_pos", start)
mineSquence(tonumber(tArgs[1]), start.y)
lib.moveTo(start.x, start.y, start.z)
lib.drop(lib.maxSlots)
fs.delete("/.save")