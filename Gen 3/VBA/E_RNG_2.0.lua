mdword = memory.readdwordunsigned
mword = memory.readwordunsigned
mbyte = memory.readbyte
rshift = bit.rshift
bxor = bit.bxor
band = bit.band
floor = math.floor
sqrt = math.sqrt

local natureorder = {"Atk", "Def", "Spd", "SpAtk", "SpDef"}
local naturename = {
 "Hardy", "Lonely", "Brave", "Adamant", "Naughty",
 "Bold", "Docile", "Relaxed", "Impish", "Lax",
 "Timid", "Hasty", "Serious", "Jolly", "Naive",
 "Modest", "Mild", "Quiet", "Bashful", "Rash",
 "Calm", "Gentle", "Sassy", "Careful", "Quirky"}
local typeorder = {
 "Fighting", "Flying", "Poison", "Ground",
 "Rock", "Bug", "Ghost", "Steel",
 "Fire", "Water", "Grass", "Electric",
 "Psychic", "Ice", "Dragon", "Dark"}
local movename = {
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

local catchRate = {
 -- Gen 1
 0, 45, 45, 45, 45, 45, 45, 45, 45, 45, 255,
 120,45, 255, 120, 45, 255, 120, 45, 255,
 127, 255, 90, 255, 90, 190, 75, 255, 90,
 235, 120, 45, 235, 120, 45, 150, 25, 190,
 75, 170, 50, 255, 90, 255, 120, 45, 190,
 75, 190, 75, 255, 50, 255, 90, 190, 75,
 190, 75, 190, 75, 255, 120, 45, 200, 100,
 50, 180, 90, 45, 255, 120, 45, 190, 60,
 255, 120, 45, 190, 60, 190, 75, 190, 60,
 45, 190, 45, 190, 75, 190, 75, 190, 60,
 190, 90, 45, 45, 190, 75, 225, 60, 190,
 60, 90, 45, 190, 75, 45, 45, 45, 190, 60,
 120, 60, 30, 45, 45, 225, 75, 225, 60, 225,
 60, 45, 45, 45, 45, 45, 45, 45, 255, 45,
 45, 35, 45, 45, 45, 45, 45, 45, 45, 45,
 45,45, 25, 3, 3, 3, 45, 45, 45, 3, 45,
 -- Gen 2
 45, 45, 45, 45, 45, 45, 45, 45, 45, 255,
 90, 255, 90, 255, 90, 255, 90, 90, 190,
 75, 190, 150, 170, 190, 75, 190, 75, 235,
 120, 45, 45, 190, 75, 65, 45, 255, 120, 45,
 45, 235, 120, 75, 255, 90, 45, 45, 30, 70,
 45, 225, 45, 60, 190, 75, 190, 60, 25, 190,
 75, 45, 25, 190, 45, 60, 120, 60, 190, 75,
 225, 75, 60, 190, 75, 45, 25, 25, 120, 45,
 45, 120, 60, 45, 45, 45, 75, 45, 45, 45, 45,
 45, 30, 3, 3, 3, 45, 45, 45, 3, 3, 45,
 -- Gen 3
 45, 45, 45, 45, 45, 45, 45, 45, 45, 255, 127,
 255, 90, 255, 120, 45, 120, 45, 255, 120, 45,
 255, 120, 45, 255, 120, 45, 200, 45, 255, 90,
 255, 190, 45, 200, 75, 125, 60, 255, 60, 200,
 255, 90, 255, 90, 45, 190, 75, 225, 205, 155,
 255, 60, 225, 60, 255, 120, 45, 180, 200, 120,
 45, 255, 150, 255, 120, 45, 190, 60, 190, 75,
 45, 45, 150, 255, 60, 200, 200, 45, 180, 90,
 255, 45, 125, 190, 90, 150, 255, 120, 45, 225,
 75, 200, 190, 120, 45, 255, 60, 60, 30, 225, 45,
 90, 90, 25, 180, 90, 45, 45, 150, 150, 45, 45,
 45, 45, 235, 120, 45, 45, 45, 45, 3, 3, 3, 3,
 3, 3, 5, 5, 3, 3, 3, 3, 3, 45}

local ball = {"0", "255", "2", "1.5", "1", "1.5", "1", "1", "1", "1", "1", "1", "1"}

local mode = {"None", "Capture", "100% Catch", "Breeding", "Pandora", "Pokemon Info"}
local index = 1
local gameLang = mbyte(0x080000AF)
local gameVersion = mbyte(0x080000AE)
local language
local monInfo
local pointers
local eggInfo
local boxCheckOff
local startBoxInfo
local partyScreen
local partyCursor
local hpiv
local atkiv
local defiv
local spdiv
local spatkiv
local spdefiv
local personality
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
 pointers = 0
 battleSeedInfo = 0
 eggInfo = 0
 eggInfo2 = 0xA0
 boxCheckOff = 0
 startBoxInfo = 0
else
 language = "EUR/USA"
 monInfo = 0x35C
 pointers = 0x2A0
 battleSeedInfo = 0x334
 eggInfo = 0x360
 eggInfo2 = 0
 boxCheckOff = 0xFFFF00
 startBoxInfo = 0x2C8
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

if game ~= "Emerald" then
 warning = " - Wrong game version! Use Emerald instead"
else
 warning = ""
end

print("Devon Studios x Real.96")
print()
print("Game Version: "..game..warning)
print("Language: "..language)

local wildStart = 0x020243E8 + monInfo
local start = 0x020243E8 + monInfo
local moveStart = 0x02023D8C + monInfo
local ppStart = 0x02023DA4 + monInfo
local eggPidPointerAddr = 0x0203B944 + battleSeedInfo
local partyStart = 0x02024190 + monInfo
local boxPointerAddr = 0x03005AF4 + pointers
local currentBoxPidSelected = 0x02000CF0
local boxCheck = false
local initSeed = 0
local currSeed = 0
local tempInit = 0
local tempCurr = 0
local frame = 0
local adjustFrame = 0
local iter = 0
local base = 0
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

function shinyCheck(t, s, p)
 highPid = floor(p / 65536)
 lowPid = p % 0x10000
 return bxor(bxor(s, t), bxor(lowPid, highPid)) < 8
end

function calcFrameJump(init)
 frame = frame + 1
 tempCurr = init
 calibrationFrame = 0
 if tempCurr ~= currSeed then
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
 if shinyCheck(tid, sid, personality) then
  gui.text(22, 40, string.format("%08X", personality), "green")
 else
  gui.text(22, 40, string.format("%08X", personality))
 end
 gui.text(2, 50, "Nature: "..naturename[nature + 1])
 gui.text(2, 60, natureorder[natinc + 1].."+ "..natureorder[natdec + 1].."-")
 gui.text(167, 30, "HP "..typeorder[hidpowtype + 1].." "..hidpowbase)
end

function showMoves()
 if mword(moveStart) + 1 <= 355 then
  gui.text(2, 77, "Move: "..movename[mword(moveStart) + 1])
 end
 if mword(moveStart + 2) + 1 <= 355 then
  gui.text(2, 87, "Move: "..movename[mword(moveStart + 2) + 1])
 end
 if mword(moveStart + 4) + 1 <= 355 then
  gui.text(2, 97, "Move: "..movename[mword(moveStart + 4) + 1])
 end
 if mword(moveStart + 6) + 1 <= 355 then
  gui.text(2, 107, "Move: "..movename[mword(moveStart + 6) + 1])
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
 gui.text(2, 122, frame - adjustFrame)
 gui.text(1, 132, "Initial Seed: "..string.format("%04X", initSeed))
 gui.text(2, 142, "Current Seed: "..string.format("%08X", currSeed))
end

function showTrainerInfo()
 gui.text(199, 142, string.format("TID: %d", tid))
 gui.text(199, 152, string.format("SID: %d", sid))
end

while true do
 initSeedIDS = mword(0x2020000)
 currSeed = mdword(0x03005AE0 + pointers)
 frame = mdword(0x02024664 + monInfo)
 battleVideoSeed1 = mdword(0x0203B9F8 + battleSeedInfo)
 battleVideoSeed2 = mdword(0x0203AD74 + battleSeedInfo)
 screenCheck = mdword(0x02020004)
 statsScreen = screenCheck == 0x09000100 or screenCheck == 0x0B000000

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

 if key["4"] and not prevKey["4"] then
  catchInstructions = true
 elseif key["3"] and not prevKey["3"] then
  catchInstructions = false
 end

 prevKey = key

 if battleVideoSeed1 == battleVideoSeed2 and battleVideoSeed2 == currSeed then
  initSeed = battleVideoSeed2
  adjustFrame = frame
 elseif battleVideoSeed1 == 0 and currSeed == initSeedIDS then
  initSeed = initSeedIDS
  adjustFrame = frame
 end

 if battleVideoSeed1 == battleVideoSeed2 and battleVideoSeed2 ~= 0 and initSeed ~= battleVideoSeed2 then  --[[(initSeedIDS == 0 and battleVideoSeed2 == battleseed) or]]
  initSeed = battleVideoSeed2
  adjustFrame = frame - calcFrameJump(battleVideoSeed2)
 elseif initSeedIDS ~= 0 and initSeed ~= initSeedIDS then
  initSeed = initSeedIDS
  adjustFrame = frame - calcFrameJump(initSeedIDS)
 elseif battleVideoSeed2 == 0 and initSeedIDS == 0 then
  initSeed = initSeedIDS
  adjustFrame = 0
 end

 gui.text(2, 1, "Mode: "..mode[index])
 gui.text(95, 1, "<- 1 - 2 ->")

 if mode[index] == "Capture" then
  start = 0x020243E8 + monInfo
  moveStart = 0x02023D8C + monInfo
  ppStart = 0x02023DA4 + monInfo
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

  prevKey = key

  battleScreen = mdword(0x0600D000) ~= 0
  status = mbyte(wildStart + 80)
  HPcurrent = mword(wildStart + 86)
  HPmax = mword(wildStart + 88)
  ballSelector = mword(0x0203CB48 + battleSeedInfo)
  isBallSelected = ballSelector > 0 and ballSelector <= 0xC
  if ballSelector > 0 and ballSelector <= 0xC then
   bonusBall = ball[ballSelector + 1]
  else
   bonusBall = 0
  end
  species = mword(0x0202370C + monInfo) + 1
  bagScreen = screenCheck == 0x0F020E00
  safariZone = mword(0x02039D1A + battleSeedInfo) ~= 0

  if species > 252 then
   species = species - 25
  end

  if status == 0 then
   bonusStatus = 1
  elseif (status > 0 and status < 0x08) or status == 0x020 then
   bonusStatus = 2
  else
   bonusStatus = 1.5
  end

  if safariZone then
   bonusBall = ball[6]
   safariOffset = 80
   rate = floor((1275 * mbyte(mdword(0x02024140 + monInfo) + 0x7C)) / 100)
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
   if mbyte(0x0200558C) == 0x40 and not oneTime then
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

  if catchDelay > 0 and a > 0 and (battleScreen or isBallSelected) and ((bonusBall ~= 0 and bagScreen) or safariZone) then
   sureCatchDelay = findSureCatch(catchSeed, b, safariZone) - 1
   if safariZone then
    sureCatchDelay = sureCatchDelay / 2
   end
   gui.text(2, 111, "100% catch missing frames: "..sureCatchDelay)
  end
 elseif mode[index] == "Breeding" then
  partyCounter = mbyte(0x0202418D + monInfo) - 1
  eggPartyPidStart = partyStart + (partyCounter) * 0x64
  start = eggPartyPidStart
 elseif mode[index] == "Pokemon Info" then
  partyScreen = screenCheck == 0x0A030100
  partyCursor = mbyte(0x0203CB9D + battleSeedInfo)
  boxNum = mbyte(mdword(boxPointerAddr))
  boxStart = mdword(boxPointerAddr) + 4
  boxPosition = mbyte(0x02039A19 + eggInfo)
  boxPidStart = boxStart + (0x1E * boxNum * 0x50) + (boxPosition * 0x50)
  boxCheck = mdword(currentBoxPidSelected) == mdword(boxPidStart) and screenCheck == 0x080B0101 + boxCheckOff

  if boxCheck and not partyScreen then
   start = boxPidStart
  elseif partyScreen then
   if partyCursor ~= 0x7 then
    start = partyStart + partyCursor * 0x64
   end
  elseif statsScreen then
   if mdword(0x0200E808) == mdword(0x0200E878) and  mdword(0x0200E804) ~= 0 then
    start = 0x0200E808
    moveStart = 0x0200E880
   elseif mdword(0x02002FE0 + startBoxInfo) == mdword(0x02003050 + startBoxInfo) and mdword(0x02002FDC + startBoxInfo) ~= 0 then  -- 1st floor box / party check
    start = 0x02002FE0 + startBoxInfo
    moveStart = 0x02003058 + startBoxInfo
   else  -- 2nd floor box / daycare box check
    start = 0x0200001C
    moveStart = 0x02000094
   end
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
  idsPointer = mdword(0x03005AF0 + pointers) + 0xA
  ids = mdword(idsPointer)
  tid = ids % 0x10000
  sid = floor(ids / 65536)
 end

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

 gui.text(2, 1, "Mode: "..mode[index])

 if mode[index] == "Capture" then
  battleScreen = mdword(0x0600D000) ~= 0
  roamerPointer = mdword(0x03005AEC + pointers) + 0x31E0
  roamerCheck = mdword(roamerPointer)

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
   gui.text(178, 70, "Nature: "..naturename[(roamerCheck % 25) + 1])
  end

  showRngInfo()
  showTrainerInfo()
 elseif mode[index] == "Breeding" then
  a = mdword(0x03005AE4 + pointers)
  timer = mdword(0x030022E4 + eggInfo2)
  offset = (frame - adjustFrame) - timer
  eggPidPointer = mdword(eggPidPointerAddr) + 0x988
  eggPid = mdword(eggPidPointer)
  eggNature = eggPid % 0x19
  tempEggPID = mdword(0x03007D98)
  eggStepCounter = mbyte(eggPidPointer - 0x4)

  if mdword(eggPidPointerAddr) > 0 then
   eggCheck = mdword(eggPidPointerAddr) - 0x1540
  end

  eggReady = mbyte(eggCheck) == 0x4E or mbyte(eggCheck) == 0x7E
  gui.text(2, 77, "Step Counter: "..eggStepCounter)

  if a == 0 then
   base = offset
   iter = 0
  elseif a > 0 then
   if base == base and iter < 1 then
    iter = offset - base - 5
   else
    base = offset
   end
  end

  if a == 0 then
   if not eggReady then
    gui.text(2, 97, "No Egg")
   else
    gui.text(2, 97, string.format("Egg PID: "))

	if shinyCheck(tid, sid, eggPid) then
     gui.text(38, 97, string.format("%08X", eggPid), "green")
    else
     gui.text(38, 97, string.format("%08X", eggPid))
    end

	gui.text(2, 107, "Nature: "..naturename[eggNature + 1])
   end
  elseif a < 65536 then
    gui.text(2, 97, string.format("Egg Generating... please advance another frame!"))
    gui.text(2, 107, string.format("TempRNG seeded, no temporary PID testing yet..."))
  elseif floor(tempEggPID / 65536) == floor(a / 65536) then
   gui.text(2, 97, string.format("Egg Generating... please advance another frame!"))
   gui.text(2, 107, string.format("TempPID %08X", tempEggPID))
  elseif eggReady then
   gui.text(2, 97, string.format("Egg PID: "))

   if shinyCheck(tid, sid, eggPid) then
    gui.text(38, 97, string.format("%08X", eggPid), "green")
   else
    gui.text(38, 97, string.format("%08X", eggPid))
   end

   gui.text(2, 107, "Nature: "..naturename[eggNature + 1])

   if iter > 1 then
    gui.text(100, 97, string.format("Approx iter: %d", iter))
    gui.text(100, 107, string.format("Stone worked!"))
   else
    gui.text(100, 97, string.format("First egg PID result"))
    gui.text(100, 107, string.format("Stone failed?"))
   end
  end

  if eggReady then
   gui.text(2, 87, "Egg generated, go get it!")
  elseif eggStepCounter == 254 then
   gui.text(2, 87, "Next step might generate an egg!")
  elseif eggStepCounter == 255 then
   gui.text(2, 87, "255th step taken")
  else
   gui.text(2, 87, "Keep on steppin'")
   gui.text(2, 97, "No Egg")
  end

  if isEgg then
   showStats()
   showHiddenInfo()
  end

  showRngInfo()
  showTrainerInfo()
 elseif mode[index] == "Pandora" then
  gui.text(2, 152, "TempTID: "..initSeed)
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

  if statsScreen and not isEgg then
   showMoves()
  end
 end

 emu.frameadvance()
end
