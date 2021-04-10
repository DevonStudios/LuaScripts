local pokemon = {
 "NONE", "BULBASAUR", "IVYSAUR", "VENUSAUR", "CHARMANDER", "CHARMELEON", "CHARIZARD", "SQUIRTLE", "WARTORTLE", "BLASTOISE",
 "CATERPIE", "METAPOD", "BUTTERFREE", "WEEDLE", "KAKUNA", "BEEDRILL", "PIDGEY", "PIDGEOTTO", "PIDGEOT", "RATTATA", "RATICATE",
 "SPEAROW", "FEAROW", "EKANS", "ARBOK", "PIKACHU", "RAICHU", "SANDSHREW", "SANDSLASH", "NIDORAN♀", "NIDORINA", "NIDOQUEEN",
 "NIDORAN♂", "NIDORINO", "NIDOKING", "CLEFAIRY", "CLEFABLE", "VULPIX", "NINETALES", "JIGGLYPUFF", "WIGGLYTUFF", "ZUBAT", "GOLBAT",
 "ODDISH", "GLOOM", "VILEPLUME", "PARAS", "PARASECT", "VENONAT", "VENOMOTH", "DIGLETT", "DUGTRIO", "MEOWTH", "PERSIAN", "PSYDUCK",
 "GOLDUCK", "MANKEY", "PRIMEAPE", "GROWLITHE", "ARCANINE", "POLIWAG", "POLIWHIRL", "POLIWRATH", "ABRA", "KADABRA", "ALAKAZAM",
 "MACHOP", "MACHOKE", "MACHAMP", "BELLSPROUT", "WEEPINBELL", "VICTREEBEL", "TENTACOOL", "TENTACRUEL", "GEODUDE", "GRAVELER",
 "GOLEM", "PONYTA", "RAPIDASH", "SLOWPOKE", "SLOWBRO", "MAGNEMITE", "MAGNETON", "FARFETCH'D", "DODUO", "DODRIO", "SEEL", "DEWGONG",
 "GRIMER", "MUK", "SHELLDER", "CLOYSTER", "GASTLY", "HAUNTER", "GENGAR", "ONIX", "DROWZEE", "HYPNO", "KRABBY", "KINGLER", "VOLTORB",
 "ELECTRODE", "EXEGGCUTE", "EXEGGUTOR", "CUBONE", "MAROWAK", "HITMONLEE", "HITMONCHAN", "LICKITUNG", "KOFFING", "WEEZING", "RHYHORN",
 "RHYDON", "CHANSEY", "TANGELA", "KANGASKHAN", "HORSEA", "SEADRA", "GOLDEEN", "SEAKING", "STARYU", "STARMIE", "MR.MIME", "SCYTHER",
 "JYNX", "ELECTABUZZ", "MAGMAR", "PINSIR", "TAUROS", "MAGIKARP", "GYARADOS", "LAPRAS", "DITTO", "EEVEE", "VAPOREON", "JOLTEON",
 "FLAREON", "PORYGON", "OMANYTE", "OMASTAR", "KABUTO", "KABUTOPS", "AERODACTYL", "SNORLAX", "ARTICUNO", "ZAPDOS", "MOLTRES",
 "DRATINI", "DRAGONAIR", "DRAGONITE", "MEWTWO", "MEW", "CHIKORITA", "BAYLEEF", "MEGANIUM", "CYNDAQUIL", "QUILAVA", "TYPHLOSION",
 "TOTODILE", "CROCONAW", "FERALIGATR", "SENTRET", "FURRET", "HOOTHOOT", "NOCTOWL", "LEDYBA", "LEDIAN", "SPINARAK", "ARIADOS", "CROBAT",
 "CHINCHOU", "LANTURN", "PICHU", "CLEFFA", "IGGLYBUFF", "TOGEPI", "TOGETIC", "NATU", "XATU", "MAREEP", "FLAAFFY", "AMPHAROS", "BELLOSSOM",
 "MARILL", "AZUMARILL", "SUDOWOODO", "POLITOED", "HOPPIP", "SKIPLOOM", "JUMPLUFF", "AIPOM", "SUNKERN", "SUNFLORA", "YANMA", "WOOPER",
 "QUAGSIRE", "ESPEON", "UMBREON", "MURKROW", "SLOWKING", "MISDREAVUS", "UNOWN", "WOBBUFFET", "GIRAFARIG", "PINECO", "FORRETRESS",
 "DUNSPARCE", "GLIGAR", "STEELIX", "SNUBBULL", "GRANBULL", "QWILFISH", "SCIZOR", "SHUCKLE", "HERACROSS", "SNEASEL", "TEDDIURSA",
 "URSARING", "SLUGMA", "MAGCARGO", "SWINUB", "PILOSWINE", "CORSOLA", "REMORAID", "OCTILLERY", "DELIBIRD", "MANTINE", "SKARMORY", "HOUNDOUR",
 "HOUNDOOM", "KINGDRA", "PHANPY", "DONPHAN", "PORYGON2", "STANTLER", "SMEARGLE", "TYROGUE", "HITMONTOP", "SMOOCHUM", "ELEKID", "MAGBY",
 "MILTANK", "BLISSEY", "RAIKOU", "ENTEI", "SUICUNE", "LARVITAR", "PUPITAR", "TYRANITAR", "LUGIA", "HO-OH", "CELEBI", "TREECKO", "GROVYLE",
 "SCEPTILE", "TORCHIC", "COMBUSKEN", "BLAZIKEN", "MUDKIP", "MARSHTOMP", "SWAMPERT", "POOCHYENA", "MIGHTYENA", "ZIGZAGOON", "LINOONE",
 "WURMPLE", "SILCOON", "BEAUTIFLY", "CASCOON", "DUSTOX", "LOTAD", "LOMBRE", "LUDICOLO", "SEEDOT", "NUZLEAF", "SHIFTRY", "TAILLOW",
 "SWELLOW", "WINGULL", "PELIPPER", "RALTS", "KIRLIA", "GARDEVOIR", "SURSKIT", "MASQUERAIN", "SHROOMISH", "BRELOOM", "SLAKOTH", "VIGOROTH",
 "SLAKING", "NINCADA", "NINJASK", "SHEDINJA", "WHISMUR", "LOUDRED", "EXPLOUD", "MAKUHITA", "HARIYAMA", "AZURILL", "NOSEPASS", "SKITTY",
 "DELCATTY", "SABLEYE", "MAWILE", "ARON", "LAIRON", "AGGRON", "MEDITITE", "MEDICHAM", "ELECTRIKE", "MANECTRIC", "PLUSLE", "MINUN", "VOLBEAT",
 "ILLUMISE", "ROSELIA", "GULPIN", "SWALOT", "CARVANHA", "SHARPEDO", "WAILMER", "WAILORD", "NUMEL", "CAMERUPT", "TORKOAL", "SPOINK", "GRUMPIG",
 "SPINDA", "TRAPINCH", "VIBRAVA", "FLYGON", "CACNEA", "CACTURNE", "SWABLU", "ALTARIA", "ZANGOOSE", "SEVIPER", "LUNATONE", "SOLROCK", "BARBOACH",
 "WHISCASH", "CORPHISH", "CRAWDAUNT", "BALTOY", "CLAYDOL", "LILEEP", "CRADILY", "ANORITH", "ARMALDO", "FEEBAS", "MILOTIC", "CASTFORM", "KECLEON",
 "SHUPPET", "BANETTE", "DUSKULL", "DUSCLOPS", "TROPIUS", "CHIMECHO", "ABSOL", "WYNAUT", "SNORUNT", "GLALIE", "SPHEAL", "SEALEO", "WALREIN",
 "CLAMPERL", "HUNTAIL", "GOREBYSS", "RELICANTH", "LUVDISC", "BAGON", "SHELGON", "SALAMENCE", "BELDUM", "METANG", "METAGROSS", "REGIROCK", "REGICE",
 "REGISTEEL", "LATIAS", "LATIOS", "KYOGRE", "GROUDON", "RAYQUAZA", "JIRACHI", "DEOXYS"}

local natureName = {
 "Hardy", "Lonely", "Brave", "Adamant", "Naughty",
 "Bold", "Docile", "Relaxed", "Impish", "Lax",
 "Timid", "Hasty", "Serious", "Jolly", "Naive",
 "Modest", "Mild", "Quiet", "Bashful", "Rash",
 "Calm", "Gentle", "Sassy", "Careful", "Quirky"}

local typeOrder = {
 "Fighting", "Flying", "Poison", "Ground",
 "Rock", "Bug", "Ghost", "Steel",
 "Fire", "Water", "Grass", "Electric",
 "Psychic", "Ice", "Dragon", "Dark"}

local nationalDexTable = {
 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26,
 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50,
 51,  52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74,
 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99,
 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119,
 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139,
 140, 141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159,
 160, 161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175, 176, 177, 178, 179,
 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199,
 200, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210, 211, 212, 213, 214, 215, 216, 217, 218, 219,
 220, 221, 222, 223, 224, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234, 235, 236, 237, 238, 239,
 240, 241, 242, 243, 244, 245, 246, 247, 248, 249, 250, 251, 387, 388, 389, 390, 391, 392, 393, 394,
 395, 396, 397, 398, 399, 400, 401, 402, 403, 404, 405, 406, 407, 408, 409, 410, 411, 252, 253, 254,
 255, 256, 257, 258, 259, 260, 261, 262, 263, 264, 265, 266, 267, 268, 269, 270, 271, 272, 273, 274,
 275, 290, 291, 292, 276, 277, 285, 286, 327, 278, 279, 283, 284, 320, 321, 300, 301, 352, 343, 344,
 299, 324, 302, 339, 340, 370, 341, 342, 349, 350, 318, 319, 328, 329, 330, 296, 297, 309, 310, 322,
 323, 363, 364, 365, 331, 332, 361, 362, 337, 338, 298, 325, 326, 311, 312, 303, 307, 308, 333, 334,
 360, 355, 356, 315, 287, 288, 289, 316, 317, 357, 293, 294, 295, 366, 367, 368, 359, 353, 354, 336,
 335, 369, 304, 305, 306, 351, 313, 314, 345, 346, 347, 348, 280, 281, 282, 371, 372, 373, 374, 375,
 376, 377, 378, 379, 382, 383, 384, 380, 381, 385, 386, 358}

local catchRate = {
 -- Gen 1
 0, 45, 45, 45, 45, 45, 45, 45, 45, 45, 255, 120, 90, 255, 120, 90, 255, 120,
 45, 255, 127, 255, 90, 255, 90, 190, 75, 255, 90, 235, 120, 45, 235, 120,
 45, 150, 25, 190, 75, 170, 50, 255, 90, 255, 120, 45, 190, 75, 190, 120,
 255, 100, 255, 90, 190, 120, 190, 80, 190, 75, 255, 120, 90, 200, 100, 50,
 180, 90, 45, 255, 120, 45, 190, 60, 255, 120, 45, 190, 110, 190, 75, 190,
 110, 80, 190, 90, 190, 75, 190, 75, 190, 60, 190, 90, 45, 45, 190, 80, 225,
 60, 190, 60, 90, 80, 190, 110, 90, 90, 90, 190, 60, 120, 100, 70, 90, 90,
 225, 75, 225, 60, 225, 110, 90, 90, 45, 90, 90, 90, 80, 255, 45, 80, 35, 45,
 45, 45, 45, 45, 45, 45, 45, 45, 45, 70, 25, 25, 25, 45, 45, 45, 3, 45,
 -- Gen2
 45, 180, 45, 45, 180, 45, 45, 180, 45, 255, 90, 255, 90, 255, 90, 255, 90,
 90, 190, 75, 190, 150, 170, 190, 45, 190, 75, 235, 120, 45, 45, 190, 75, 65,
 45, 255, 120, 45, 45, 235, 120, 75, 255, 90, 45, 45, 30, 70, 90, 225, 45, 60,
 190, 75, 190, 60, 25, 190, 75, 45, 25, 190, 45, 60, 120, 60, 190, 120, 225,
 75, 60, 190, 75, 45, 90, 15, 225, 45, 45, 120, 60, 45, 45, 45, 75, 45, 45, 45,
 45, 45, 30, 15, 15, 15, 45, 45, 10, 3, 3, 45,
 -- Gen3
 45, 45, 45, 45, 45, 45, 45, 45, 45, 255, 127, 255, 90, 255, 120, 45, 120, 45,
 255, 120, 45, 255, 120, 45, 200, 90, 255, 45, 235, 120, 45, 200, 75, 255, 90,
 255, 120, 45, 255, 120, 45, 190, 120, 45, 255, 200, 150, 255, 255, 120, 90, 120,
 180, 90, 45, 180, 90, 120, 80, 200, 200, 150, 150, 150, 225, 75, 225, 60, 125,
 60, 255, 150, 90, 255, 60, 255, 255, 120, 45, 190, 60, 255, 80, 90, 90, 100, 90,
 190, 75, 205, 155, 255, 90, 45, 45, 45, 45, 255, 60, 45, 200, 225, 90, 190, 90,
 45, 45, 30, 125, 190, 75, 255, 120, 45, 255, 60, 60, 25, 225, 45, 45, 80, 3, 3,
 15, 3, 3, 3, 3, 3, 5, 5, 3, 3, 3}

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

function setPadding(maxLength, goodSpacing, stringVar)
 spaces = ""
 if string.len(stringVar) <= maxLength then
  padding = maxLength - string.len(stringVar)
  for i = 0, padding + goodSpacing do
   spaces = spaces..string.format(" ")
  end
 end
 return spaces
end

function calcRate(HP, bonusBall, rate)
 a = math.floor((HP * rate * bonusBall) / (3 * HP))
 return math.floor(1048560 / math.sqrt(math.sqrt(16711680 / a)))
end

function setInfo(start, partyStart, boxStart, i)
 pid = ReadValue32(start)
 speciesAddr = start - 0x4
 index = nationalDexTable[ReadValue16(speciesAddr) + 1] + 1
 species = pokemon[index]
 species = species..setPadding(10, 5, species)
 nature = natureName[(pid % 25) + 1]
 nature = nature..setPadding(7, 9, nature)
 catchValue = calcRate(ReadValue16(start + 0x86), 1, catchRate[index])

 ivsAddr = start + 0xA1
 hpiv = ReadValue8(ivsAddr)
 atkiv = ReadValue8(ivsAddr + 0x2)
 defiv = ReadValue8(ivsAddr + 0x4)
 spatkiv = ReadValue8(ivsAddr + 0x8)
 spdefiv = ReadValue8(ivsAddr + 0x6)
 spdiv = ReadValue8(ivsAddr + 0xA)

 hidpowtype = ((hpiv%2 + 2*(atkiv%2) + 4*(defiv%2) + 8*(spdiv%2) + 16*(spdefiv%2) + 32*(spatkiv%2))*15) // 63
 hidpowbase = (((hpiv&2)/2 + (atkiv&2) + 2*(defiv&2) + 4*(spdiv&2) + 8*(spdefiv&2) + 16*(spatkiv&2))*40) // 63 + 30

 partyPid = ReadValue32(partyStart)
 partySpeciesAddr = partyStart - 0x4
 partyIndex = nationalDexTable[ReadValue16(partySpeciesAddr) + 1] + 1
 partySpecies = pokemon[partyIndex]
 partySpecies = partySpecies..setPadding(10, 5, partySpecies)
 partyNature = natureName[(partyPid % 25) + 1]
 partyNature = partyNature..setPadding(7, 9, partyNature)

 partyIvsAddr = partyStart + 0xA1
 partyHpiv = ReadValue8(partyIvsAddr)
 partyAtkiv = ReadValue8(partyIvsAddr + 0x2)
 partyDefiv = ReadValue8(partyIvsAddr + 0x4)
 partySpatkiv = ReadValue8(partyIvsAddr + 0x8)
 partySpdefiv = ReadValue8(partyIvsAddr + 0x6)
 partySpdiv = ReadValue8(partyIvsAddr + 0xA)

 partyHidpowtype = ((partyHpiv%2 + 2*(partyAtkiv%2) + 4*(partyDefiv%2) + 8*(partySpdiv%2) + 16*(partySpdefiv%2) + 32*(partySpatkiv%2))*15) // 63
 partyHidpowbase = (((partyHpiv&2)/2 + (partyAtkiv&2) + 2*(partyDefiv&2) + 4*(partySpdiv&2) + 8*(partySpdefiv&2) + 16*(partySpatkiv&2))*40) // 63 + 30

 if i == 0 then
  boxPid = ReadValue32(boxStart)
  boxSpeciesAddr = boxStart - 0x4
  boxIndex = nationalDexTable[ReadValue16(boxSpeciesAddr) + 1] + 1
  boxSpecies = pokemon[boxIndex]
  boxNature = natureName[(boxPid % 25)+1]

  boxIvsAddr = boxStart + 0xA1
  boxHpiv = ReadValue8(boxIvsAddr)
  boxAtkiv = ReadValue8(boxIvsAddr + 0x2)
  boxDefiv = ReadValue8(boxIvsAddr + 0x4)
  boxSpatkiv = ReadValue8(boxIvsAddr + 0x8)
  boxSpdefiv = ReadValue8(boxIvsAddr + 0x6)
  boxSpdiv = ReadValue8(boxIvsAddr + 0xA)

  boxHidpowtype = ((boxHpiv%2 + 2*(boxAtkiv%2) + 4*(boxDefiv%2) + 8*(boxSpdiv%2) + 16*(boxSpdefiv%2) + 32*(boxSpatkiv%2))*15) // 63
  boxHidpowbase = (((boxHpiv&2)/2 + (boxAtkiv&2) + 2*(boxDefiv&2) + 4*(boxSpdiv&2) + 8*(boxSpdefiv&2) + 16*(boxSpatkiv&2))*40) // 63 + 30

  speciesText = string.format("Species: %sSpecies: %sSpecies: %s", species, partySpecies, boxSpecies)
  PIDs = string.format("\nPID: %08X            PID: %08X            PID: %08X", pid, partyPid, boxPid)
  naturesText = string.format("\nNature: %sNature: %sNature: %s", nature, partyNature, boxNature)
  ivs = string.format("\nIVs: %02d/%02d/%02d/%02d/%02d/%02d   IVs: %02d/%02d/%02d/%02d/%02d/%02d   IVs: %02d/%02d/%02d/%02d/%02d/%02d", hpiv, atkiv, defiv, spdefiv, spatkiv, spdiv, partyHpiv, partyAtkiv, partyDefiv, partySpdefiv, partySpatkiv, partySpdiv, boxHpiv, boxAtkiv, boxDefiv, boxSpdefiv, boxSpatkiv, boxSpdiv)
  hiddenPower = string.format("\nHP: %s %02d", typeOrder[hidpowtype + 1], hidpowbase)..setPadding(11, 9, string.format("%s %02d", typeOrder[hidpowtype + 1], hidpowbase))..string.format("HP: %s %02d", typeOrder[partyHidpowtype + 1], partyHidpowbase)..setPadding(11, 9, string.format("%s %02d", typeOrder[partyHidpowtype + 1], partyHidpowbase))..string.format("HP: %s %02d", typeOrder[boxHidpowtype + 1], boxHidpowbase)
  catchRngText = string.format("\nCatch Rate Value: %.0f", catchValue)
  infoText = speciesText..PIDs..naturesText..ivs..hiddenPower..catchRngText
 else
  speciesText = string.format("Species: %sSpecies: %s", species, partySpecies)
  PIDs = string.format("\nPID: %08X            PID: %08X", pid, partyPid)
  naturesText = string.format("\nNature: %sNature: %s", nature, partyNature)
  ivs = string.format("\nIVs: %02d/%02d/%02d/%02d/%02d/%02d   IVs: %02d/%02d/%02d/%02d/%02d/%02d", hpiv, atkiv, defiv, spdefiv, spatkiv, spdiv, partyHpiv, partyAtkiv, partyDefiv, partySpdefiv, partySpatkiv, partySpdiv)
  hiddenPower = string.format("\nHP: %s %02d", typeOrder[hidpowtype + 1], hidpowbase)..setPadding(11, 9, string.format("%s %02d", typeOrder[hidpowtype + 1], hidpowbase))..string.format("HP: %s %02d", typeOrder[partyHidpowtype + 1], partyHidpowbase)
  catchRngText = string.format("\nCatch Rate Value: %.0f", catchValue)
  infoText = speciesText..PIDs..naturesText..ivs..hiddenPower..catchRngText
 end
 return infoText
end

function claclFrameJump()
 calibrationFrame = 0
 if tempSeed ~= currSeed then
  tempSeed2 = tempSeed
  while tempSeed ~= currSeed and tempSeed2 ~= currSeed do
   tempSeed = next(tempSeed)
   tempSeed2 = back(tempSeed2)
   calibrationFrame = calibrationFrame + 1
  end

  if tempSeed2 == currSeed and tempSeed2 ~= tempSeed then
   calibrationFrame = (-1) * calibrationFrame
   tempSeed = tempSeed2
  end
 end
 return calibrationFrame
end

function onScriptStart()
 if ReadValue32(0x0) == 0x4743364A then -- J
  IDsOff = 0
  startOff = 0
  boxOff = 0
  boxAddrOff = 0
  boxCheckOff = 0
  ex = 0x30823069
  it = 0x308B0000
  seedOff = 0
 elseif ReadValue32(0x0) == 0x47433645 then -- U
  IDsOff = 0x91D44
  startOff = 0x14920
  boxOff = 0x13930
  boxAddrOff = 0x14950
  boxCheckOff = 0x7834F
  ex = 0x45007800
  it = 0x69007400
  seedOff = 0x14930
 else
  IDsOff = 0x1AE278
  startOff = 0x61DB8
  boxOff = 0x60DB0
  boxAddrOff = 0x61E00
  boxCheckOff = 0x1E3388
  ex = 0x45005300
  it = 0x43004900
  seedOff = 0x61DD0
 end

 start = 0x45E750 + startOff
 seedAddr = 0x464360 + seedOff
 boxNormalStart = 0x395CBC + boxOff
 boxFirstPos = 0x466468 + boxAddrOff
 info = "\n\n"
 TID = 0
 SID = 0
 initSeed = 0
 currSeed = 0
 tempSeed = 0
 frame = 0
 boxStart = 0
end

function onScriptUpdate()
 IDsPointer = ReadValue32(0x75E088 + IDsOff)

 if IDsPointer ~= 0 then
  TID = ReadValue16(IDsPointer + 0x7FFE42E2)
  SID = ReadValue16(IDsPointer + 0x7FFE42E0)
  partyStart = IDsPointer + 0x7FFE42E8

  if ReadValue32(0x9E00B4 + boxCheckOff) == ex and ReadValue32(0x9E00B8 + boxCheckOff) == it then
   boxStart = boxNormalStart
  else
   boxStart = ReadValue32(boxFirstPos) + 0xBA0
  end

  info = string.format("\n\nOpponent                 Party                    Box\n\n")

  for i = 0, 5 do
   info = info..setInfo(start + (0x138 * i), partyStart + (0x138 * i), boxStart, i).."\n\n"
  end
 end

 if ReadValue32(seedAddr) > 0xFFFF and initSeed == 0 then
  initSeed = ReadValue32(seedAddr)
  tempSeed = initSeed
  frame = 0
 end

 currSeed = ReadValue32(seedAddr)
 frame = frame + claclFrameJump()

 RNGInfo = string.format("Initial Seed: %08X\nCurrent Seed: %08X\nFrame: %d", initSeed, currSeed, frame)
 IDs = string.format("\n\n\nTID: %05d\nSID: %05d", TID, SID)
 text = RNGInfo..info..IDs
 SetScreenText(text)
end

function onScriptCancel()
 SetScreenText("")
end

function onStateLoaded()

end

function onStateSaved()

end