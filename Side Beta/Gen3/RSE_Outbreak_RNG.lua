mdword = memory.readdwordunsigned
mword = memory.readwordunsigned
mbyte = memory.readbyte
rshift = bit.rshift

local gameVersion = mbyte(0x080000AE)
local game
local encounters = "RS"
local gameLang = mbyte(0x080000AF)
local language = ""
local warning

local speciesNamesList = {
 -- Gen 1
 "Bulbasaur", "Ivysaur", "Venusaur", "Charmander", "Charmeleon", "Charizard", "Squirtle", "Wartortle", "Blastoise",
 "Caterpie", "Metapod", "Butterfree", "Weedle", "Kakuna", "Beedrill", "Pidgey", "Pidgeotto", "Pidgeot", "Rattata",
 "Raticate", "Spearow", "Fearow", "Ekans", "Arbok", "Pikachu", "Raichu", "Sandshrew", "Sandslash", "Nidoran♀",
 "Nidorina", "Nidoqueen", "Nidoran♂", "Nidorino", "Nidoking", "Clefairy", "Clefable", "Vulpix", "Ninetales",
 "Jigglypuff", "Wigglytuff", "Zubat", "Golbat", "Oddish", "Gloom", "Vileplume", "Paras", "Parasect", "Venonat",
 "Venomoth", "Diglett", "Dugtrio", "Meowth", "Persian", "Psyduck", "Golduck", "Mankey", "Primeape", "Growlithe",
 "Arcanine", "Poliwag", "Poliwhirl", "Poliwrath", "Abra", "Kadabra", "Alakazam", "Machop", "Machoke", "Machamp",
 "Bellsprout", "Weepinbell", "Victreebel", "Tentacool", "Tentacruel", "Geodude", "Graveler", "Golem", "Ponyta",
 "Rapidash", "Slowpoke", "Slowbro", "Magnemite", "Magneton", "Farfetch'd", "Doduo", "Dodrio", "Seel", "Dewgong",
 "Grimer", "Muk", "Shellder", "Cloyster", "Gastly", "Haunter", "Gengar", "Onix", "Drowzee", "Hypno", "Krabby",
 "Kingler", "Voltorb", "Electrode", "Exeggcute", "Exeggutor", "Cubone", "Marowak", "Hitmonlee", "Hitmonchan",
 "Lickitung", "Koffing", "Weezing", "Rhyhorn", "Rhydon", "Chansey", "Tangela", "Kangaskhan", "Horsea", "Seadra",
 "Goldeen", "Seaking", "Staryu", "Starmie", "Mr. Mime", "Scyther", "Jynx", "Electabuzz", "Magmar", "Pinsir", "Tauros",
 "Magikarp", "Gyarados", "Lapras", "Ditto", "Eevee", "Vaporeon", "Jolteon", "Flareon", "Porygon", "Omanyte", "Omastar",
 "Kabuto", "Kabutops", "Aerodactyl", "Snorlax", "Articuno", "Zapdos", "Moltres", "Dratini", "Dragonair", "Dragonite",
 "Mewtwo", "Mew",
 -- Gen 2
 "Chikorita", "Bayleef", "Meganium", "Cyndaquil", "Quilava", "Typhlosion", "Totodile", "Croconaw", "Feraligatr",
 "Sentret", "Furret", "Hoothoot", "Noctowl", "Ledyba", "Ledian", "Spinarak", "Ariados", "Crobat", "Chinchou", "Lanturn",
 "Pichu", "Cleffa", "Igglybuff", "Togepi", "Togetic", "Natu", "Xatu", "Mareep", "Flaaffy", "Ampharos", "Bellossom",
 "Marill", "Azumarill", "Sudowoodo", "Politoed", "Hoppip", "Skiploom", "Jumpluff", "Aipom", "Sunkern", "Sunflora",
 "Yanma", "Wooper", "Quagsire", "Espeon", "Umbreon", "Murkrow", "Slowking", "Misdreavus", "Unown", "Wobbuffet",
 "Girafarig", "Pineco", "Forretress", "Dunsparce", "Gligar", "Steelix", "Snubbull", "Granbull", "Qwilfish", "Scizor",
 "Shuckle", "Heracross", "Sneasel", "Teddiursa", "Ursaring", "Slugma", "Magcargo", "Swinub", "Piloswine", "Corsola",
 "Remoraid", "Octillery", "Delibird", "Mantine", "Skarmory", "Houndour", "Houndoom", "Kingdra", "Phanpy", "Donphan",
 "Porygon2", "Stantler", "Smeargle", "Tyrogue", "Hitmontop", "Smoochum", "Elekid", "Magby", "Miltank", "Blissey",
 "Raikou", "Entei", "Suicune", "Larvitar", "Pupitar", "Tyranitar", "Lugia", "Ho-Oh", "Celebi",
 -- Gen 3
 "Treecko", "Grovyle", "Sceptile", "Torchic", "Combusken", "Blaziken", "Mudkip", "Marshtomp", "Swampert", "Poochyena",
 "Mightyena", "Zigzagoon", "Linoone", "Wurmple", "Silcoon", "Beautifly", "Cascoon", "Dustox", "Lotad", "Lombre", "Ludicolo",
 "Seedot", "Nuzleaf", "Shiftry", "Taillow", "Swellow", "Wingull", "Pelipper", "Ralts", "Kirlia", "Gardevoir", "Surskit",
 "Masquerain", "Shroomish", "Breloom", "Slakoth", "Vigoroth", "Slaking", "Nincada", "Ninjask", "Shedinja", "Whismur",
 "Loudred", "Exploud", "Makuhita", "Hariyama", "Azurill", "Nosepass", "Skitty", "Delcatty", "Sableye", "Mawile", "Aron",
 "Lairon", "Aggron", "Meditite", "Medicham", "Electrike", "Manectric", "Plusle", "Minun", "Volbeat", "Illumise", "Roselia",
 "Gulpin", "Swalot", "Carvanha", "Sharpedo", "Wailmer", "Wailord", "Numel", "Camerupt", "Torkoal", "Spoink", "Grumpig",
 "Spinda", "Trapinch", "Vibrava", "Flygon", "Cacnea", "Cacturne", "Swablu", "Altaria", "Zangoose", "Seviper", "Lunatone",
 "Solrock", "Barboach", "Whiscash", "Corphish", "Crawdaunt", "Baltoy", "Claydol", "Lileep", "Cradily", "Anorith", "Armaldo",
 "Feebas", "Milotic", "Castform", "Kecleon", "Shuppet", "Banette", "Duskull", "Dusclops", "Tropius", "Chimecho", "Absol",
 "Wynaut", "Snorunt", "Glalie", "Spheal", "Sealeo", "Walrein", "Clamperl", "Huntail", "Gorebyss", "Relicanth", "Luvdisc",
 "Bagon", "Shelgon", "Salamence", "Beldum", "Metang", "Metagross", "Regirock", "Regice", "Registeel", "Latias", "Latios",
 "Kyogre", "Groudon", "Rayquaza", "Jirachi", "Deoxys"}

local moveNamesList = {
 "--" , "Pound", "Karate Chop", "Double Slap", "Comet Punch", "Mega Punch", "Pay Day", "Fire Punch", "Ice Punch", "Thunder Punch",
 "Scratch", "Vice Grip", "Guillotine", "Razor Wind", "Swords Dance", "Cut", "Gust", "Wing Attack", "Whirlwind", "Fly",
 "Bind", "Slam", "Vine Whip", "Stomp", "Double Kick", "Mega Kick", "Jump Kick", "Rolling Kick", "Sand Attack", "Headbutt",
 "Horn Attack", "Fury Attack", "Horn Drill", "Tackle", "Body Slam", "Wrap", "Take Down", "Thrash", "Double-Edge",
 "Tail Whip", "Poison Sting", "Twineedle", "Pin Missile", "Leer", "Bite", "Growl", "Roar", "Sing", "Supersonic", "Sonic Boom",
 "Disable", "Acid", "Ember", "Flamethrower", "Mist", "Water Gun", "Hydro Pump", "Surf", "Ice Beam", "Blizzard", "Psybeam",
 "Bubble Beam", "Aurora Beam", "Hyper Beam", "Peck", "Drill Peck", "Submission", "Low Kick", "Counter", "Seismic Toss",
 "Strength", "Absorb", "Mega Drain", "Leech Seed", "Growth", "Razor Leaf", "Solar Beam", "Poison Powder", "Stun Spore",
 "Sleep Powder", "Petal Dance", "String Shot", "Dragon Rage", "Fire Spin", "Thunder Shock", "Thunderbolt", "Thunder Wave",
 "Thunder", "Rock Throw", "Earthquake", "Fissure", "Dig", "Toxic", "Confusion", "Psychic", "Hypnosis", "Meditate",
 "Agility", "Quick Attack", "Rage", "Teleport", "Night Shade", "Mimic", "Screech", "Double Team", "Recover", "Harden",
 "Minimize", "Smokescreen", "Confuse Ray", "Withdraw", "Defense Curl", "Barrier", "Light Screen", "Haze", "Reflect",
 "Focus Energy", "Bide", "Metronome", "Mirror Move", "Self-Destruct", "Egg Bomb", "Lick", "Smog", "Sludge", "Bone Club",
 "Fire Blast", "Waterfall", "Clamp", "Swift", "Skull Bash", "Spike Cannon", "Constrict", "Amnesia", "Kinesis", "Soft-Boiled",
 "High Jump Kick", "Glare", "Dream Eater", "Poison Gas", "Barrage", "Leech Life", "Lovely Kiss", "Sky Attack", "Transform",
 "Bubble", "Dizzy Punch", "Spore", "Flash", "Psywave", "Splash", "Acid Armor", "Crabhammer", "Explosion", "Fury Swipes",
 "Bonemerang", "Rest", "Rock Slide", "Hyper Fang", "Sharpen", "Conversion", "Tri Attack", "Super Fang", "Slash",
 "Substitute", "Struggle", "Sketch", "Triple Kick", "Thief", "Spider Web", "Mind Reader", "Nightmare", "Flame Wheel",
 "Snore", "Curse", "Flail", "Conversion 2", "Aeroblast", "Cotton Spore", "Reversal", "Spite", "Powder Snow", "Protect",
 "Mach Punch", "Scary Face", "Feint Attack", "Sweet Kiss", "Belly Drum", "Sludge Bomb", "Mud-Slap", "Octazooka", "Spikes",
 "Zap Cannon", "Foresight", "Destiny Bond", "Perish Song", "Icy Wind", "Detect", "Bone Rush", "Lock-On", "Outrage",
 "Sandstorm", "Giga Drain", "Endure", "Charm", "Rollout", "False Swipe", "Swagger", "Milk Drink", "Spark", "Fury Cutter",
 "Steel Wing", "Mean Look", "Attract", "Sleep Talk", "Heal Bell", "Return", "Present", "Frustration", "Safeguard",
 "Pain Split", "Sacred Fire", "Magnitude", "Dynamic Punch", "Megahorn", "Dragon Breath", "Baton Pass", "Encore", "Pursuit",
 "Rapid Spin", "Sweet Scent", "Iron Tail", "Metal Claw", "Vital Throw", "Morning Sun", "Synthesis", "Moonlight", "Hidden Power",
 "Cross Chop", "Twister", "Rain Dance", "Sunny Day", "Crunch", "Mirror Coat", "Psych Up", "Extreme Speed", "Ancient Power",
 "Shadow Ball", "Future Sight", "Rock Smash", "Whirlpool", "Beat Up", "Fake Out", "Uproar", "Stockpile", "Spit Up",
 "Swallow", "Heat Wave", "Hail", "Torment", "Flatter", "Will-O-Wisp", "Memento", "Facade", "Focus Punch", "Smelling Salts",
 "Follow Me", "Nature Power", "Charge", "Taunt", "Helping Hand", "Trick", "Role Play", "Wish", "Assist", "Ingrain",
 "Superpower", "Magic Coat", "Recycle", "Revenge", "Brick Break", "Yawn", "Knock Off", "Endeavor", "Eruption", "Skill Swap",
 "Imprison", "Refresh", "Grudge", "Snatch", "Secret Power", "Dive", "Arm Thrust", "Camouflage", "Tail Glow", "Luster Purge",
 "Mist Ball", "Feather Dance", "Teeter Dance", "Blaze Kick", "Mud Sport", "Ice Ball", "Needle Arm", "Slack Off",
 "Hyper Voice", "Poison Fang", "Crush Claw", "Blast Burn", "Hydro Cannon", "Meteor Mash", "Astonish", "Weather Ball",
 "Aromatherapy", "Fake Tears", "Air Cutter", "Overheat", "Odor Sleuth", "Rock Tomb", "Silver Wind", "Metal Sound",
 "Grass Whistle", "Tickle", "Cosmic Power", "Water Spout", "Signal Beam", "Shadow Punch", "Extrasensory", "Sky Uppercut",
 "Sand Tomb", "Sheer Cold", "Muddy Water", "Bullet Seed", "Aerial Ace", "Icicle Spear", "Iron Defense", "Block", "Howl",
 "Dragon Claw", "Frenzy Plant", "Bulk Up", "Bounce", "Mud Shot", "Poison Tail", "Covet", "Volt Tackle", "Magical Leaf",
 "Water Sport", "Calm Mind", "Leaf Blade", "Dragon Dance", "Rock Blast", "Shock Wave", "Water Pulse", "Doom Desire",
 "Psycho Boost"}

local nationalDexList = {
 1, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26,
 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50,
 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74,
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

local locationNamesList = {
 "Petalburg City", "Slateport City", "Mauville City", "Rustboro City", "Fortree City", "Lilycove City",
 "Mossdeep City", "Sootopolis City", "Ever Grande City", "Littleroot Town", "Oldale Town", "Dewford Town",
 "Lavaridge Town", "Fallarbor Town", "Verdanturf Town", "Pacifidlog Town", "Route 101", "Route 102",
 "Route 103", "Route 104", "Route 105", "Route 106", "Route 107", "Route 108", "Route 109", "Route 110",
 "Route 111", "Route 112", "Route 113", "Route 114", "Route 115", "Route 116", "Route 117", "Route 118",
 "Route 119", "Route 120", "Route 121", "Route 122", "Route 123", "Route 124", "Route 125", "Route 126",
 "Route 127", "Route 128", "Route 129", "Route 130", "Route 131", "Route 132", "Route 133", "Route 134",
 "Underwater Route124", "Underwater Route126", "Underwater Route 127", "Underwater Route 128",
 "Underwater Route 129", "Underwater Route 105", "Underwater Route 125"}

local rseOutbreakEncounters = {["RS"] = {"Surskit (3)", "Surskit (15)", "Surskit (15)","Surskit (28)", "Skitty (15)"},
                               ["E"] = {"Seedot (3)", "Nuzleaf (15)", "Seedot (13)", "Seedot (25)", "Skitty (8)"}}
local encounterIndex = 1
local prevKey = {}
local prevkey = {}
local leftArrowColor
local rightArrowColor

local arrowColumnIndex = 0
local arrowRowIndex = 0

local saveBlockPointer
local showOutbreakEncounters = false

local prngAddr
local outbreakDelayCounter = 999
local outbreakDelay = 0
local currSeed2
local frameDifference
local advancesDelay = 0
local outbreakState

if gameVersion == 0x56 then  -- Check game version
 game = "Ruby"
elseif gameVersion == 0x50 then
 game = "Sapphire"
elseif gameVersion == 0x52 then
 game = "FireRed"
elseif gameVersion == 0x47 then
 game = "LeafGreen"
elseif gameVersion == 0x45 then
 game = "Emerald"
 encounters = "E"
end

if game == "Ruby" or game == "Sapphire" then
 if gameLang == 0x4A then  -- Check game language
  language = "JPN"
  saveBlockPointer = 0x02025494
  prngAddr = 0x03004748
 elseif gameLang == 0x45 then
  language = "USA"
  saveBlockPointer = 0x02025734
  prngAddr = 0x03004818
 else
  language = "EUR"
  saveBlockPointer = 0x02025734
  prngAddr = 0x03004828
 end
elseif game == "Emerald" then
 if gameLang == 0x4A then
  language = "JPN"
  saveBlockPointer = 0x03005AEC
  prngAddr = 0x03005AE0
 else
  language = "USA/EUR"
  saveBlockPointer = 0x03005D8C
  prngAddr = 0x03005D80
 end
end

if game ~= "Ruby" and game ~= "Sapphire" and game ~= "Emerald" then
 warning = " - Wrong game version! Use Ruby/Sapphire/Emerald instead"
else
 warning = ""
end

print("Game Version: "..game..warning)
print("Language: "..language)

function LCRNG(s, mul1, mul2, sum)
 local a = mul1 * (s % 65536) + rshift(s, 16) * mul2
 local b = mul2 * (s % 65536) + (a % 65536) * 65536 + sum
 local c = b % 4294967296

 return c
end

function showArrowSelector()
 leftArrowColor = "gray"
 rightArrowColor = "gray"

 local key = input.get()

 if (key["3"] or key["numpad3"]) and (not prevkey["3"] and not prevkey["numpad3"]) then
  showOutbreakEncounters = true
 elseif (key["4"] or key["numpad4"]) and (not prevkey["4"] and not prevkey["numpad4"]) then
  showOutbreakEncounters = false
 end

 if (key["1"] or key["numpad1"]) and (not prevkey["1"] and not prevkey["numpad1"]) then
  leftArrowColor = "orange"
  arrowColumnIndex = arrowColumnIndex - 1

  if arrowColumnIndex < 0 then
   if arrowRowIndex > 0 then
    arrowColumnIndex = 1
    arrowRowIndex = arrowRowIndex - 1
   else
    arrowColumnIndex = 0
   end
  end

  if encounterIndex > 1 then
   encounterIndex = encounterIndex - 1
  end
 elseif (key["2"] or key["numpad2"]) and (not prevkey["2"] and not prevkey["numpad2"]) then
  rightArrowColor = "orange"
  arrowColumnIndex = arrowColumnIndex + 1

  if arrowColumnIndex > 1 then
   if arrowRowIndex < (table.getn(rseOutbreakEncounters[encounters]) / 2) - 1 then
    arrowColumnIndex = 0
    arrowRowIndex = arrowRowIndex + 1
   else
    arrowColumnIndex = 1
   end
  elseif arrowRowIndex > 1 then
    arrowColumnIndex = 0
  end

  if encounterIndex < table.getn(rseOutbreakEncounters[encounters]) then
   encounterIndex = encounterIndex + 1
  end
 end

 prevkey = key
end

function drawArrowLeft(a, b, c)
 gui.line(a, b + 3, a + 2, b + 5, c)
 gui.line(a, b + 3, a + 2, b + 1, c)
 gui.line(a, b + 3, a + 6, b + 3, c)
end

function drawArrowRight(a, b, c)
 gui.line(a, b + 3, a - 2, b + 5, c)
 gui.line(a, b + 3, a - 2, b + 1, c)
 gui.line(a, b + 3, a - 6, b + 3, c)
end

function printEncounters()
 local z = 0
 for i = 0, 2 do
  for j = 0, 1 do
   if j == 0 or i < 2 then
    gui.text(125 + (62 * j), 15 + (10 * i), rseOutbreakEncounters[encounters][i + j + z + 1])
   end
  end
  z = z + 1
 end

 gui.text(118 + (62 * arrowColumnIndex), 15 + (10 * arrowRowIndex), ">")
end

function getNextSeed(seed, delay)
 delay = delay or 1

 local tempSeed = seed

 for i = 1, delay do
  tempSeed = LCRNG(tempSeed, 0x41C6, 0x4E6D, 0x6073)
 end

 return tempSeed
end

function getOutbreakDelay(currSeed)
 local key = joypad.get(1)
 local skips
 local currSeed3

 if key.select then
  --print(string.format("Curr Seed: %08X", currSeed))
  outbreakDelayCounter = 0
  outbreakDelay = 0
  currSeed2 = currSeed
  advancesDelay = 0
  skips2 = 0
  outbreakState = savestate.create()
  savestate.save(outbreakState)
 end

 if outbreakDelayCounter <= 150 and outbreakDelay == 0 then
  skips = 0
  currSeed3 = currSeed

  while currSeed3 ~= currSeed2 do
   currSeed2 = getNextSeed(currSeed2)
   skips = skips + 1
  end

  advancesDelay = advancesDelay + skips

  if skips > skips2 and advancesDelay > 60 then
   outbreakDelay = advancesDelay - (skips - skips2 - 1)
   --print("Delay: ", outbreakDelay)
   savestate.load(outbreakState)
   emu.pause()
  else
   skips2 = skips
   currSeed2 = currSeed3
   outbreakDelayCounter = outbreakDelayCounter + 1
  end
 end

 return outbreakDelay
end

function outbreakCheck(s, n)
 n = n or 1

 return rshift(getNextSeed(s, n), 16) < 0x148
end

function getEncounter(s, n)
 n = n or 2

 return rshift(getNextSeed(s, n), 16) % 5
end

function findOutbreakEncounter(seed, index)
 local tempSeed = seed
 local delay = 0

 local isOutbreak = outbreakCheck(tempSeed)
 local encounterValue = getEncounter(tempSeed)
 local isWantedEncounter = encounterValue == index - 1
 while not (isOutbreak and isWantedEncounter) do
  tempSeed = LCRNG(tempSeed, 0x41C6, 0x4E6D, 0x6073)
  isOutbreak = outbreakCheck(tempSeed)
  encounterValue = getEncounter(tempSeed)
  isWantedEncounter = encounterValue == index - 1
  delay = delay + 1
  --print(string.format("%08X - %d", tempSeed, delay))

  if delay % 2 ~= 0 then
   isOutbreak = false
  end
 end

 return delay / 2
end

function outbreakRng(currSeed)
 local battleOutbreakDelay = getOutbreakDelay(currSeed)

 if battleOutbreakDelay == 0 then --and not oneTimePickupRng then
  gui.text(1, 132, "Delay not calculated yet")
 else
  gui.text(1, 132, "Delay calculated")
 end

 if battleOutbreakDelay > 0 then --and not oneTimePickupRng then
  local outbreakSeed = getNextSeed(currSeed, battleOutbreakDelay)
  --print(string.format("Outbreak Seed: %08X", outbreakSeed))
  return findOutbreakEncounter(outbreakSeed, encounterIndex)
 end

 return 0
end

function printCurrenActiveOutbreak()
 if game == "Emerald" then
  massOutbreakAddr = mdword(saveBlockPointer) + 0x2B90
 else
  massOutbreakAddr = saveBlockPointer + 0x2AFC
 end

 gui.text(164, 48, "Active Outbreak:")

 if mword(massOutbreakAddr) ~= 0 then
  local speciesDexNumber = nationalDexList[mword(massOutbreakAddr) + 1]
  local mapNum = mbyte(massOutbreakAddr + 0x2)
  local level = mbyte(massOutbreakAddr + 0x4)
  local speciesName = speciesNamesList[speciesDexNumber]
  local move1Number = mword(massOutbreakAddr + 0x8)
  local move2Number = mword(massOutbreakAddr + 0xA)
  local move3Number = mword(massOutbreakAddr + 0xC)
  local move4Number = mword(massOutbreakAddr + 0xE)
  local daysLeft = mword(massOutbreakAddr + 0x12)

  if speciesDexNumber ~= nil then
   gui.text(164, 56, "Species: "..speciesName)
  end

  gui.text(164, 64, "Level: "..level)

  if moveNamesList[move1Number + 1] ~= nil and moveNamesList[move2Number + 1] ~= nil and moveNamesList[move3Number + 1] ~= nil and moveNamesList[move4Number + 1] ~= nil then
   gui.text(164, 72, "Move: "..moveNamesList[move1Number + 1])
   gui.text(164, 80, "Move: "..moveNamesList[move2Number + 1])
   gui.text(164, 88, "Move: "..moveNamesList[move3Number + 1])
   gui.text(164, 96, "Move: "..moveNamesList[move4Number + 1])
  end

  gui.text(164, 112, "Days left: "..daysLeft)

  if locationNamesList[mapNum + 1] ~= nil then
   gui.text(164, 120, "Location:\n"..locationNamesList[mapNum + 1])
  end
 else
  gui.text(164, 56, "None")
 end
end

function getTvShowMassOutbreak()
 local tvShowmassOutbreakAddr
 local tvKind

 if game == "Emerald" then
  tvShowmassOutbreakAddr = mdword(saveBlockPointer) + 0x27CC
 else
  tvShowmassOutbreakAddr = saveBlockPointer + 0x2738
 end

 for i = 0, 24 do
  local tvShowMassOutbreakAddr = tvShowmassOutbreakAddr + (i * 0x24)
  tvKind = mbyte(tvShowMassOutbreakAddr)

  if tvKind == 0x29 then
   local isOutbreakActive = mbyte(tvShowMassOutbreakAddr + 0x1) == 1
   local move1Number = mword(tvShowMassOutbreakAddr + 0x4)
   local move2Number = mword(tvShowMassOutbreakAddr + 0x6)
   local move3Number = mword(tvShowMassOutbreakAddr + 0x8)
   local move4Number = mword(tvShowMassOutbreakAddr + 0xA)
   local speciesDexNumber = nationalDexList[mword(tvShowMassOutbreakAddr + 0xC) + 1]
   local speciesName = speciesNamesList[speciesDexNumber]
   local mapNum = mbyte(tvShowMassOutbreakAddr + 0x10)
   local level = mbyte(tvShowMassOutbreakAddr + 0x14)
   local daysLeft = mbyte(tvShowMassOutbreakAddr + 0x16)

   if isOutbreakActive then
    gui.text(1, 8, "TV Mass Outbreak active")
   else
    gui.text(1, 8, "TV Mass Outbreak not active")
   end

   gui.text(1, 16, "Species: "..speciesName)
   gui.text(1, 24, "Level: "..level)
   gui.text(1, 32, "Move: "..moveNamesList[move1Number + 1])
   gui.text(1, 40, "Move: "..moveNamesList[move2Number + 1])
   gui.text(1, 48, "Move: "..moveNamesList[move3Number + 1])
   gui.text(1, 56, "Move: "..moveNamesList[move4Number + 1])
   gui.text(1, 64, "Days left: "..daysLeft)
   gui.text(1, 80, "Location:\n"..locationNamesList[mapNum + 1])
   break
  end
 end

 if tvKind ~= 0x29 then
  gui.text(1, 8, "No TV Mass Outbreak")
 end

 printCurrenActiveOutbreak()
end

while warning == "" do
 getTvShowMassOutbreak()

 showArrowSelector()
 drawArrowLeft(110, 1, leftArrowColor)
 gui.text(120, 1, "1 - 2")
 drawArrowRight(148, 1, rightArrowColor)

 if showOutbreakEncounters then
  gui.text(175, 1, "4 - Hide Pokemon")
  printEncounters()
 else
  gui.text(175, 1, "3 - Show Pokemon")
 end

 outbreakEncounterDelay = outbreakRng(mdword(prngAddr))
 gui.text(1, 140, "Outbreak missing advances: "..outbreakEncounterDelay)
 gui.text(1, 108, "Target Outbreak Encounter:\n"..rseOutbreakEncounters[encounters][encounterIndex])

 emu.frameadvance()
end