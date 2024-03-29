read32Bit = ReadValue32
read16Bit = ReadValue16
read8Bit = ReadValue8

local natureNamesList = {
 "Hardy", "Lonely", "Brave", "Adamant", "Naughty",
 "Bold", "Docile", "Relaxed", "Impish", "Lax",
 "Timid", "Hasty", "Serious", "Jolly", "Naive",
 "Modest", "Mild", "Quiet", "Bashful", "Rash",
 "Calm", "Gentle", "Sassy", "Careful", "Quirky"}

local HPTypeNamesList = {
 "Fighting", "Flying", "Poison", "Ground",
 "Rock", "Bug", "Ghost", "Steel",
 "Fire", "Water", "Grass", "Electric",
 "Psychic", "Ice", "Dragon", "Dark"}

local speciesNamesList = {
 -- Gen 1
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
 "DRATINI", "DRAGONAIR", "DRAGONITE", "MEWTWO", "MEW",
 -- Gen 2
 "CHIKORITA", "BAYLEEF", "MEGANIUM", "CYNDAQUIL", "QUILAVA", "TYPHLOSION",
 "TOTODILE", "CROCONAW", "FERALIGATR", "SENTRET", "FURRET", "HOOTHOOT", "NOCTOWL", "LEDYBA", "LEDIAN", "SPINARAK", "ARIADOS", "CROBAT",
 "CHINCHOU", "LANTURN", "PICHU", "CLEFFA", "IGGLYBUFF", "TOGEPI", "TOGETIC", "NATU", "XATU", "MAREEP", "FLAAFFY", "AMPHAROS", "BELLOSSOM",
 "MARILL", "AZUMARILL", "SUDOWOODO", "POLITOED", "HOPPIP", "SKIPLOOM", "JUMPLUFF", "AIPOM", "SUNKERN", "SUNFLORA", "YANMA", "WOOPER",
 "QUAGSIRE", "ESPEON", "UMBREON", "MURKROW", "SLOWKING", "MISDREAVUS", "UNOWN", "WOBBUFFET", "GIRAFARIG", "PINECO", "FORRETRESS",
 "DUNSPARCE", "GLIGAR", "STEELIX", "SNUBBULL", "GRANBULL", "QWILFISH", "SCIZOR", "SHUCKLE", "HERACROSS", "SNEASEL", "TEDDIURSA",
 "URSARING", "SLUGMA", "MAGCARGO", "SWINUB", "PILOSWINE", "CORSOLA", "REMORAID", "OCTILLERY", "DELIBIRD", "MANTINE", "SKARMORY", "HOUNDOUR",
 "HOUNDOOM", "KINGDRA", "PHANPY", "DONPHAN", "PORYGON2", "STANTLER", "SMEARGLE", "TYROGUE", "HITMONTOP", "SMOOCHUM", "ELEKID", "MAGBY",
 "MILTANK", "BLISSEY", "RAIKOU", "ENTEI", "SUICUNE", "LARVITAR", "PUPITAR", "TYRANITAR", "LUGIA", "HO-OH", "CELEBI",
 -- Gen 3
 "TREECKO", "GROVYLE",
 "SCEPTILE", "TORCHIC", "COMBUSKEN", "BLAZIKEN", "MUDKIP", "MARSHTOMP", "SWAMPERT", "POOCHYENA", "MIGHTYENA", "ZIGZAGOON", "LINOONE",
 "WURMPLE", "SILCOON", "BEAUTIFLY", "CASCOON", "DUSTOX", "LOTAD", "LOMBRE", "LUDICOLO", "SEEDOT", "NUZLEAF", "SHIFTRY", "TAILLOW",
 "SWELLOW", "WINGULL", "PELIPPER", "RALTS", "KIRLIA", "GARDEVOIR", "SURSKIT", "MASQUERAIN", "SHROOMISH", "BRELOOM", "SLAKOTH", "VIGOROTH",
 "SLAKING", "NINCADA", "NINJASK", "SHEDINJA", "WHISMUR", "LOUDRED", "EXPLOUD", "MAKUHITA", "HARIYAMA", "AZURILL", "NOSEPASS", "SKITTY",
 "DELCATTY", "SABLEYE", "MAWILE", "ARON", "LAIRON", "AGGRON", "MEDITITE", "MEDICHAM", "ELECTRIKE", "MANECTRIC", "PLUSLE", "MINUN", "VOLBEAT",
 "ILLUMISE", "ROSELIA", "GULPIN", "SWALOT", "CARVANHA", "SHARPEDO", "WAILMER", "WAILORD", "NUMEL", "CAMERUPT", "TORKOAL", "SPOINK", "GRUMPIG",
 "SPINDA", "TRAPINCH", "VIBRAVA", "FLYGON", "CACNEA", "CACTURNE", "SWABLU", "ALTARIA", "ZANGOOSE", "SEVIPER", "LUNATONE", "SOLROCK",
 "BARBOACH", "WHISCASH", "CORPHISH", "CRAWDAUNT", "BALTOY", "CLAYDOL", "LILEEP", "CRADILY", "ANORITH", "ARMALDO", "FEEBAS", "MILOTIC",
 "CASTFORM", "KECLEON", "SHUPPET", "BANETTE", "DUSKULL", "DUSCLOPS", "TROPIUS", "CHIMECHO", "ABSOL", "WYNAUT", "SNORUNT", "GLALIE", "SPHEAL",
 "SEALEO", "WALREIN", "CLAMPERL", "HUNTAIL", "GOREBYSS", "RELICANTH", "LUVDISC", "BAGON", "SHELGON", "SALAMENCE", "BELDUM", "METANG",
 "METAGROSS", "REGIROCK", "REGICE", "REGISTEEL", "LATIAS", "LATIOS", "KYOGRE", "GROUDON", "RAYQUAZA", "JIRACHI", "DEOXYS"}

local nationalDexList = {
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

function setPadding(maxLength, goodSpacing, stringVar)
 local spaces = ""
 local stringVarLength = string.len(stringVar)
 local padding

 if stringVarLength <= maxLength then
  padding = maxLength - stringVarLength

  for i = 0, padding + goodSpacing do
   spaces = spaces.." "
  end
 end

 return spaces
end

function shinyCheck(highPID, lowPID, trainerID, trainerSID)
 local shinyType = trainerID ~ trainerSID ~ highPID ~ lowPID

 if shinyType == 0 then
  return "(Square)"
 elseif shinyType < 8 then
  return "(Star)  "
 else
  return "        "
 end
end

function getHeartGaugeStepsCounte(index)
 return 257 - read16Bit(heartGaugeStepsCounterAddr + ((index - 1) * 12))
end

function setInfo(partyAddr, breedingAddr, i)
 local partyPID = read32Bit(partyAddr)
 local partyOTID = read16Bit(partyAddr + 0x12)
 local partyOTSID = read16Bit(partyAddr + 0x10)
 local partySpeciesDexIndex = read16Bit(partyAddr - 0x4)
 local partySpeciesDexNumber = nationalDexList[partySpeciesDexIndex + 1] + 1
 local partySpeciesName = speciesNamesList[partySpeciesDexNumber]
 partySpeciesName = partySpeciesName..setPadding(10, 5, partySpeciesName)
 local partyNatureName = natureNamesList[(partyPID % 25) + 1]
 partyNatureName = partyNatureName..setPadding(7, 9, partyNatureName)

 local partyIVsAddr = partyAddr + 0xA1
 local partyHpIV = read8Bit(partyIVsAddr)
 local partyAtkIV = read8Bit(partyIVsAddr + 0x2)
 local partyDefIV = read8Bit(partyIVsAddr + 0x4)
 local partySpAtkIV = read8Bit(partyIVsAddr + 0x6)
 local partySpDefIV = read8Bit(partyIVsAddr + 0x8)
 local partySpdIV = read8Bit(partyIVsAddr + 0xA)

 local partyHPType = ((partyHpIV%2 + 2*(partyAtkIV%2) + 4*(partyDefIV%2) + 8*(partySpdIV%2) + 16*(partySpAtkIV%2) + 32*(partySpDefIV%2))*15) // 63
 local partyHPPower = (((partyHpIV&2)/2 + (partyAtkIV&2) + 2*(partyDefIV&2) + 4*(partySpdIV&2) + 8*(partySpAtkIV&2) + 16*(partySpDefIV&2))*40) // 63 + 30

 local partyShadowID = read8Bit(partyAddr + 0xD5)
 partyShadowID = string.format("%d", partyShadowID)..setPadding(2, 10, string.format("%d", partyShadowID))
 local partyHeartGauge = read16Bit(partyAddr + 0xDA)
 local partyHeartGaugeStepsCounter = getHeartGaugeStepsCounte(partyShadowID)

 if partyHeartGauge > 20000 or partyHeartGauge == 0 or partyShadowID == 0 then
  partyHeartGauge = 0
  partyHeartGaugeStepsCounter = 0
 end

 partyHeartGauge = string.format("%d", partyHeartGauge)..setPadding(5, 5, string.format("%d", partyHeartGauge))
 partyHeartGaugeStepsCounter = string.format("%d", partyHeartGaugeStepsCounter)..setPadding(3, 5, string.format("%d", partyHeartGaugeStepsCounter))

 local speciesText
 local PIDsText
 local naturesText
 local ivsText
 local partyHPTypeName
 local breedingHPTypeName
 local HPText
 local shadowInfoText
 local text

 if i == 0 then
  local breedingPID = read32Bit(breedingAddr)
  local breedingOTID = read16Bit(breedingAddr + 0x12)
  local breedingOTSID = read16Bit(breedingAddr + 0x10)
  local breedingSpeciesDexIndex = read16Bit(breedingAddr - 0x4)
  local breedingSpeciesDexNumber = nationalDexList[breedingSpeciesDexIndex + 1] + 1
  local breedingSpeciesName = speciesNamesList[breedingSpeciesDexNumber]
  local breedingNatureName = natureNamesList[(breedingPID % 25) + 1]

  local breedingIVsAddr = breedingAddr + 0xA1
  local breedingHpIV = read8Bit(breedingIVsAddr)
  local breedingAtkIV = read8Bit(breedingIVsAddr + 0x2)
  local breedingDefIV = read8Bit(breedingIVsAddr + 0x4)
  local breedingSpAtkIV = read8Bit(breedingIVsAddr + 0x6)
  local breedingSpDefIV = read8Bit(breedingIVsAddr + 0x8)
  local breedingSpdIV = read8Bit(breedingIVsAddr + 0xA)

  local breedingHPType = ((breedingHpIV%2 + 2*(breedingAtkIV%2) + 4*(breedingDefIV%2) + 8*(breedingSpdIV%2) + 16*(breedingSpAtkIV%2) + 32*(breedingSpDefIV%2))*15) // 63
  local breedingHPPower = (((breedingHpIV&2)/2 + (breedingAtkIV&2) + 2*(breedingDefIV&2) + 4*(breedingSpdIV&2) + 8*(breedingSpAtkIV&2) + 16*(breedingSpDefIV&2))*40) // 63 + 30

  local breedingShadowID = read8Bit(breedingAddr + 0xD5)
  local breedingHeartGauge = read16Bit(breedingAddr + 0xDA)
  local breedingHeartGaugeStepsCounter = getHeartGaugeStepsCounte(breedingShadowID)

  if breedingHeartGauge > 20000 or breedingHeartGauge == 0 or breedingShadowID == 0 then
   breedingHeartGauge = 0
   breedingHeartGaugeStepsCounter = 0
  end

  speciesText = string.format("Species: %sSpecies: %s", partySpeciesName, breedingSpeciesName)
  PIDsText = string.format("\nPID: %08X %s   PID: %08X %s", partyPID, shinyCheck(partyPID >> 16, partyPID & 0xFFFF, partyOTID, partyOTSID), breedingPID,
                           shinyCheck(breedingPID >> 16, breedingPID & 0xFFFF, breedingOTID, breedingOTSID))
  naturesText = string.format("\nNature: %sNature: %s", partyNatureName, breedingNatureName)
  ivsText = string.format("\nIVs: %02d/%02d/%02d/%02d/%02d/%02d   IVs: %02d/%02d/%02d/%02d/%02d/%02d",
                          partyHpIV, partyAtkIV, partyDefIV, partySpAtkIV, partySpDefIV, partySpdIV, breedingHpIV, breedingAtkIV, breedingDefIV,
                          breedingSpAtkIV, breedingSpDefIV, breedingSpdIV)
  partyHPTypeName = HPTypeNamesList[partyHPType + 1]
  breedingHPTypeName = HPTypeNamesList[breedingHPType + 1]
  HPText = string.format("\nHPower: %s %02d", partyHPTypeName, partyHPPower)..setPadding(11, 5, string.format("%s %02d", partyHPTypeName, partyHPPower))..
                         string.format("HPower: %s %02d", breedingHPTypeName, breedingHPPower)
  shadowInfoText = string.format("\nShadow ID: %s Shadow ID: %s\nHeart Gauge: %s Heart Gauge: %s\nSteps Counter: %s Steps Counter: %s",
                                 partyShadowID, breedingShadowID, partyHeartGauge, breedingHeartGauge, partyHeartGaugeStepsCounter,
								 breedingHeartGaugeStepsCounter)
  text = speciesText..PIDsText..naturesText..ivsText..HPText..shadowInfoText
 else
  speciesText = string.format("Species: %s", partySpeciesName)
  PIDsText = string.format("\nPID: %08X %s", partyPID, shinyCheck(partyPID >> 16, partyPID & 0xFFFF, partyOTID, partyOTSID))
  naturesText = string.format("\nNature: %s", partyNatureName)
  ivsText = string.format("\nIVs: %02d/%02d/%02d/%02d/%02d/%02d", partyHpIV, partyAtkIV, partyDefIV, partySpAtkIV, partySpDefIV, partySpdIV)
  HPText = string.format("\nHPower: %s %02d", HPTypeNamesList[partyHPType + 1], partyHPPower)
  shadowInfoText = string.format("\nShadow ID: %d\nHeart Gauge: %d\nSteps Counter: %d", partyShadowID, partyHeartGauge, partyHeartGaugeStepsCounter)
  text = speciesText..PIDsText..naturesText..ivsText..HPText..shadowInfoText
 end

 return text
end

function onScriptStart()
 local gameLang = read8Bit(0x3)

 if gameLang == 0x4A then -- J
  pointerAddr = 0x75E088
 elseif gameLang == 0x45 then -- U
  pointerAddr = 0x7EFDCC
 else -- E
  pointerAddr = 0x90C300
 end

 infoText = "\n\n"
end

function onScriptUpdate()
 pointer = read32Bit(pointerAddr)

 if pointer ~= 0 then
  partyAddr = pointer + 0x7FFE42E8
  breedingAddr = pointer + 0x7FFEC3B8
  heartGaugeStepsCounterAddr = pointer + 0x7FFFF26A

  finalText = string.format("\n\nParty                    Day Care\n\n")

  for i = 0, 5 do
   finalText = finalText..setInfo(partyAddr + (0x138 * i), breedingAddr, i).."\n\n"
  end
 end

 --PressButton("D-Down")
 SetScreenText(finalText)
end

function onScriptCancel()
 SetScreenText("")
end

function onStateLoaded()
end

function onStateSaved()
end