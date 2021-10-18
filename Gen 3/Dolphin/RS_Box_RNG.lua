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

local abilityNamesList = {
 "Stench", "Drizzle", "Speed Boost", "Battle Armor", "Sturdy", "Damp", "Limber",
 "Sand Veil", "Static", "Volt Absorb", "Water Absorb", "Oblivious", "Cloud Nine",
 "Compound Eyes", "Insomnia", "Color Change", "Immunity", "Flash Fire",
 "Shield Dust", "Own Tempo", "Suction Cups", "Intimidate", "Shadow Tag",
 "Rough Skin", "Wonder Guard", "Levitate", "Effect Spore", "Synchronize",
 "Clear Body", "Natural Cure", "Lightning Rod", "Serene Grace", "Swift Swim",
 "Chlorophyll", "Illuminate", "Trace", "Huge Power", "Poison Point", "Inner Focus",
 "Magma Armor", "Water Veil", "Magnet Pull", "Soundproof", "Rain Dish", "Sand Stream",
 "Pressure", "Thick Fat", "Early Bird", "Flame Body", "Run Away", "Keen Eye",
 "Hyper Cutter", "Pickup", "Truant", "Hustle", "Cute Charm", "Plus", "Minus", "Forecast",
 "Sticky Hold", "Shed Skin", "Guts", "Marvel Scale", "Liquid Ooze", "Overgrow", "Blaze",
 "Torrent", "Swarm", "Rock Head", "Drought", "Arena Trap", "Vital Spirit", "White Smoke",
 "Pure Power", "Shell Armor", "Cacophony", "Air Lock"}

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

local pokemonAbilities = {
 [001] = {65, 34}, [002] = {65, 34}, [003] = {65, 34}, [004] = {66}, [005] = {66}, [006] = {66}, [007] = {67, 44},
 [008] = {67, 44}, [009] = {67, 44}, [010] = {19, 50}, [011] = {61}, [012] = {14}, [013] = {19, 50}, [014] = {61},
 [015] = {68}, [016] = {51}, [017] = {51}, [018] = {51}, [019] = {50, 62, 55}, [020] = {50, 62, 55}, [021] = {51},
 [022] = {51}, [023] = {22, 61}, [024] = {22, 61}, [025] = {9, 31}, [026] = {9, 31}, [027] = {8}, [028] = {8},
 [029] = {38, 55}, [030] = {38, 55}, [031] = {38}, [032] = {38, 55}, [033] = {38, 55}, [034] = {38}, [035] = {56},
 [036] = {56}, [037] = {18, 70}, [038] = {18, 70}, [039] = {56}, [040] = {56}, [041] = {39}, [042] = {39},
 [043] = {34, 50}, [044] = {34, 1}, [045] = {34, 27}, [046] = {27, 6}, [047] = {27, 6}, [048] = {14, 50},
 [049] = {19}, [050] = {8, 71}, [051] = {8, 71}, [052] = {53}, [053] = {7}, [054] = {6, 13, 33},
 [055] = {6, 13, 33}, [056] = {72}, [057] = {72}, [058] = {22, 18}, [059] = {22, 18}, [060] = {11, 6, 33},
 [061] = {11, 6, 33}, [062] = {11, 6, 33}, [063] = {28, 39}, [064] = {28, 39}, [065] = {28, 39}, [066] = {62},
 [067] = {62}, [068] = {62}, [069] = {34}, [070] = {34}, [071] = {34}, [072] = {29, 64, 44}, [073] = {29, 64, 44},
 [074] = {69, 5, 8}, [075] = {69, 5, 8}, [076] = {69, 5, 8}, [077] = {50, 18, 49}, [078] = {50, 18, 49},
 [079] = {12, 20}, [080] = {12, 20}, [081] = {42, 5}, [082] = {42, 5}, [083] = {51, 39}, [084] = {50, 48},
 [085] = {50, 48}, [086] = {47}, [087] = {47}, [088] = {1, 60}, [089] = {1, 60}, [090] = {75}, [091] = {75},
 [092] = {26}, [093] = {26}, [094] = {26}, [095] = {69, 5}, [096] = {15, 39}, [097] = {15, 39}, [098] = {52, 75},
 [099] = {52, 75}, [100] = {43, 9}, [101] = {43, 9}, [102] = {34}, [103] = {34}, [104] = {69, 31, 4},
 [105] = {69, 31, 4}, [106] = {7}, [107] = {51, 39}, [108] = {20, 12, 13}, [109] = {26, 1}, [110] = {26, 1},
 [111] = {31, 69}, [112] = {31, 69}, [113] = {30, 32}, [114] = {34}, [115] = {48, 39}, [116] = {33, 6},
 [117] = {38, 6}, [230] = {33, 6}, [118] = {33, 41, 31}, [119] = {33, 41, 31}, [120] = {35, 30}, [121] = {35, 30},
 [122] = {43}, [123] = {68}, [212] = {68}, [238] = {12}, [124] = {12}, [239] = {9, 72}, [125] = {9, 72},
 [240] = {49, 72}, [126] = {49, 72}, [127] = {52}, [128] = {22}, [129] = {33}, [130] = {22}, [131] = {11, 75},
 [132] = {7}, [133] = {50}, [134] = {11}, [135] = {10}, [136] = {18, 62}, [196] = {28}, [197] = {28, 39},
 [137] = {36}, [233] = {36}, [138] = {33, 75}, [139] = {33, 75}, [140] = {33, 4}, [141] = {33, 4}, [142] = {69, 46},
 [143] = {17, 47}, [144] = {46}, [145] = {46, 9}, [146] = {46, 49}, [147] = {61, 63}, [148] = {61, 63}, [149] = {39},
 [150] = {46}, [151] = {28}, [152] = {65}, [153] = {65}, [154] = {65}, [155] = {66, 18}, [156] = {66, 18},
 [157] = {66, 18}, [158] = {67}, [159] = {67}, [160] = {67}, [161] = {50, 51}, [162] = {50, 51}, [163] = {15, 51},
 [164] = {15, 51}, [165] = {68, 48}, [166] = {68, 48}, [167] = {68, 15}, [168] = {68, 15}, [169] = {39},
 [170] = {10, 35, 11}, [171] = {10, 35, 11}, [172] = {9, 31}, [173] = {56}, [174] = {56}, [175] = {55, 32},
 [176] = {55, 32}, [177] = {28, 48}, [178] = {28, 48}, [179] = {9, 57}, [180] = {9, 57}, [181] = {9, 57}, [182] = {34},
 [183] = {47, 37}, [184] = {47, 37}, [185] = {5, 69}, [186] = {11, 6, 2}, [187] = {34}, [188] = {34}, [189] = {34},
 [190] = {50, 53}, [191] = {34, 48}, [192] = {34, 48}, [193] = {3, 14}, [194] = {6, 11}, [195] = {6, 11}, [198] = {15},
 [199] = {12, 20}, [200] = {26}, [201] = {26}, [202] = {23}, [203] = {39, 48}, [204] = {5}, [205] = {5},
 [206] = {32, 50}, [207] = {52, 8, 17}, [208] = {69, 5}, [209] = {22, 50}, [210] = {22}, [211] = {38, 33, 22},
 [213] = {5}, [214] = {68, 62}, [215] = {39, 51}, [216] = {53}, [217] = {62}, [218] = {40, 49}, [219] = {40, 49},
 [220] = {12, 47}, [221] = {12, 47}, [222] = {55, 30}, [223] = {55}, [224] = {21}, [225] = {72, 55, 15},
 [226] = {33, 11, 41}, [227] = {51, 5}, [228] = {48, 18}, [229] = {48, 18}, [231] = {53, 8}, [232] = {5, 8},
 [234] = {22}, [235] = {20}, [236] = {62, 72}, [237] = {22}, [241] = {47}, [242] = {30, 32}, [243] = {46, 39},
 [244] = {46, 39}, [245] = {46, 39}, [246] = {62, 8}, [247] = {61}, [248] = {45}, [249] = {46}, [250] = {46},
 [251] = {30}, [252] = {65}, [253] = {65}, [254] = {65}, [255] = {66, 3}, [256] = {66, 3}, [257] = {66, 3},
 [258] = {67, 6}, [259] = {67, 6}, [260] = {67, 6}, [261] = {50}, [262] = {22}, [263] = {53}, [264] = {53},
 [265] = {19, 50}, [266] = {61}, [267] = {68}, [268] = {61}, [269] = {19, 14}, [270] = {33, 44, 20}, [271] = {33, 44, 20},
 [272] = {33, 44, 20}, [273] = {34, 48}, [274] = {34, 48}, [275] = {34, 48}, [276] = {62}, [277] = {62}, [278] = {51, 44},
 [279] = {51, 2, 44}, [280] = {28, 36}, [281] = {28, 36}, [282] = {28, 36}, [283] = {33, 44}, [284] = {22}, [285] = {27},
 [286] = {27}, [287] = {54}, [288] = {72}, [289] = {54}, [290] = {14, 50}, [291] = {3}, [292] = {25}, [293] = {43},
 [294] = {43}, [295] = {43}, [296] = {47, 62}, [297] = {47, 62}, [298] = {47, 37}, [299] = {5, 42}, [300] = {56},
 [301] = {56}, [302] = {51}, [303] = {52, 22}, [304] = {5, 69}, [305] = {5, 69}, [306] = {5, 69}, [307] = {74},
 [308] = {74}, [309] = {9, 31, 58}, [310] = {9, 31, 58}, [311] = {57, 31}, [312] = {58, 10}, [313] = {35, 68}, [314] = {12},
 [315] = {30, 38}, [316] = {64, 60}, [317] = {64, 60}, [318] = {24, 3}, [319] = {24, 3}, [320] = {41, 12, 46},
 [321] = {41, 12, 46}, [322] = {12, 20}, [323] = {40}, [324] = {73, 70, 75}, [325] = {47, 20}, [326] = {47, 20}, [327] = {20},
 [328] = {52, 71}, [329] = {26}, [330] = {26}, [331] = {8, 11}, [332] = {8, 11}, [333] = {30, 13}, [334] = {30, 13},
 [335] = {17}, [336] = {61}, [337] = {26}, [338] = {26}, [339] = {12}, [340] = {12}, [341] = {52, 75}, [342] = {52, 75},
 [343] = {26}, [344] = {26}, [345] = {21}, [346] = {21}, [347] = {4, 33}, [348] = {4, 33}, [349] = {33, 12}, [350] = {63, 56},
 [351] = {59}, [352] = {16}, [353] = {15}, [354] = {15}, [355] = {26}, [356] = {46}, [357] = {34}, [358] = {26}, [359] = {46},
 [360] = {23}, [361] = {39}, [362] = {39}, [363] = {47, 12}, [364] = {47, 12}, [365] = {47, 12}, [366] = {75}, [367] = {33, 41},
 [368] = {33}, [369] = {33, 69, 5}, [370] = {33}, [371] = {69}, [372] = {69}, [373] = {22}, [374] = {29}, [375] = {29},
 [376] = {29}, [377] = {29, 5}, [378] = {29}, [379] = {29}, [380] = {26}, [381] = {26}, [382] = {2}, [383] = {70}, [384] = {77},
 [385] = {32}, [386] = {46}}

local itemNamesList = {
 "None", "Master Ball", "Ultra Ball", "Great Ball", "Poke Ball", "Safari Ball", "Net Ball", "Dive Ball", "Nest Ball", "Repeat Ball",
 "Timer Ball", "Luxury Ball", "Premier Ball", "Potion", "Antidote", "Burn Heal", "Ice Heal", "Awakening", "Parlyz Heal", "Full Restore",
 "Max Potion", "Hyper Potion", "Super Potion", "Full Heal", "Revive", "Max Revive", "Fresh Water", "Soda Pop", "Lemonade", "Moomoo Milk",
 "EnergyPowder", "Energy Root", "Heal Powder", "Revival Herb", "Ether", "Max Ether", "Elixir", "Max Elixir", "Lava Cookie", "Blue Flute",
 "Yellow Flute", "Red Flute", "Black Flute", "White Flute", "Berry Juice", "Sacred Ash", "Shoal Salt", "Shoal Shell", "Red Shard",
 "Blue Shard", "Yellow Shard", "Green Shard", "unknown", "unknown", "unknown", "unknown", "unknown", "unknown", "unknown", "unknown",
 "unknown", "unknown", "unknown", "HP Up", "Protein", "Iron", "Carbos", "Calcium", "Rare Candy", "PP Up", "Zinc", "PP Max", "unknown",
 "Guard Spec.", "Dire Hit", "X Attack", "X Defend", "X Speed", "X Accuracy", "X Special", "Poke Doll", "Fluffy Tail", "unknown",
 "Super Repel", "Max Repel", "Escape Rope", "Repel", "unknown", "unknown", "unknown", "unknown", "unknown", "unknown", "Sun Stone",
 "Moon Stone", "Fire Stone", "Thunderstone", "Water Stone", "Leaf Stone", "unknown", "unknown", "unknown", "unknown", "TinyMushroom",
 "Big Mushroom", "unknown", "Pearl", "Big Pearl", "Stardust", "Star Piece", "Nugget", "Heart Scale", "unknown", "unknown", "unknown",
 "unknown", "unknown", "unknown", "unknown", "unknown", "unknown", "Orange Mail", "Harbor Mail", "Glitter Mail", "Mech Mail", "Wood Mail",
 "Wave Mail", "Bead Mail", "Shadow Mail", "Tropic Mail", "Dream Mail", "Fab Mail", "Retro Mail", "Cheri Berry", "Chesto Berry",
 "Pecha Berry", "Rawst Berry", "Aspear Berry", "Leppa Berry", "Oran Berry", "Persim Berry", "Lum Berry", "Sitrus Berry", "Figy Berry",
 "Wiki Berry", "Mago Berry", "Aguav Berry", "Iapapa Berry", "Razz Berry", "Bluk Berry", "Nanab Berry", "Wepear Berry", "Pinap Berry",
 "Pomeg Berry", "Kelpsy Berry", "Qualot Berry", "Hondew Berry", "Grepa Berry", "Tamato Berry", "Cornn Berry", "Magost Berry", "Rabuta Berry",
 "Nomel Berry", "Spelon Berry", "Pamtre Berry", "Watmel Berry", "Durin Berry", "Belue Berry", "Liechi Berry", "Ganlon Berry", "Salac Berry",
 "Petaya Berry", "Apicot Berry", "Lansat Berry", "Starf Berry", "Enigma Berry", "unknown", "unknown", "unknown", "BrightPowder", "White Herb",
 "Macho Brace", "Exp. Share", "Quick Claw", "Soothe Bell", "Mental Herb", "Choice Band", "King's Rock", "SilverPowder", "Amulet Coin",
 "Cleanse Tag", "Soul Dew", "DeepSeaTooth", "DeepSeaScale", "Smoke Ball", "Everstone", "Focus Band", "Lucky Egg", "Scope Lens", "Metal Coat",
 "Leftovers", "Dragon Scale", "Light Ball", "Soft Sand", "Hard Stone", "Miracle Seed", "BlackGlasses", "Black Belt", "Magnet", "Mystic Water",
 "Sharp Beak", "Poison Barb", "NeverMeltIce", "Spell Tag", "TwistedSpoon", "Charcoal", "Dragon Fang", "Silk Scarf", "Up-Grade", "Shell Bell",
 "Sea Incense", "Lax Incense", "Lucky Punch", "Metal Powder", "Thick Club", "Stick", "unknown", "unknown", "unknown", "unknown", "unknown",
 "unknown", "unknown", "unknown", "unknown", "unknown", "unknown", "unknown", "unknown", "unknown", "unknown", "unknown", "unknown", "unknown",
 "unknown", "unknown", "unknown", "unknown", "unknown", "unknown", "unknown", "unknown", "unknown", "unknown", "Red Scarf", "Blue Scarf",
 "Pink Scarf", "Green Scarf", "Yellow Scarf", "Mach Bike", "Coin Case", "Itemfinder", "Old Rod", "Good Rod", "Super Rod", "S.S. Ticket",
 "Contest Pass", "unknown", "Wailmer Pail", "Devon Goods", "Soot Sack", "Basement Key", "Acro Bike", "Pokeblock Case", "Letter", "Eon Ticket",
 "Red Orb", "Blue Orb", "Scanner", "Go-Goggles", "Meteorite", "Rm. 1 Key", "Rm. 2 Key", "Rm. 4 Key", "Rm. 6 Key", "Storage Key", "Root Fossil",
 "Claw Fossil", "Devon Scope", "TM 01", "TM 02", "TM 03", "TM 04", "TM 05", "TM 06", "TM 07", "TM 08", "TM 09", "TM 10", "TM 11", "TM 12",
 "TM 13", "TM 14", "TM 15", "TM 16", "TM 17", "TM 18", "TM 19", "TM 20", "TM 21", "TM 22", "TM 23", "TM 24", "TM 25", "TM 26", "TM 27", "TM 28",
 "TM 29", "TM 30", "TM 31", "TM 32", "TM 33", "TM 34", "TM 35", "TM 36", "TM 37", "TM 38", "TM 39", "TM 40", "TM 41", "TM 42", "TM 43", "TM 44",
 "TM 45", "TM 46", "TM 47", "TM 48", "TM 49", "TM 50", "HM 01", "HM 02", "HM 03", "HM 04", "HM 05", "HM 06", "HM 07", "HM 08", "unknown",
 "unknown", "Oak's Parcel", "Poke Flute", "Secret Key", "Bike Voucher", "Gold Teeth", "Old Amber", "Card Key", "Lift Key", "Helix Fossil",
 "Dome Fossil", "Silph Scope", "Bicycle", "Town Map", "VS Seeker", "Fame Checker", "TM Case", "Berry Pouch", "Teachy TV", "Tri-Pass",
 "Rainbow Pass", "Tea", "MysticTicket", "AuroraTicket", "Powder Jar", "Ruby", "Sapphire", "Magma Emblem", "Old Sea Map"}

local currSeedAddr
local initSeed
local tempCurr
local advances
local checkInit

local wildAddr
local IDsAddr

function onScriptStart()
 local gameLang = read8Bit(0x3)
 local gbaGameLang
 local engOffset = 0
 initSeed = nil
 tempCurr = 0
 advances = 0
 checkInit = false

 if gameLang == 0x4A then -- J
  currSeedAddr = 0xB4E548
  wildAddr = 0xB4E2F0
  IDsAddr = 0xB2EA0E
 elseif gameLang == 0x45 then -- U
  currSeedAddr = 0xB1E9F8
  wildAddr = 0xB1E7A0
  IDsAddr = 0xAFF08E
 else -- E
  gbaGameLang = read8Bit(0xC110AF)

  if gbaGameLang == 0x45 then
   engOffset = 0x10
  end

  currSeedAddr = 0xB51E68 - engOffset
  wildAddr = 0xB51C10 - engOffset
  IDsAddr = 0xB324EE
 end
end

function reverse32Bit(addr)
 local value = read32Bit(addr)
 local reversed32BitValue = ((value & 0xFF) * 0x1000000) + ((value & 0xFF00) * 0x100) + ((value  >> 8) & 0xFF00) + (value  >> 24)

 return reversed32BitValue
end

function reverse16Bit(addr)
 local value = read16Bit(addr)
 local reversed16BitValue = ((value & 0xFF) * 0x100) + (value >> 8)

 return reversed16BitValue
end

function checkInitialSeedGeneration(current)
 if currSeed == 0x6073 then
  checkInit = true
 end

 if current <= 0xFFFF and current ~= 0x6073 and initSeed == nil and checkInit then
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
   tempCurr = LCRNG(tempCurr, 0x41C6, 0x4E6D, 0x6073)
   tempCurr2 = LCRNG(tempCurr2, 0xEEB9, 0xEB65, 0x0A3561A1)
   calibrationAdvances = calibrationAdvances + 1

   if calibrationAdvances > 9999 then
    initSeed = nil
    tempCurr = 0
    checkInit = false
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

function getRngInfoText(current, advances)
 local initialSeedText = "\n"
 local currSeedText = string.format("Current Seed: %08X\n", current)
 local advancesText = string.format("Advances: %d\n", advances)

 if initSeed ~= nil then
  initialSeedText = string.format("Initial Seed: %04X\n", initSeed)
 end

 return initialSeedText..currSeedText..advancesText
end

function shinyCheck(PID, trainerID, trainerSID)
 local highPID = PID >> 16
 local lowPID = PID & 0xFFFF
 local shinyType = trainerID ~ trainerSID ~ highPID ~ lowPID

 if shinyType == 0 then
  return " (Square)"
 elseif shinyType < 8 then
  return " (Star)"
 else
  return ""
 end
end

function getMiscOffset(orderIndex)
 local offset

 if orderIndex >= 18 then
  offset = 0
 elseif orderIndex % 6 >= 4 then
  offset = 12
 elseif orderIndex % 2 == 1 then
  offset = 24
 else
  offset = 36
 end

 return offset
end

function getGrowthOffset(orderIndex)
 local offset

 if orderIndex <= 5 then
  offset = 0
 elseif orderIndex % 6 <= 1 then
  offset = 12
 elseif orderIndex % 2 == 0 then
  offset = 24
 else
  offset = 36
 end

 return offset
end

function getAttacksOffset(orderIndex)
 local offset
 local index1 = {0, 1, 14, 15, 20, 21}
 local index2 = {2, 4, 12, 17, 18, 23}
 local index3 = {3, 5, 13, 16, 19, 22}
 local isIndex1 = 0
 local isIndex2 = 0

 for i = 1, 6 do
  if orderIndex == index1[i] then
   isIndex1 = 1
   break
  end
 end

 for i = 1, 6 do
  if orderIndex == index2[i] then
   isIndex2 = 1
   break
  end
 end

 if orderIndex >= 6 and orderIndex <= 11 then
  offset = 0
 elseif isIndex1 == 1 then
  offset = 12
 elseif isIndex2 == 1 then
  offset = 24
 else
  offset = 36
 end

 return offset
end

function getIVsAndHP(IVsValue)
 local hpIV = IVsValue & 0x1F
 local atkIV = (IVsValue & (0x1F * 0x20)) / 0x20
 local defIV = (IVsValue & (0x1F * 0x400)) / 0x400
 local spAtkIV = (IVsValue & (0x1F * 0x100000)) / 0x100000
 local spDefIV = (IVsValue & (0x1F * 0x2000000)) / 0x2000000
 local spdIV = (IVsValue & (0x1F * 0x8000)) / 0x8000

 local hpType = ((hpIV%2 + 2*(atkIV%2) + 4*(defIV%2) + 8*(spdIV%2) + 16*(spAtkIV%2) + 32*(spDefIV%2))*15)//63
 local hpPower = ((((hpIV&2)/2 + (atkIV&2) + 2*(defIV&2) + 4*(spdIV&2) + 8*(spAtkIV&2) + 16*(spDefIV&2))*40)//63) + 30

 local ivsText = string.format("IVs: %d/%d/%d/%d/%d/%d\n", hpIV, atkIV, defIV, spAtkIV, spDefIV, spdIV)
 local HPText = string.format("HPower: %s %d\n", HPTypeNamesList[hpType + 1], hpPower)

 return ivsText..HPText
end

function setMovePadding(moveName)
 local spacePadding = moveName

 if spacePadding ~= nil then
  for i = string.len(spacePadding), 15 do
   spacePadding = spacePadding.." "
  end
 else
  spacePadding = ""
 end

 return spacePadding
end

function getMovesAndPP(value1, value2, value3)
 local move1Number = value1 & 0xFFF
 local move2Number = value1 >> 16
 local move3Number = value2 & 0xFFF
 local move4Number = value2 >> 16

 local moveName1 = "--"
 local moveName2 = "--"
 local moveName3 = "--"
 local moveName4 = "--"

 if move1Number <= 354 then
  moveName1 = moveNamesList[move1Number + 1]
 end

 if move1Number <= 354 then
  moveName2 = moveNamesList[move2Number + 1]
 end

 if move1Number <= 354 then
  moveName3 = moveNamesList[move3Number + 1]
 end

 if move1Number <= 354 then
  moveName4 = moveNamesList[move4Number + 1]
 end

 local PPmove1 = value3 & 0xFF
 local PPmove2 = (value3 >> 8) & 0xFF
 local PPmove3 = (value3 >> 16) & 0xFF
 local PPmove4 = value3 >> 24

 local movesAndPPText = "\n"
 movesAndPPText = string.format("\n\nMove: %sPP: %d\n", setMovePadding(moveName1), PPmove1)
 movesAndPPText = movesAndPPText..string.format("Move: %sPP: %d\n", setMovePadding(moveName2), PPmove2)
 movesAndPPText = movesAndPPText..string.format("Move: %sPP: %d\n", setMovePadding(moveName3), PPmove3)
 movesAndPPText = movesAndPPText..string.format("Move: %sPP: %d\n", setMovePadding(moveName4), PPmove4)

 return movesAndPPText
end

function showOpponentPokemonInfo()
 local PID = reverse32Bit(wildAddr)
 local TID = reverse16Bit(wildAddr + 0x4)
 local SID = reverse16Bit(wildAddr + 0x6)
 local shinyType = shinyCheck(PID, TID, SID)
 local natureNumber = PID % 25
 local IDs = reverse32Bit(wildAddr + 0x4)
 local orderIndex = PID % 24
 local decryptionKey = PID ~ IDs
 local miscOffset = getMiscOffset(orderIndex)
 local growthOffset = getGrowthOffset(orderIndex)
 local attacksOffset = getAttacksOffset(orderIndex)

 local IVsAndAbilityValue = reverse32Bit(wildAddr + 0x20 + miscOffset + 0x4) ~ decryptionKey
 local speciesAndItemValue = reverse32Bit(wildAddr + 0x20 + growthOffset) ~ decryptionKey
 local moves1Value = reverse32Bit(wildAddr + 0x20 + attacksOffset) ~ decryptionKey
 local moves2Value = reverse32Bit(wildAddr + 0x20 + attacksOffset + 0x4) ~ decryptionKey
 local PPValue = reverse32Bit(wildAddr + 0x20 + attacksOffset + 0x8) ~ decryptionKey

 local speciesDexIndex = speciesAndItemValue & 0xFFFF
 local speciesDexNumber = nationalDexList[speciesDexIndex + 1]
 local speciesName = speciesNamesList[speciesDexNumber]

 local itemNumber = speciesAndItemValue >> 16
 local itemName = itemNamesList[itemNumber + 1]

 local abilityNumber = (IVsAndAbilityValue >> 0x1F) + 1

 if speciesDexNumber ~= nil and speciesDexNumber < 387 and abilityNumber ~= nil then
  abilityName = abilityNamesList[pokemonAbilities[speciesDexNumber][abilityNumber]]
 end

 local pokemonInfoText = "\n"

 if speciesName ~= nil then
  pokemonInfoText = string.format("\nSpecies: %s\n", speciesName)
 end

 pokemonInfoText = pokemonInfoText..string.format("PID: %08X%s\n", PID, shinyType)
 pokemonInfoText = pokemonInfoText..string.format("Nature: %s\n", natureNamesList[natureNumber + 1])

 if abilityName ~= nil and abilityNumber ~= nil then
  pokemonInfoText = pokemonInfoText..string.format("Ability: %s (%d)\n", abilityName, abilityNumber)
 end

 pokemonInfoText = pokemonInfoText..getIVsAndHP(IVsAndAbilityValue)

 if itemName ~= nil then
  pokemonInfoText = pokemonInfoText..string.format("Held item: %s\n", itemName)
 end

 pokemonInfoText = pokemonInfoText..getMovesAndPP(moves1Value, moves2Value, PPValue)

 return pokemonInfoText
end

function getTrainerIDsText()
 local TID = string.format("TID: %d\n", reverse16Bit(IDsAddr))
 local SID = string.format("SID: %d\n", reverse16Bit(IDsAddr + 0x2))
 local textReturn = ""

 for i = 0, 10 do
  textReturn = textReturn.."\n"
 end

 return textReturn..TID..SID
end

function onScriptUpdate()
 currSeed = reverse32Bit(currSeedAddr)
 checkInitialSeedGeneration(currSeed)

 if initSeed ~= nil then
  advances = advances + calcAdvancesJump(currSeed)
 end

 rngInfoText = getRngInfoText(currSeed, advances)
 pokemonInfoText = showOpponentPokemonInfo()
 trainerIDsInfoText = getTrainerIDsText()

 SetScreenText(rngInfoText..pokemonInfoText..trainerIDsInfoText)
end

function onScriptCancel()
 SetScreenText("")
end

function onStateLoaded()
end

function onStateSaved()
end