mdword = memory.readdwordunsigned
mword = memory.readwordunsigned
mbyte = memory.readbyte
rshift = bit.rshift
lshift = bit.lshift
bxor = bit.bxor
band = bit.band
floor = math.floor
sqrt = math.sqrt

local natureOrder = {"Atk", "Def", "Spd", "SpAtk", "SpDef"}

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

local moveName = {
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
 "Superpower", "Magic Coat", "Recycle", "Revenge", "Brick Break", "Yawn", "Knock partyScreenOff", "Endeavor", "Eruption", "Skill Swap",
 "Imprison", "Refresh", "Grudge", "Snatch", "Secret Power", "Dive", "Arm Thrust", "Camouflage", "Tail Glow", "Luster Purge",
 "Mist Ball", "Feather Dance", "Teeter Dance", "Blaze Kick", "Mud Sport", "Ice Ball", "Needle Arm", "Slack partyScreenOff",
 "Hyper Voice", "Poison Fang", "Crush Claw", "Blast Burn", "Hydro Cannon", "Meteor Mash", "Astonish", "Weather Ball",
 "Aromatherapy", "Fake Tears", "Air Cutter", "Overheat", "Odor Sleuth", "Rock Tomb", "Silver Wind", "Metal Sound",
 "Grass Whistle", "Tickle", "Cosmic Power", "Water Spout", "Signal Beam", "Shadow Punch", "Extrasensory", "Sky Uppercut",
 "Sand Tomb", "Sheer Cold", "Muddy Water", "Bullet Seed", "Aerial Ace", "Icicle Spear", "Iron Defense", "Block", "Howl",
 "Dragon Claw", "Frenzy Plant", "Bulk Up", "Bounce", "Mud Shot", "Poison Tail", "Covet", "Volt Tackle", "Magical Leaf",
 "Water Sport", "Calm Mind", "Leaf Blade", "Dragon Dance", "Rock Blast", "Shock Wave", "Water Pulse", "Doom Desire",
 "Psycho Boost"}

local nationalDexTable = {
 1, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26,
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
 45, 45, 45, 45, 45, 45, 45, 45, 45, 255, 120, 45, 255, 120, 45, 255, 120,
 45, 255, 127, 255, 90, 255, 90, 190, 75, 255, 90, 235, 120, 45, 235, 120,
 45, 150, 25, 190, 75, 170, 50, 255, 90, 255, 120, 45, 190, 75, 190, 75,
 255, 50, 255, 90, 190, 75, 190, 75, 190, 75, 255, 120, 45, 200, 100, 50,
 180, 90, 45, 255, 120, 45, 190, 60, 255, 120, 45, 190, 60, 190, 75, 190,
 60, 45, 190, 45, 190, 75, 190, 75, 190, 60, 190, 90, 45, 45, 190, 75,
 225, 60, 190, 60, 90, 45, 190, 75, 45, 45, 45, 190, 60, 120, 60, 30,
 45, 45, 225, 75, 225, 60, 225, 60, 45, 45, 45, 45, 45, 45, 45, 255, 45,
 45, 35, 45, 45, 45, 45, 45, 45, 45, 45, 45, 45, 25, 3, 3, 3, 45, 45, 45,
 3, 45,
 -- Gen 2
 45, 45, 45, 45, 45, 45, 45, 45, 45, 255, 90, 255, 90, 255, 90, 255, 90,
 90, 190, 75, 190, 150, 170, 190, 75, 190, 75, 235, 120, 45, 45, 190, 75,
 65, 45, 255, 120, 45, 45, 235, 120, 75, 255, 90, 45, 45, 30, 70, 45, 225,
 45, 60, 190, 75, 190, 60, 25, 190, 75, 45, 25, 190, 45, 60, 120, 60, 190,
 75, 225, 75, 60, 190, 75, 45, 25, 25, 120, 45, 45, 120, 60, 45, 45, 45, 75,
 45, 45, 45, 45, 45, 30, 3, 3, 3, 45, 45, 45, 3, 3, 45,
 -- Gen 3
 45, 45, 45, 45, 45, 45, 45, 45, 45, 255, 127, 255, 90, 255, 120, 45, 120,
 45, 255, 120, 45, 255, 120, 45, 200, 45, 190, 45, 235, 120, 45, 200, 75,
 255, 90, 255, 120, 45, 255, 120, 45, 190, 120, 45, 180, 200, 150, 255, 255,
 60, 45, 45, 180, 90, 45, 180, 90, 120, 45, 200, 200, 150, 150, 150, 225, 75,
 225, 60, 125, 60, 255, 150, 90, 255, 60, 255, 255, 120, 45, 190, 60, 255,
 45, 90, 90, 45, 45, 190, 75, 205, 155, 255, 90, 45, 45, 45, 45, 255, 60, 45,
 200, 225, 45, 190, 90, 200, 45, 30, 125, 190, 75, 255, 120, 45, 255, 60,
 60, 25, 225, 45, 45, 45, 3, 3, 3, 3, 3, 3, 3, 3, 5, 5, 3, 3, 3}

local ball = {"0", "255", "2", "1.5", "1", "1.5", "1", "1", "1", "1", "1", "1", "1"}
local mode = {"None", "Capture", "100% Catch", "Breeding", "Pandora", "Pokemon Info"}
local index = 1
local gameLang = mbyte(0x080000AF)
local gameVersion = mbyte(0x080000AE)
local language
local monInfo
local pointers
local partyScreenOff
local startBoxInfo
local startBoxInfo2
local partyScreen
local partyCursor
local hpiv
local atkiv
local defiv
local spdiv
local spatkiv
local spdefiv
local personality
local shinyCheck
local nature
local natinc
local natdec
local hidpowtype
local hidpowbase
local tid
local sid

if gameLang == 0x4A then  -- Check game language
 language = "JPN"
 monInfo = 0
 battleInfo = 0
 movesInfo = 0
 pointers = 0
 partyScreenOff = 0
 startBoxInfo = 0
 startBoxInfo2 = 0
 catchInfo = 0
 catchInfo2 = 0
elseif gameLang == 0x45 then
 language = "USA"
 monInfo = 0xD0
 battleInfo = 0xBC
 movesInfo = -0x3D4
 pointers = 0x2A0
 partyScreenOff = 0x80000
 startBoxInfo = 0x2E4
 startBoxInfo2 = 0x5D0
 catchInfo = 0x302
 catchInfo2 = 0x304
else
 language = "EUR"
 monInfo = 0xE0
 battleInfo = 0xCC
 movesInfo = -0x3D4
 pointers = 0x2A0
 partyScreenOff = 0x80000
 startBoxInfo = 0x2E4
 startBoxInfo2 = 0x5D0
 catchInfo = 0x302
 catchInfo2 = 0x304
end

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
end

if game ~= "Ruby" and game ~= "Sapphire" then
 warning = " - Wrong game version! Use Ruby/Sapphire instead"
else
 warning = ""
end

print("Devon Studios x Real.96")
print()
print("Game Version: "..game..warning)
print("Language: "..language)

local wildStart = 0x030044F0 + monInfo
local start = 0x030044F0 + monInfo
local moveStart = 0x02024844 + movesInfo
local ppStart = 0x0202485C + pointers
local partyStart = 0x03004290 + monInfo
local currentBoxPidSelected = 0x02000C1C + startBoxInfo2
local boxCheck = false
local initSeed = 0
local currSeed = 0
local tempCurr = 0
local frame = 0
local key = {}
local prevKey = {}
local catchKey = {}
local catchInstructions = false
local catchDelay = -1
local delayCounter = 0
local bonusStatus = 1
local skips = 0
local seed2 = 0
local seed3 = 0
local frameDelay = 0
local oneTime = false
local safariOffset = 0

joypad.set(1, {A = true, B = true, select = true, start = true})

function next(s)
 local a = 0x41C6 * (s % 65536) + rshift(s, 16) * 0x4E6D
 local b = 0x4E6D * (s % 65536) + (a % 65536) * 65536 + 0x6073
 local c = b % 4294967296
 return c
end

function back(s)
 local a = 0xEEB9 * (s % 65536) + rshift(s, 16) * 0xEB65
 local b = 0xEB65 * (s % 65536) + (a % 65536) * 65536 + 0x0A3561A1
 local c = b % 4294967296
 return c
end

function calcFrameJump()
 frame = frame + 1
 calibrationFrame = 0
 if frame > 4 and tempCurr ~= currSeed then
  tempCurr2 = tempCurr
  while tempCurr ~= currSeed and tempCurr2 ~= currSeed do
   tempCurr = next(tempCurr)
   tempCurr2 = back(tempCurr2)
   calibrationFrame = calibrationFrame + 1
  end
  if tempCurr2 == currSeed then
   calibrationFrame = (-1) * calibrationFrame
   tempCurr = tempCurr2
  end
 end
 return calibrationFrame
end

function findCatchSeed(s, d)
 local t = s
 for i = 1, d do
  t = next(t)
 end
 return t
end

function findSureCatch(s, b, sz)
 local t = s
 local t1 = s
 local delay = 0
 local ballShakes = 0
 while ballShakes ~= 4 do
  if rshift(t, 16) < b then
   ballShakes = 1
   t = next(t)
   if rshift(t, 16) < b then
    ballShakes = 2
    t = next(t)
    if rshift(t, 16) < b then
     ballShakes = 3
     t = next(t)
     if rshift(t, 16) < b then
      ballShakes = 4
     end
    end
   end
   else
    ballShakes = 0
  end
  if sz and delay % 2 ~= 0 then
   ballShakes = 0
  end
  t1 = next(t1)
  t = t1
  delay = delay + 1
 end
 return delay
end

function showStats()
 gui.text(2, 11, "Stats:")
 gui.text(30, 11, "HP "..mword(start + 86))
 gui.text(62, 11, "Atk "..mword(start + 90))
 gui.text(95, 11, "Def "..mword(start + 92))
 gui.text(128, 11, "SpA "..mword(start + 96))
 gui.text(161, 11, "SpD "..mword(start + 98))
 gui.text(194, 11, "Spe "..mword(start + 94))
end

function showHiddenInfo()
 gui.text(1, 21, "IVs:")
 gui.text(30, 21, "HP ")
 if hpiv >= 30 then
  gui.text(42, 21, hpiv, "green")
 elseif hpiv >= 1 and hpiv <= 5 then
  gui.text(42, 21, hpiv, "#ffb100")
 elseif hpiv < 1 then
  gui.text(42, 21, hpiv, "red")
 else
  gui.text(42, 21, hpiv)
 end
 gui.text(62, 21, "Atk ")
 if atkiv >= 30 then
  gui.text(78, 21, atkiv, "green")
 elseif atkiv >= 1 and atkiv <= 5 then
  gui.text(78, 21, atkiv, "#ffb100")
 elseif atkiv < 1 then
  gui.text(78, 21, atkiv, "red")
 else
  gui.text(78, 21, atkiv)
 end
 gui.text(95, 21, "Def ")
 if defiv >= 30 then
  gui.text(111, 21, defiv, "green")
 elseif defiv >= 1 and defiv <= 5 then
  gui.text(111, 21, defiv, "#ffb100")
 elseif defiv < 1 then
  gui.text(111, 21, defiv, "red")
 else
  gui.text(111, 21, defiv)
 end
 gui.text(128, 21, "SpA ")
 if spatkiv >= 30 then
  gui.text(144, 21, spatkiv, "green")
 elseif spatkiv >= 1 and spatkiv <= 5 then
  gui.text(144, 21, spatkiv, "#ffb100")
 elseif spatkiv < 1 then
  gui.text(144, 21, spatkiv, "red")
 else
  gui.text(144, 21, spatkiv)
 end
 gui.text(161, 21, "SpD ")
 if spdefiv >= 30 then
  gui.text(177, 21, spdefiv, "green")
 elseif spdefiv >= 1 and spdefiv <= 5 then
  gui.text(177, 21, spdefiv, "#ffb100")
 elseif spdefiv < 1 then
  gui.text(177, 21, spdefiv, "red")
 else
  gui.text(177, 21, spdefiv)
 end
 gui.text(194, 21, "Spe ")
 if spdiv >= 30 then
  gui.text(210, 21, spdiv, "green")
 elseif spdiv >= 1 and spdiv <= 5 then
  gui.text(210, 21, spdiv, "#ffb100")
 elseif spdiv < 1 then
  gui.text(210, 21, spdiv, "red")
 else
  gui.text(210, 21, spdiv)
 end

 gui.text(2, 40, "PID: ")
 if shinyCheck < 8 then
  gui.text(22, 40, string.format("%08X", personality), "green")
 else
  gui.text(22, 40, string.format("%08X", personality))
 end
 gui.text(2, 50, "Nature: "..natureName[nature + 1])
 gui.text(2, 60, natureOrder[natinc + 1].."+ "..natureOrder[natdec + 1].."-")
 gui.text(167, 30, "HP "..typeOrder[hidpowtype + 1].." "..hidpowbase)
end

function showMoves()
 if mword(moveStart) + 1 <= 355 then
  gui.text(2, 77, "Move: "..moveName[mword(moveStart) + 1])
 end
 if mword(moveStart + 2) + 1 <= 355 then
  gui.text(2, 87, "Move: "..moveName[mword(moveStart + 2) + 1])
 end
 if mword(moveStart + 4) + 1 <= 355 then
  gui.text(2, 97, "Move: "..moveName[mword(moveStart + 4) + 1])
 end
 if mword(moveStart + 6) + 1 <= 355 then
  gui.text(2, 107, "Move: "..moveName[mword(moveStart + 6) + 1])
 end
end

function showPP()
 gui.text(85, 77, "PP: ")
 if mbyte(ppStart) >= 1 and mbyte(ppStart) <= 4 then
  gui.text(101, 77, mbyte(ppStart), "#ffb100")
 elseif mbyte(ppStart) < 1 then
  gui.text(101, 77, mbyte(ppStart), "red")
 else
  gui.text(101, 77, mbyte(ppStart))
 end
 gui.text(85, 87, "PP: ")
 if mbyte(ppStart + 1) >= 1 and mbyte(ppStart + 1) <= 4 then
  gui.text(101, 87, mbyte(ppStart + 1), "#ffb100")
 elseif mbyte(ppStart + 1) < 1 then
  gui.text(101, 87, mbyte(ppStart + 1), "red")
 else
  gui.text(101, 87, mbyte(ppStart + 1))
 end
 gui.text(85, 97, "PP: ")
 if mbyte(ppStart + 2) >= 1 and mbyte(ppStart + 2) <= 4 then
  gui.text(101, 97, mbyte(ppStart + 2), "#ffb100")
 elseif mbyte(ppStart + 2) < 1 then
  gui.text(101, 97, mbyte(ppStart + 2), "red")
 else
  gui.text(101, 97, mbyte(ppStart + 2))
 end
 gui.text(85, 107, "PP: ")
 if mbyte(ppStart + 3) >= 1 and mbyte(ppStart + 3) <= 4 then
  gui.text(101, 107, mbyte(ppStart + 3), "#ffb100")
 elseif mbyte(ppStart + 3) < 1 then
  gui.text(101, 107, mbyte(ppStart + 3), "red")
 else
  gui.text(101, 107, mbyte(ppStart + 3))
 end
end

function showRngInfo()
 gui.text(2, 122, frame)
 gui.text(1, 132, "Initial Seed: "..string.format("%04X", initSeed))
 gui.text(2, 142, "Current Seed: "..string.format("%08X", currSeed))
end

function showTrainerInfo()
 gui.text(199, 142, string.format("TID: %d", tid))
 gui.text(199, 152, string.format("SID: %d", sid))
end

while true do
 currSeed = mdword(0x03004748 + monInfo)
 screenCheck = mdword(0x02020004)
 statsScreen = screenCheck == 0x80784030 or screenCheck == 0x80574020

 key = input.get()
 if key["1"] and not prevKey["1"] then
  index = index - 1
  if index < 1 then
   index = 6
  end
 elseif key["2"] and not prevKey["2"] then
  index = index + 1
  if index > 6 then
   index = 1
  end
 end

 gui.text(2, 1, "Mode: "..mode[index])
 gui.text(97, 1, "<- 1 - 2 ->")

 if key["4"] and not prevKey["4"] then
  catchInstructions = true
 elseif key["3"] and not prevKey["3"] then
  catchInstructions = false
 end

 prevKey = key

 if (currSeed <= 0xFFFF and frame < 8) or currSeed == 0 then  -- start counting the Frame when Initial Seed is generated
  initSeed = currSeed
  tempCurr = initSeed
  frame = 0
 end

 tempCurr = next(tempCurr)
 frame = frame + calcFrameJump()

 if mode[index] == "Capture" then
  start = 0x030044F0 + monInfo
 elseif mode[index] == "100% Catch" then
  if catchInstructions then
   gui.text(155, 1, "3 - Hide instructions")
   gui.text(2, 11, "1) During battle, go to BAG > POKE BALLS")
   gui.text(2, 21, "2) Press A on the ball you want to use")
   gui.text(2, 31, "3) Move the arrow on 'USE', pause the game and save a state")
   gui.text(2, 41, "4) Advance one frame holding SELECT and then unpause the")
   gui.text(2, 51, "game holding A. Wait until delay is calculated")
   gui.text(2, 61, "5) Load the state you made, advance frames until counter")
   gui.text(2, 71, "become 0")
   gui.text(2, 81, "6) Unpase the game holding A")
  else
   gui.text(155, 1, "4 - Show instructions")
  end

  battleScreen = mdword(0x0600D000) ~= 0 and mdword(0x0600CFFC) == 0
  species = nationalDexTable[mword(0x020241C4 + pointers) + 1]
  bagScreen = screenCheck == 0x00004000 or rshift(screenCheck, 0x4) == 0x00A4400
  ballSelector = mword(0x0203825C + catchInfo) + 1
  isBallSelected = ballSelector > 0 and ballSelector < 0xE
  status = mbyte(wildStart + 80)
  level = mbyte(start + 84)
  wildType = mbyte(0x02024859 + pointers)
  HPcurrent = mword(wildStart + 86)
  HPmax = mword(wildStart + 88)
  isUnderWater = mbyte(0x030041D0 + battleInfo) == 0x3
  isSafariZone = mword(0x02038506 + catchInfo2) ~= 0
  baseDexFlag = rshift(lshift(0x1000000, band((species - 1), 7)), 24)
  dexFlag = band(mbyte((0x2024C2C + pointers) + band(rshift(lshift(species - 1, 16), 19), 0xFF)), baseDexFlag)
  battleTurnsCounter = mbyte(0x03004223 + monInfo)

  if wildType == 0x0B or wildType == 0x06 then  -- net ball catch rate, 0x0B = Water, 0x06 = Bug
   ball[7] = 3
  else
   ball[7] = 1
  end

  if isUnderWater then  -- dive ball catch rate
   ball[8] = 3.5
   -- gui.text(0,77,"Undewater? Yes")
  else
   ball[8] = 1
   -- gui.text(0,77,"Undewater? No")
  end

  if level < 30 then  -- nest ball catch rate
   ball[9] = (40 - level) / 10
  else
   ball[9] = 1
  end

  if dexFlag ~= 0 then  -- repeat ball catch rate
   ball[10] = 3
   -- gui.text(0,77,"Already Catched? Yes")
  else
   ball[10] = 1
   -- gui.text(0,77,"Already Catched? No")
  end

  if battleTurnsCounter < 30 then  -- timer ball catch rate, bonusBall is x4 if battle turns are >= 30
   ball[11] = (battleTurnsCounter + 10) / 10
  else
   ball[11] = 4
  end

  if isBallSelected then
   bonusBall = ball[ballSelector]
  else
   bonusBall = 0
  end

  if status == 0 then
   bonusStatus = 1
  elseif (status > 0 and status < 0x08) or status == 0x020 then
   bonusStatus = 2
  else
   bonusStatus = 1.5
  end

  if isSafariZone then
   bonusBall = ball[6]
   safariOffset = 80
   rate = mbyte(0x02016089)
  else
   safariOffset = 0
   rate = catchRate[species]
  end

  a = floor(((((3 * HPmax) - (2 * HPcurrent)) * rate * bonusBall) / (3 * HPmax)) * bonusStatus)
  b = floor(1048560 / (sqrt(sqrt(16711680 / a))))

  catchKey = joypad.get(1)
  if catchKey.select then
   startingFrame = frame
   delayCounter = 0
   catchDelay = 0
   skips = 0
   oneTime = false
   seed2 = currSeed
   frameDelay = 0
  end

  if delayCounter <= 150 and catchDelay == 0 then
   if mbyte(0x02017810) == 0x40 and not oneTime then
    seed3 = currSeed
    while seed2 ~= seed3 do
     seed2 = next(seed2)
     skips = skips + 1
    end
    oneTime = true
    frameDelay = frame - startingFrame
   else
    seed2 = currSeed
   end

   if skips == 2 and frameDelay > 120 - safariOffset then
    catchDelay = frameDelay + 1
   elseif skips == 3 and frameDelay > 120 - safariOffset then  -- 0 shake
    catchDelay = frameDelay
   elseif skips == 4 and frameDelay > 120 - safariOffset then  -- 1 shake
    catchDelay = frameDelay - 1
   elseif skips == 5 and frameDelay > 120 - safariOffset then  -- 2 shake
    catchDelay = frameDelay - 2
   elseif skips == 6 and frameDelay > 120 - safariOffset then  -- 3 shake
    catchDelay = frameDelay - 3
   end
   delayCounter = delayCounter + 1
  end

  if catchDelay <= 0 then
   gui.text(2, 101, "Delay not calculated yet")
  else
   gui.text(2, 101, "Delay calculated")
  end

  catchSeed = findCatchSeed(currSeed, catchDelay)

  if catchDelay > 0 and a > 0 and (battleScreen or isBallSelected) and ((bonusBall ~= 0 and bagScreen) or isSafariZone) then
   sureCatchDelay = findSureCatch(catchSeed, b, isSafariZone) - 1
   if isSafariZone then
    sureCatchDelay = sureCatchDelay / 2
   end
   gui.text(2, 111, "100% catch missing frames: "..sureCatchDelay)
  end
 elseif mode[index] == "Breeding" then
  partyCounter = mbyte(0x03004280 + monInfo) - 1
  eggPartyPidStart = partyStart + partyCounter * 0x64
  start = eggPartyPidStart
 elseif mode[index] == "Pokemon Info" then
  partyCounter = mbyte(0x03004280 + monInfo) - 1
  partyScreen = screenCheck == 0x80080015 - partyScreenOff or screenCheck == 0x80080018 - partyScreenOff or screenCheck == 0x80080019 - partyScreenOff
  partyCursor = mbyte(0x020200BA + (0x88 * partyCounter))
  boxNum = mbyte(0x0202FDBC + startBoxInfo)
  boxStart = 0x0202FDBC + startBoxInfo + 4
  boxPosition = mbyte(0x02038201 + startBoxInfo)
  boxPidStart = boxStart + (0x1E * boxNum * 0x50) + (boxPosition * 0x50)
  boxCheck = mdword(currentBoxPidSelected) == mdword(boxPidStart) and (mword(0x02020008) == 0x6680 or mword(0x02020008) == 0x6690)

  if boxCheck and not partyScreen then
   start = boxPidStart
  elseif partyScreen then
   if partyCursor ~= 0x7 then
    start = partyStart + partyCursor * 0x64
   end
  elseif statsScreen then
   start = 0x02018010
  end
 end

 personality = mdword(start)
 trainerID = mdword(start + 4)
 isEgg = mword(start + 0x12) == 0x0601
 magicword = bxor(personality, trainerID)

 if mode[index] == "Pokemon Info" then
  tid = trainerID % 0x10000
  sid = floor(trainerID / 65536)
 else
  ids = mdword(0x02024C0E + pointers)
  tid = ids % 0x10000
  sid = floor(ids / 65536)
 end

 highPid = math.floor(personality / 65536)
 lowPid = personality % 0x10000
 shinyCheck = bxor(bxor(sid, tid), bxor(lowPid, highPid))

 i = personality % 24

 if i >= 18 then
  miscoffset = 0
 elseif i % 6 >= 4 then
  miscoffset = 12
 elseif i % 2 == 1 then
  miscoffset = 24
 else
  miscoffset = 36
 end

 ivs = bxor(mdword(start + 32 + miscoffset + 4), magicword)

 hpiv = band(ivs, 0x1F)
 atkiv = band(ivs, 0x1F * 0x20) / 0x20
 defiv = band(ivs, 0x1F * 0x400) / 0x400
 spdiv = band(ivs, 0x1F * 0x8000) / 0x8000
 spatkiv = band(ivs, 0x1F * 0x100000) / 0x100000
 spdefiv = band(ivs, 0x1F * 0x2000000) / 0x2000000

 nature = personality % 25
 natinc = floor(nature / 5)
 natdec = nature % 5

 hidpowtype=floor(((hpiv%2 + 2*(atkiv%2) + 4*(defiv%2) + 8*(spdiv%2) + 16*(spatkiv%2) + 32*(spdefiv%2))*15)/63)
 hidpowbase=floor(((band(hpiv,2)/2 + band(atkiv,2) + 2*band(defiv,2) + 4*band(spdiv,2) + 8*band(spatkiv,2) + 16*band(spdefiv,2))*40)/63 + 30)

 if mode[index] == "Capture" then
  battleScreen = mdword(0x0600D000) ~= 0 and mdword(0x0600CFFC) == 0
  roamerCheck = mdword(0x020285DC + pointers)

  if battleScreen and not statsScreen then
   showStats()
   showHiddenInfo()
   showMoves()
   showPP()
  end

  if roamerCheck == 0 then
   gui.text(186, 50, string.format("Roamer? No"))
  else
   gui.text(178, 50, string.format("Roamer? Yes"))
   gui.text(178, 60, string.format("PID: %08X", roamerCheck))
   gui.text(178, 70, "Nature: "..natureName[(roamerCheck % 25) + 1])
  end

  showRngInfo()
  showTrainerInfo()
 elseif mode[index] == "Breeding" then
  eggStepCounter = mbyte(0x02028544 + pointers)
  eggReady = mbyte(0x020266C4 + pointers) == 0xCC or mbyte(0x020266C4 + pointers) == 0xFE
  gui.text(2, 77, "Step Counter: "..eggStepCounter)

  if eggReady then
   eggLowPid = mword(0x02028548 + pointers)
   gui.text(2, 87, "Egg generated, go get it!")
   gui.text(2, 97, string.format("Egg lower PID: %04X", eggLowPid))
  elseif eggStepCounter == 254 then
   gui.text(2, 87, "Next step might generate an egg!")
  elseif eggStepCounter == 255 then
   gui.text(2, 87, "255th step taken")
  else
   gui.text(2, 87, "Keep on steppin'")
  end

  if not eggReady then
   gui.text(2, 97, "No Egg")
  end

  if isEgg then
   showStats()
   showHiddenInfo()
  end

  showRngInfo()
  showTrainerInfo()
 elseif mode[index] == "Pandora" then
  showRngInfo()
  showTrainerInfo()
 elseif mode[index] == "Pokemon Info" then
  if (partyScreen and partyCursor ~= 0x7) or statsScreen or boxCheck then
   if not boxCheck then
    showStats()
   end
   showHiddenInfo()
   showTrainerInfo()
  end
 end

 if mode[index] ~= "100% Catch" then
  catchInstructions = false
 end

 emu.frameadvance()
end