local pokemon = {
 "NONE", "BULBASAUR", "IVYSAUR", "VENUSAUR", "CHARMANDER", "CHARMELEON", "CHARIZARD", "SQUIRTLE", "WARTORTLE", "BLASTOISE",
"CATERPIE", "METAPOD", "BUTTERFREE", "WEEDLE", "KAKUNA", "BEEDRILL", "PIDGEY", "PIDGEOTTO", "PIDGEOT", "RATTATA", "RATICATE",
"SPEAROW", "FEAROW", "EKANS", "ARBOK", "PIKACHU", "RAICHU", "SANDSHREW", "SANDSLASH", "NIDORANF", "NIDORINA", "NIDOQUEEN",
"NIDORANM", "NIDORINO", "NIDOKING", "CLEFAIRY", "CLEFABLE", "VULPIX", "NINETALES", "JIGGLYPUFF", "WIGGLYTUFF", "ZUBAT", "GOLBAT",
"ODDISH", "GLOOM", "VILEPLUME", "PARAS", "PARASECT", "VENONAT", "VENOMOTH", "DIGLETT", "DUGTRIO", "MEOWTH", "PERSIAN", "PSYDUCK",
"GOLDUCK", "MANKEY", "PRIMEAPE", "GROWLITHE", "ARCANINE", "POLIWAG", "POLIWHIRL", "POLIWRATH", "ABRA", "KADABRA", "ALAKAZAM",
"MACHOP", "MACHOKE", "MACHAMP", "BELLSPROUT", "WEEPINBELL", "VICTREEBEL", "TENTACOOL", "TENTACRUEL", "GEODUDE", "GRAVELER",
"GOLEM", "PONYTA", "RAPIDASH", "SLOWPOKE", "SLOWBRO", "MAGNEMITE", "MAGNETON", "FARFETCHED", "DODUO", "DODRIO", "SEEL","DEWGONG",
"GRIMER", "MUK", "SHELLDER", "CLOYSTER", "GASTLY", "HAUNTER", "GENGAR", "ONIX", "DROWZEE", "HYPNO", "KRABBY", "KINGLER", "VOLTORB",
"ELECTRODE", "EXEGGCUTE", "EXEGGUTOR", "CUBONE", "MAROWAK", "HITMONLEE", "HITMONCHAN", "LICKITUNG", "KOFFING", "WEEZING", "RHYHORN",
"RHYDON", "CHANSEY", "TANGELA", "KANGASKHAN", "HORSEA", "SEADRA", "GOLDEEN", "SEAKING", "STARYU", "STARMIE", "MRMIME", "SCYTHER",
"JYNX", "ELECTABUZZ", "MAGMAR", "PINSIR", "TAUROS", "MAGIKARP", "GYARADOS", "LAPRAS", "DITTO", "EEVEE", "VAPOREON", "JOLTEON",
"FLAREON", "PORYGON", "OMANYTE", "OMASTAR", "KABUTO", "KABUTOPS", "AERODACTYL", "SNORLAX", "ARTICUNO", "ZAPDOS", "MOLTRES",
"DRATINI", "DRAGONAIR", "DRAGONITE", "MEWTWO", "MEW", "CHIKORITA", "BAYLEEF", "MEGANIUM", "CYNDAQUIL", "QUILAVA", "TYPHLOSION",
"TOTODILE", "CROCONAW", "FERALIGATR", "SENTRET", "FURRET", "HOOTHOOT", "NOCTOWL", "LEDYBA", "LEDIAN", "SPINARAK", "ARIADOS",
"CROBAT", "CHINCHOU", "LANTURN", "PICHU", "CLEFFA", "IGGLYBUFF", "TOGEPI", "TOGETIC", "NATU", "XATU", "MAREEP", "FLAAFFY",
"AMPHAROS", "BELLOSSOM", "MARILL", "AZUMARILL", "SUDOWOODO", "POLITOED", "HOPPIP", "SKIPLOOM", "JUMPLUFF", "AIPOM", "SUNKERN",
"SUNFLORA", "YANMA", "WOOPER", "QUAGSIRE", "ESPEON", "UMBREON", "MURKROW", "SLOWKING", "MISDREAVUS", "UNOWN", "WOBBUFFET",
"GIRAFARIG", "PINECO", "FORRETRESS", "DUNSPARCE", "GLIGAR", "STEELIX", "SNUBBULL", "GRANBULL", "QWILFISH", "SCIZOR", "SHUCKLE",
"HERACROSS", "SNEASEL", "TEDDIURSA", "URSARING", "SLUGMA", "MAGCARGO", "SWINUB", "PILOSWINE", "CORSOLA", "REMORAID", "OCTILLERY",
"DELIBIRD", "MANTINE", "SKARMORY", "HOUNDOUR", "HOUNDOOM", "KINGDRA", "PHANPY", "DONPHAN", "PORYGON", "STANTLER", "SMEARGLE",
"TYROGUE", "HITMONTOP", "SMOOCHUM", "ELEKID", "MAGBY", "MILTANK", "BLISSEY", "RAIKOU", "ENTEI", "SUICUNE", "LARVITAR", "PUPITAR",
"TYRANITAR", "LUGIA", "HOOH", "CELEBI", "TREECKO", "GROVYLE", "SCEPTILE", "TORCHIC", "COMBUSKEN", "BLAZIKEN", "MUDKIP", "MARSHTOMP",
"SWAMPERT", "POOCHYENA", "MIGHTYENA", "ZIGZAGOON", "LINOONE", "WURMPLE", "SILCOON", "BEAUTIFLY", "CASCOON", "DUSTOX", "LOTAD",
"LOMBRE", "LUDICOLO", "SEEDOT", "NUZLEAF", "SHIFTRY", "NINCADA", "NINJASK", "SHEDINJA", "TAILLOW", "SWELLOW", "SHROOMISH",
"BRELOOM", "SPINDA", "WINGULL", "PELIPPER", "SURSKIT", "MASQUERAIN", "WAILMER", "WAILORD", "SKITTY", "DELCATTY", "KECLEON", "BALTOY",
"CLAYDOL", "NOSEPASS", "TORKOAL", "SABLEYE", "BARBOACH", "WHISCASH", "LUVDISC", "CORPHISH", "CRAWDAUNT", "FEEBAS", "MILOTIC",
"CARVANHA", "SHARPEDO", "TRAPINCH", "VIBRAVA", "FLYGON", "MAKUHITA", "HARIYAMA", "ELECTRIKE", "MANECTRIC", "NUMEL", "CAMERUPT",
"SPHEAL", "SEALEO", "WALREIN", "CACNEA", "CACTURNE", "SNORUNT", "GLALIE", "LUNATONE", "SOLROCK", "AZURILL", "SPOINK", "GRUMPIG",
"PLUSLE", "MINUN", "MAWILE", "MEDITITE", "MEDICHAM", "SWABLU", "ALTARIA", "WYNAUT", "DUSKULL", "DUSCLOPS", "ROSELIA", "SLAKOTH",
"VIGOROTH", "SLAKING", "GULPIN", "SWALOT", "TROPIUS", "WHISMUR", "LOUDRED", "EXPLOUD", "CLAMPERL", "HUNTAIL", "GOREBYSS", "ABSOL",
"SHUPPET", "BANETTE", "SEVIPER", "ZANGOOSE", "RELICANTH", "ARON", "LAIRON", "AGGRON", "CASTFORM", "VOLBEAT", "ILLUMISE", "LILEEP",
"CRADILY", "ANORITH", "ARMALDO", "RALTS", "KIRLIA", "GARDEVOIR", "BAGON", "SHELGON", "SALAMENCE", "BELDUM", "METANG", "METAGROSS",
"REGIROCK", "REGICE", "REGISTEEL", "KYOGRE", "GROUDON", "RAYQUAZA", "LATIAS", "LATIOS", "JIRACHI", "DEOXYS", "CHIMECHO"}

local naturename = {
 "Hardy", "Lonely", "Brave", "Adamant", "Naughty",
 "Bold", "Docile", "Relaxed", "Impish", "Lax",
 "Timid", "Hasty", "Serious", "Jolly", "Naive",
 "Modest", "Mild", "Quiet", "Bashful", "Rash",
 "Calm", "Gentle", "Sassy", "Careful", "Quirky"}

function next(s)
	local a = 0x3 * (s % 65536) + (s >> 16) * 0x43FD
	local b = 0x43FD * (s % 65536) + (a % 65536) * 65536 + 0x269EC3
	local c = b % 4294967296
	return c
end

function back(s)
	local a = 0xB9B3 * (s % 65536) + (s >> 16) * 0x3155
	local b = 0x3155 * (s % 65536) + (a % 65536) * 65536 + 0xA170F641
	local c = b % 4294967296
	return c
end

--[[function getSpecies(speciesAddr) -- Read Pokemon names from RAM. Useful for EUR/USA version only
	addr = speciesAddr
	name = ""
	for i = 1, 22 do
		if ReadValue8(addr) ~= 0 then
			name = name..string.char(ReadValue8(addr))
		end
		addr = addr + 0x1
	end

	if name == "" then
		name = "NONE"
	end

	if string.len(name) <= 10 then
		padding = 10 - string.len(name)
		for i = 0, padding + 5 do
			name = name..string.format(" ")
		end
	end

	return name
end]]

function setInfo(start, partyStart, boxStart, i)
	pid = ReadValue32(start)
	speciesAddr = start - 0x4
	index = ReadValue16(speciesAddr) + 1

	if index > 252 then
		index = index - 25
	end

	species = pokemon[index]

	if string.len(species) <= 10 then
		padding = 10 - string.len(species)
		for i = 0, padding + 5 do
			species = species..string.format(" ")
		end
	end

	nature = naturename[(pid % 25) + 1]

	if string.len(nature) <= 7 then
		padding = 7 - string.len(nature)
		for i = 0, padding + 9 do
			nature = nature..string.format(" ")
		end
	end

	ivsAddr = start + 0xA1
	hpiv = ReadValue8(ivsAddr)
	atkiv = ReadValue8(ivsAddr + 0x2)
	defiv = ReadValue8(ivsAddr + 0x4)
	spdefiv = ReadValue8(ivsAddr + 0x6)
    spatkiv = ReadValue8(ivsAddr + 0x8)
	spdiv = ReadValue8(ivsAddr + 0xA)

	partyPid = ReadValue32(partyStart)
	partySpeciesAddr = partyStart - 0x4
	index = ReadValue16(partySpeciesAddr) + 1

	if index > 252 then
		index = index - 25
	end

	partySpecies = pokemon[index]

	if string.len(partySpecies) <= 10 then
		padding = 10 - string.len(partySpecies)
		for i = 0, padding + 5 do
			partySpecies = partySpecies..string.format(" ")
		end
	end

	partyNature = naturename[(partyPid % 25) + 1]

	if string.len(partyNature) <= 7 then
		padding = 7 - string.len(partyNature)
		for i = 0, padding + 9 do
			partyNature = partyNature..string.format(" ")
		end
	end

	partyIvsAddr = partyStart + 0xA1
	partyHpiv = ReadValue8(partyIvsAddr)
	partyAtkiv = ReadValue8(partyIvsAddr + 0x2)
	partyDefiv = ReadValue8(partyIvsAddr + 0x4)
	partySpdefiv = ReadValue8(partyIvsAddr + 0x6)
    partySpatkiv = ReadValue8(partyIvsAddr + 0x8)
	partySpdiv = ReadValue8(partyIvsAddr + 0xA)

	if i == 0 then
		boxPid = ReadValue32(boxStart)
		boxSpeciesAddr = boxStart - 0x4
		index = ReadValue16(boxSpeciesAddr) + 1

		if index > 252 then
			index = index - 25
		end

		boxSpecies = pokemon[index]
		boxNature = naturename[(boxPid % 25)+1]
		boxIvsAddr = boxStart + 0xA1
		boxHpiv = ReadValue8(boxIvsAddr)
		boxAtkiv = ReadValue8(boxIvsAddr + 0x2)
		boxDefiv = ReadValue8(boxIvsAddr + 0x4)
		boxSpdefiv = ReadValue8(boxIvsAddr + 0x6)
		boxSpatkiv = ReadValue8(boxIvsAddr + 0x8)
		boxSpdiv = ReadValue8(boxIvsAddr + 0xA)
		
		infoText = string.format("Species: ")..species..string.format("Species: ")..partySpecies..string.format("Species: ")..boxSpecies..string.format("\nPID: %08X", pid)..string.format("            PID: %08X", partyPid)..string.format("            PID: %08X", boxPid)..string.format("\nNature: ")..nature..string.format("Nature: ")..partyNature..string.format("Nature: ")..boxNature..string.format("\nIVs: %02d", hpiv)..string.format("/%02d", atkiv)..string.format("/%02d", defiv)..string.format("/%02d", spdefiv)..string.format("/%02d", spatkiv)..string.format("/%02d", spdiv)..string.format("   IVs: %02d", partyHpiv)..string.format("/%02d", partyAtkiv)..string.format("/%02d", partyDefiv)..string.format("/%02d", partySpdefiv)..string.format("/%02d", partySpatkiv)..string.format("/%02d", partySpdiv)..string.format("   IVs: %02d", boxHpiv)..string.format("/%02d", boxAtkiv)..string.format("/%02d", boxDefiv)..string.format("/%02d", boxSpdefiv)..string.format("/%02d", boxSpatkiv)..string.format("/%02d", boxSpdiv)
	else
		infoText = string.format("Species: ")..species..string.format("Species: ")..partySpecies..string.format("\nPID: %08X", pid)..string.format("            PID: %08X", partyPid)..string.format("\nNature: ")..nature..string.format("Nature: ")..partyNature..string.format("\nIVs: %02d", hpiv)..string.format("/%02d", atkiv)..string.format("/%02d", defiv)..string.format("/%02d", spdefiv)..string.format("/%02d", spatkiv)..string.format("/%02d", spdiv)..string.format("   IVs: %02d", partyHpiv)..string.format("/%02d", partyAtkiv)..string.format("/%02d", partyDefiv)..string.format("/%02d", partySpdefiv)..string.format("/%02d", partySpatkiv)..string.format("/%02d", partySpdiv)
	end

	return infoText
end

function onScriptStart()
	if ReadValue32(0x0) == 0x4743364A then -- J
		IDsOff = 0
		startOff = 0
		boxOff = 0
		seedOff = 0
	elseif ReadValue32(0x0) == 0x47433645 then -- U
		IDsOff = 0x91D44
		startOff = 0x14920
		boxOff = 0x13930
		seedOff = 0x14930
	else
		IDsOff = 0x1AE278
		startOff = 0x61DB8
		boxOff = 0x60DB0
		seedOff = 0x61DD0
	end

	start = 0x45E750 + startOff
	seedAddrs = 0xa49c8c --[[0x464360 + seedOff]]
	boxStart = 0x395CBC + boxOff
	info = "\n\n"
	TID = 0
	SID = 0
	initialSeed = 0
	tempSeed = 0
	tempSeed2 = 0
	frame = 0
end

function onScriptUpdate()
	--IDsPointer = ReadValue32(0x75E088 + IDsOff)

	--[[if IDsPointer ~= 0 then
		TID = ReadValue16(IDsPointer + 0x7FFE42E2)
		SID = ReadValue16(IDsPointer + 0x7FFE42E0)
		partyStart = IDsPointer + 0x7FFE42E8
		info = string.format("\n\nOpponent")..string.format("                 Party")..string.format("                    Box\n\n")
	
		for i = 0, 5 do
			info = info..setInfo(start + (0x138 * i), partyStart + (0x138 * i), boxStart, i).."\n\n"
		end
	end]]

	if ReadValue32(seedAddrs) > 0xFFFF and initialSeed == 0 then
		initialSeed = ReadValue32(seedAddrs)
		tempSeed = initialSeed
		frame = 0
		calib = 0
	end

	currSeed = ReadValue32(seedAddrs)
	if tempSeed ~= currSeed then
		tempSeed2 = tempSeed
		calib = 0
		while tempSeed ~= currSeed and tempSeed2 ~= currSeed do
			tempSeed = next(tempSeed)
			tempSeed2 = back(tempSeed2)
			calib = calib + 1
		end

		if tempSeed2 == currSeed and tempSeed2 ~= tempSeed then
			calib = (-1) * calib
			tempSeed = tempSeed2
		end
		
		frame = frame + calib
	end

	text = string.format("Initial Seed: %08X", initialSeed)..string.format("\nCurrent Seed: %08X", currSeed)..string.format("\nFrame: %d", frame)--[[..info..string.format("\n\n\nTID: %05d", TID)..string.format("\nSID: %05d", SID)]]
	SetScreenText(text)
end

function onScriptCancel()
	SetScreenText("")
end

function onStateLoaded()

end

function onStateSaved()

end