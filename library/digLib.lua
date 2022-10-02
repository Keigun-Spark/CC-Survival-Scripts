local move = require("library/moveLib")

local dig = {}

local stack = {}

local inverter = {
	["forward"] = move.backward,
	["back"] = move.forward,
	["turnLeft"] = move.turnRight,
	["turnRight"] = move.turnLeft,
	["up"] = move.down,
	["down"] = move.up,
}

local converter = {
	["forward"] = move.forward,
	["back"] = move.backward,
	["turnLeft"] = move.turnLeft,
	["turnRight"] = move.turnRight,
	["up"] = move.up,
	["down"] = move.down,
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

function dig.stackPop()
	local func = inverter[stack[#stack]]
	table.remove(stack)
	return func()
end

function dig.checkOreTable(tbl)
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

function dig.veinMine(lastFunc)
	if type(lastFunc) == "function" or "string" then
		if type(lastFunc) == "function" then
			for k,v in pairs(converter) do
				if v == lastFunc then
					table.insert(stack, k)
					break
				end
			end
		end
		if dig.checkOreTable({turtle.inspectUp()}) then
			move.up()
			return dig.veinMine(move.up)
		elseif dig.checkOreTable({turtle.inspectDown()}) then
			move.down()
			return dig.veinMine(move.down)
		end
		for i=1, 4 do
			if dig.checkOreTable({turtle.inspect()}) then
				if i == 1 then
					move.forward()
					return dig.veinMine(move.forward)
				elseif i == 2 then
					return dig.veinMine(move.turnLeft)
				elseif i == 3 then
					table.insert(stack, "turnLeft")
					return dig.veinMine(move.turnLeft)
				elseif i == 4 then
					return dig.veinMine(move.turnRight)
				end
			end
			move.turnLeft()
		end
		if stack[#stack] == "turnLeft" then
			if stack[#stack] == stack[#stack-1] then
				dig.stackPop()
				dig.stackPop()
				lastFunc = stack[#stack]
				if #stack > 0 then
					return dig.veinMine(lastFunc)
				end
				return
			else
				dig.stackPop()
				lastFunc = stack[#stack]
				if #stack > 0 then
					return dig.veinMine(lastFunc)
				end
				return
			end
		else
			dig.stackPop()
			lastFunc = stack[#stack]
			if #stack > 0 then
				return dig.veinMine(lastFunc)
			end
			return
		end
	else
		error("'lastFunc' is not of type function or string", 2)
	end
end

function dig.checkForOre(value)
	if dig.checkOreTable({turtle.inspectUp()}) then
		move.up()
		dig.veinMine(move.up)
	end
	if dig.checkOreTable({turtle.inspectDown()}) then
		move.down()
		dig.veinMine(move.down)
	end
	move.turnLeft()
	if dig.checkOreTable({turtle.inspect()}) then
		move.forward()
		dig.veinMine(move.forward)
	end
	move.turnAround()
	if dig.checkOreTable({turtle.inspect()}) then
		move.forward()
		dig.veinMine(move.forward)
	end
	if value == "back_true" then
		move.turnRight()
		if dig.checkOreTable({turtle.inspect()}) then
			move.forward()
			dig.veinMine(move.forward)
		end
		move.turnAround()
		if dig.checkOreTable({turtle.inspect()}) then
			move.forward()
			dig.veinMine(move.forward)
		end
	else
		move.turnLeft()
		if dig.checkOreTable({turtle.inspect()}) then
			move.forward()
			dig.veinMine(move.forward)
		end
	end
	return true
end

return dig
