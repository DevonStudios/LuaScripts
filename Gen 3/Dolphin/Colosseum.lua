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
 "CHIKORITA", "BAYLEEF", "MEGANIUM", "CYNDAQUIL", "QUILAVA", "TYPHLOSION", "TOTODILE", "CROCONAW", "FERALIGATR", "SENTRET", "FURRET",
 "HOOTHOOT", "NOCTOWL", "LEDYBA", "LEDIAN", "SPINARAK", "ARIADOS", "CROBAT", "CHINCHOU", "LANTURN", "PICHU", "CLEFFA", "IGGLYBUFF",
 "TOGEPI", "TOGETIC", "NATU", "XATU", "MAREEP", "FLAAFFY", "AMPHAROS", "BELLOSSOM", "MARILL", "AZUMARILL", "SUDOWOODO", "POLITOED",
 "HOPPIP", "SKIPLOOM", "JUMPLUFF", "AIPOM", "SUNKERN", "SUNFLORA", "YANMA", "WOOPER", "QUAGSIRE", "ESPEON", "UMBREON", "MURKROW",
 "SLOWKING", "MISDREAVUS", "UNOWN", "WOBBUFFET", "GIRAFARIG", "PINECO", "FORRETRESS", "DUNSPARCE", "GLIGAR", "STEELIX", "SNUBBULL",
 "GRANBULL", "QWILFISH", "SCIZOR", "SHUCKLE", "HERACROSS", "SNEASEL", "TEDDIURSA", "URSARING", "SLUGMA", "MAGCARGO", "SWINUB",
 "PILOSWINE", "CORSOLA", "REMORAID", "OCTILLERY", "DELIBIRD", "MANTINE", "SKARMORY", "HOUNDOUR", "HOUNDOOM", "KINGDRA", "PHANPY",
 "DONPHAN", "PORYGON2", "STANTLER", "SMEARGLE", "TYROGUE", "HITMONTOP", "SMOOCHUM", "ELEKID", "MAGBY", "MILTANK", "BLISSEY", "RAIKOU",
 "ENTEI", "SUICUNE", "LARVITAR", "PUPITAR", "TYRANITAR", "LUGIA", "HO-OH", "CELEBI",
 -- Gen 3
 "TREECKO", "GROVYLE", "SCEPTILE", "TORCHIC", "COMBUSKEN", "BLAZIKEN", "MUDKIP", "MARSHTOMP", "SWAMPERT", "POOCHYENA", "MIGHTYENA",
 "ZIGZAGOON", "LINOONE", "WURMPLE", "SILCOON", "BEAUTIFLY", "CASCOON", "DUSTOX", "LOTAD", "LOMBRE", "LUDICOLO", "SEEDOT", "NUZLEAF",
 "SHIFTRY", "TAILLOW", "SWELLOW", "WINGULL", "PELIPPER", "RALTS", "KIRLIA", "GARDEVOIR", "SURSKIT", "MASQUERAIN", "SHROOMISH", "BRELOOM",
 "SLAKOTH", "VIGOROTH", "SLAKING", "NINCADA", "NINJASK", "SHEDINJA", "WHISMUR", "LOUDRED", "EXPLOUD", "MAKUHITA", "HARIYAMA", "AZURILL",
 "NOSEPASS", "SKITTY", "DELCATTY", "SABLEYE", "MAWILE", "ARON", "LAIRON", "AGGRON", "MEDITITE", "MEDICHAM", "ELECTRIKE", "MANECTRIC",
 "PLUSLE", "MINUN", "VOLBEAT", "ILLUMISE", "ROSELIA", "GULPIN", "SWALOT", "CARVANHA", "SHARPEDO", "WAILMER", "WAILORD", "NUMEL",
 "CAMERUPT", "TORKOAL", "SPOINK", "GRUMPIG", "SPINDA", "TRAPINCH", "VIBRAVA", "FLYGON", "CACNEA", "CACTURNE", "SWABLU", "ALTARIA",
 "ZANGOOSE", "SEVIPER", "LUNATONE", "SOLROCK", "BARBOACH", "WHISCASH", "CORPHISH", "CRAWDAUNT", "BALTOY", "CLAYDOL", "LILEEP", "CRADILY",
 "ANORITH", "ARMALDO", "FEEBAS", "MILOTIC", "CASTFORM", "KECLEON", "SHUPPET", "BANETTE", "DUSKULL", "DUSCLOPS", "TROPIUS", "CHIMECHO",
 "ABSOL", "WYNAUT", "SNORUNT", "GLALIE", "SPHEAL", "SEALEO", "WALREIN", "CLAMPERL", "HUNTAIL", "GOREBYSS", "RELICANTH", "LUVDISC", "BAGON",
 "SHELGON", "SALAMENCE", "BELDUM", "METANG", "METAGROSS", "REGIROCK", "REGICE", "REGISTEEL", "LATIAS", "LATIOS", "KYOGRE", "GROUDON",
 "RAYQUAZA", "JIRACHI", "DEOXYS"}

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

local catchRatesList = {
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

local prngAddr
local initSeed
local tempCurr
local advances

local TID
local SID

local pointerAddr
local enemyAddr
local boxFlagAddr
local boxSelectedPokemonAddr
local boxAddr
local infoText

function checkInitialSeedGeneration(current)
 if current > 0xFFFF and initSeed == 0 then
  initSeed = current
  tempCurr = initSeed
  advances = 0
 end
end

function LCRNG(s, mul1, mul2, sum)
 local a = mul1 * (s % 0x10000) + (s >> 16) * mul2
 local b = mul2 * (s % 0x10000) + (a % 0x10000) * 0x10000 + sum
 local c = b % 4294967296

 return c
end

function calcAdvancesJump(seed)
 local calibrationAdvances = 0
 local tempCurr2

 if tempCurr ~= seed then
  tempCurr2 = tempCurr

  while tempCurr ~= seed and tempCurr2 ~= seed do
   tempCurr = LCRNG(tempCurr, 0x3, 0x43FD, 0x269EC3)
   tempCurr2 = LCRNG(tempCurr2, 0xB9B3, 0x3155, 0xA170F641)
   calibrationAdvances = calibrationAdvances + 1

   if calibrationAdvances > 999999 then
    initSeed = 0
    tempCurr = seed
    break
   end
  end

  if tempCurr2 == seed and tempCurr2 ~= tempCurr then
   calibrationAdvances = (-1) * calibrationAdvances
   tempCurr = tempCurr2
  end
 end

 return calibrationAdvances
end

function isBoxOpened()
 return read16Bit(boxFlagAddr) == 0x391
end

function setBoxAddr()
 if isBoxOpened() then
  return boxSelectedPokemonAddr
 else
  return read32Bit(boxAddr) + 0xBA0
 end
end

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

function calcCatchRate(HP, bonusBall, rate)
 local a

 if HP ~= 0 then
  a = (HP * rate * bonusBall) // (3 * HP)

  return 1048560 // math.sqrt(math.sqrt(16711680 / a))
 end

 return 0
end

function setInfo(enemyAddr, partyAddr, boxAddr, i)
 local enemyPID = read32Bit(enemyAddr)
 local enemyOTID = TID
 local enemyOTSID = SID
 local enemySpeciesDexIndex = read16Bit(enemyAddr - 0x4)

 if enemySpeciesDexIndex > 411 then
  enemySpeciesDexIndex = 0
 end

 local enemySpeciesDexNumber = nationalDexList[enemySpeciesDexIndex + 1] + 1
 local enemySpeciesName = speciesNamesList[enemySpeciesDexNumber]
 enemySpeciesName = enemySpeciesName..setPadding(10, 5, enemySpeciesName)
 local enemyNatureName = natureNamesList[(enemyPID % 25) + 1]
 enemyNatureName = enemyNatureName..setPadding(7, 9, enemyNatureName)
 local catchRateValue = calcCatchRate(read16Bit(enemyAddr + 0x86), 1, catchRatesList[enemySpeciesDexNumber])

 local enemyIVsAddr = enemyAddr + 0xA1
 local enemyHpIV = read8Bit(enemyIVsAddr)
 local enemyAtkIV = read8Bit(enemyIVsAddr + 0x2)
 local enemyDefIV = read8Bit(enemyIVsAddr + 0x4)
 local enemySpAtkIV = read8Bit(enemyIVsAddr + 0x6)
 local enemySpDefIV = read8Bit(enemyIVsAddr + 0x8)
 local enemySpdIV = read8Bit(enemyIVsAddr + 0xA)

 local enemyHPType = ((enemyHpIV%2 + 2*(enemyAtkIV%2) + 4*(enemyDefIV%2) + 8*(enemySpdIV%2) + 16*(enemySpAtkIV%2) + 32*(enemySpDefIV%2))*15) // 63
 local enemyHPPower = (((enemyHpIV&2)/2 + (enemyAtkIV&2) + 2*(enemyDefIV&2) + 4*(enemySpdIV&2) + 8*(enemySpAtkIV&2) + 16*(enemySpDefIV&2))*40) // 63 + 30

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

 local speciesText
 local PIDsText
 local naturesText
 local ivsText
 local HPTypeName
 local partyHPTypeName
 local boxHPTypeName
 local HPText
 local catchRngText
 local text

 if i == 0 then
  local boxPID = read32Bit(boxAddr)
  local boxOTID = read16Bit(boxAddr + 0x12)
  local boxOTSID = read16Bit(boxAddr + 0x10)
  local boxSpeciesDexIndex = read16Bit(boxAddr - 0x4)
  local boxSpeciesDexNumber = nationalDexList[boxSpeciesDexIndex + 1] + 1
  local boxSpeciesName = speciesNamesList[boxSpeciesDexNumber]
  local boxNatureName = natureNamesList[(boxPID % 25) + 1]

  local boxIVsAddr = boxAddr + 0xA1
  local boxHpIV = read8Bit(boxIVsAddr)
  local boxAtkIV = read8Bit(boxIVsAddr + 0x2)
  local boxDefIV = read8Bit(boxIVsAddr + 0x4)
  local boxSpAtkIV = read8Bit(boxIVsAddr + 0x6)
  local boxSpDefIV = read8Bit(boxIVsAddr + 0x8)
  local boxSpdIV = read8Bit(boxIVsAddr + 0xA)

  local boxHPType = ((boxHpIV%2 + 2*(boxAtkIV%2) + 4*(boxDefIV%2) + 8*(boxSpdIV%2) + 16*(boxSpAtkIV%2) + 32*(boxSpDefIV%2))*15) // 63
  local boxHPPower = (((boxHpIV&2)/2 + (boxAtkIV&2) + 2*(boxDefIV&2) + 4*(boxSpdIV&2) + 8*(boxSpAtkIV&2) + 16*(boxSpDefIV&2))*40) // 63 + 30

  speciesText = string.format("Species: %sSpecies: %sSpecies: %s", enemySpeciesName, partySpeciesName, boxSpeciesName)
  PIDsText = string.format("\nPID: %08X %s   PID: %08X %s   PID: %08X %s", enemyPID, shinyCheck(enemyPID >> 16, enemyPID & 0xFFFF, enemyOTID,
                           enemyOTSID), partyPID, shinyCheck(partyPID >> 16, partyPID & 0xFFFF, partyOTID, partyOTSID), boxPID, shinyCheck(boxPID >> 16,
                           boxPID & 0xFFFF, boxOTID, boxOTSID))
  naturesText = string.format("\nNature: %sNature: %sNature: %s", enemyNatureName, partyNatureName, boxNatureName)
  ivsText = string.format("\nIVs: %02d/%02d/%02d/%02d/%02d/%02d   IVs: %02d/%02d/%02d/%02d/%02d/%02d   IVs: %02d/%02d/%02d/%02d/%02d/%02d",
                          enemyHpIV, enemyAtkIV, enemyDefIV, enemySpAtkIV, enemySpDefIV, enemySpdIV, partyHpIV, partyAtkIV, partyDefIV, partySpAtkIV,
                          partySpDefIV, partySpdIV, boxHpIV, boxAtkIV, boxDefIV, boxSpAtkIV, boxSpDefIV, boxSpdIV)

  HPTypeName = HPTypeNamesList[enemyHPType + 1]
  partyHPTypeName = HPTypeNamesList[partyHPType + 1]
  boxHPTypeName = HPTypeNamesList[boxHPType + 1]
  HPText = string.format("\nHPower: %s %02d", HPTypeName, enemyHPPower)..setPadding(11, 5, string.format("%s %02d", HPTypeName, enemyHPPower))..
                         string.format("HPower: %s %02d", partyHPTypeName, partyHPPower)..setPadding(11, 5, string.format("%s %02d", partyHPTypeName,
                         partyHPPower))..string.format("HPower: %s %02d", boxHPTypeName, boxHPPower)
  catchRngText = string.format("\nCatch Rate Value: %.0f", catchRateValue)
  text = speciesText..PIDsText..naturesText..ivsText..HPText..catchRngText
 else
  speciesText = string.format("Species: %sSpecies: %s", enemySpeciesName, partySpeciesName)
  PIDsText = string.format("\nPID: %08X %s   PID: %08X %s", enemyPID, shinyCheck(enemyPID >> 16, enemyPID & 0xFFFF, enemyOTID, enemyOTSID),
                           partyPID, shinyCheck(partyPID >> 16, partyPID & 0xFFFF, partyOTID, partyOTSID))
  naturesText = string.format("\nNature: %sNature: %s", enemyNatureName, partyNatureName)
  ivsText = string.format("\nIVs: %02d/%02d/%02d/%02d/%02d/%02d   IVs: %02d/%02d/%02d/%02d/%02d/%02d", enemyHpIV, enemyAtkIV, enemyDefIV, enemySpAtkIV,
                          enemySpDefIV, enemySpdIV, partyHpIV, partyAtkIV, partyDefIV, partySpAtkIV, partySpDefIV, partySpdIV)

  HPTypeName = HPTypeNamesList[enemyHPType + 1]
  partyHPTypeName = HPTypeNamesList[partyHPType + 1]
  HPText = string.format("\nHPower: %s %02d", HPTypeName, enemyHPPower)..setPadding(11, 5, string.format("%s %02d", HPTypeName, enemyHPPower))..
                         string.format("HPower: %s %02d", partyHPTypeName, partyHPPower)
  catchRngText = string.format("\nCatch Rate Value: %.0f", catchRateValue)
  text = speciesText..PIDsText..naturesText..ivsText..HPText..catchRngText
 end

 return text
end

function onScriptStart()
 local gameLang = read8Bit(0x3)

 if gameLang == 0x4A then -- J
  prngAddr = 0x464360
  pointerAddr = 0x75E088
  enemyAddr = 0x45E750
  boxFlagAddr = 0x4641EA
  boxSelectedPokemonAddr = 0x395CBC
  boxAddr = 0x466468
 elseif gameLang == 0x45 then -- U
  prngAddr = 0x478C90
  pointerAddr = 0x7EFDCC
  enemyAddr = 0x473070
  boxFlagAddr = 0x478B1A
  boxSelectedPokemonAddr = 0x3A95EC
  boxAddr = 0x47ADB8
 else -- E
  prngAddr = 0x4C6130
  pointerAddr = 0x90C300
  enemyAddr = 0x4C0508
  boxFlagAddr = 0x4C5FBA
  boxSelectedPokemonAddr = 0x3F6A6C
  boxAddr = 0x4C8268
 end

 initSeed = 0
 tempCurr = 0
 advances = 0
 TID = 0
 SID = 0
 infoText = "\n\n"
end

function onScriptUpdate()
 currSeed = read32Bit(prngAddr)
 checkInitialSeedGeneration(currSeed)
 advances = advances + calcAdvancesJump(currSeed)

 pointer = read32Bit(pointerAddr)

 if pointer ~= 0 then
  TID = read16Bit(pointer + 0x7FFE42E2)
  SID = read16Bit(pointer + 0x7FFE42E0)

  partyAddr = pointer + 0x7FFE42E8
  currBoxAddr = setBoxAddr()

  infoText = string.format("\n\nOpponent                 Party                    Box\n\n")

  for i = 0, 5 do
   infoText = infoText..setInfo(enemyAddr + (0x138 * i), partyAddr + (0x138 * i), currBoxAddr, i).."\n\n"
  end
 end

 RNGInfoText = string.format("Initial Seed: %08X\nCurrent Seed: %08X\nAdvances: %d", initSeed, currSeed, advances)
 IDsInfoText = string.format("\n\n\nTID: %05d\nSID: %05d", TID, SID)
 finalText = RNGInfoText..infoText..IDsInfoText
 SetScreenText(finalText)
end

function onScriptCancel()
 SetScreenText("")
end

function onStateLoaded()
end

function onStateSaved()
end