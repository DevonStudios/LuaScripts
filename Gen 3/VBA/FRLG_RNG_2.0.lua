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
 0, 45, 45, 45, 45, 45, 45, 45,
 45, 45, 255, 120, 45, 255, 120, 45,
 255, 120, 45, 255, 127, 255, 90, 255,
 90, 190, 75, 255, 90, 235, 120, 45,
 235, 120, 45, 150, 25, 190, 75, 170,
 50, 255, 90, 255, 120, 45, 190, 75,
 190, 75, 255, 50, 255, 90, 190, 75,
 190, 75, 190, 75, 255, 120, 45, 200,
 100, 50, 180, 90, 45, 255, 120, 45,
 190, 60, 255, 120, 45, 190, 60, 190,
 75, 190, 60, 45, 190, 45, 190, 75,
 190, 75, 190, 60, 190, 90, 45, 45,
 190, 75, 225, 60, 190, 60, 90, 45,
 190, 75, 45, 45, 45, 190, 60, 120,
 60, 30, 45, 45, 225, 75, 225, 60,
 225, 60, 45, 45, 45, 45, 45, 45,
 45, 255, 45, 45, 35, 45, 45, 45,
 45, 45, 45, 45, 45, 45, 45, 25,
 3, 3, 3, 45, 45, 45, 3, 45,
 -- Gen 2
 45, 45, 45, 45, 45, 45, 45, 45, 45, 255,
 90, 255, 90, 255, 90, 255, 90, 90, 190, 75,
 190, 150, 170, 190, 75, 190, 75, 235, 120, 45,
 45, 190, 75, 65, 45, 255, 120, 45, 45, 235,
 120, 75, 255, 90, 45, 45, 30, 70, 45, 225,
 45, 60, 190, 75, 190, 60, 25, 190, 75, 45,
 25, 190, 45, 60, 120, 60, 190, 75, 225, 75,
 60, 190, 75, 45, 25, 25, 120, 45, 45, 120,
 60, 45, 45, 45, 75, 45, 45, 45, 45, 45,
 30, 3, 3, 3, 45, 45, 45, 3, 3, 45,
 -- Gen 3
 45, 45, 45, 45, 45, 45, 45, 45, 45,
 255, 127, 255, 90, 255, 120, 45, 120, 45,
 255, 120, 45, 255, 120, 45, 200, 45, 190,
 45, 235, 120, 45, 200, 75, 255, 90, 255,
 120, 45, 255, 120, 45, 190, 120, 45, 180,
 200, 150, 255, 255, 60, 45, 45, 180, 90,
 45, 180, 90, 120, 45, 200, 200, 150, 150,
 150, 225, 75, 225, 60, 125, 60, 255, 150,
 90, 255, 60, 255, 255, 120, 45, 190, 60,
 255, 45, 90, 90, 45, 45, 190, 75, 205,
 155, 255, 90, 45, 45, 45, 45, 255, 60,
 45, 200, 225, 45, 190, 90, 200, 45, 30,
 125, 190, 75, 255, 120, 45, 255, 60, 60,
 25, 225, 45, 45, 45, 3, 3, 3, 3,
 3, 3, 3, 3, 5, 5, 3, 3, 3}

local ball = {"0", "255", "2", "1.5", "1", "1.5", "1", "1", "1", "1", "1", "1", "1"}

local mode = {"None", "Capture", "100% Catch", "Breeding", "Pandora", "Pokemon Info"}
local index = 1
local gameLang = mbyte(0x080000AF)
local gameVersion = mbyte(0x080000AE)
local language
local monInfo
local pointers
local eggInfo
local statscreenInfo
local statscreenInfo2 
local boxcheckOff
local startboxInfo
local startboxInfo2
local partyselectionInfo
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
 pointers = 0
 eggInfo = 0
 statscreenInfo = 0
 statscreenInfo2 = 0
 boxcheckOff = 0
 startboxInfo = 0
 startboxInfo2 = 0
 partyselectionInfo = 0
elseif gameLang == 0x45 then
 language = "USA"
 monInfo = 0xA0
 pointers = 0x60
 eggInfo = 0xB4
 boxcheckOff = 0xFFFF00
 statscreenInfo = 0x84
 statscreenInfo2 = 0x34
 startboxInfo = 0x54
 startboxInfo2 = 0x88
 partyselectionInfo = 0x8C
else
 language = "EUR"
 monInfo = 0xA0
 pointers = -0x50
 eggInfo = 0xB4
 boxcheckOff = 0xFFFF00
 statscreenInfo = 0x84
 statscreenInfo2 = 0x34
 startboxInfo = 0x54
 startboxInfo2 = 0x88
 partyselectionInfo = 0x8C
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

if game ~= "FireRed" and game ~= "LeafGreen" then
 warning = " - Wrong game version! Use FireRed/LeafGreen instead"
else
 warning = ""
end

print("New Order of Breeding x Real.96")
print()
print("Game Version: "..game..warning)
print("Language: "..language)

local eggpidpointerAddr = 0x020397E0 + eggInfo
local eggCheck = 0x020397D8 + eggInfo
local partyStart = 0x020241E4 + monInfo
local boxpointerAddr = 0x03004FB0 + pointers
local currentboxpidSelected = 0x020396FC + eggInfo
local wildStart = 0x02023F8C + monInfo
local start = 0x02023F8C + monInfo
local moveStart = 0x02023BA8 + monInfo
local ppStart = 0x02023BC0 + monInfo
local boxCheck = false
local initSeed = 0
local currSeed = 0
local tempInit = 0
local tempCurr = 0
local frame = 0
local key = {}
local prevKey = {}
local catchKey = {}
local catchInstructions = false
local catchDelay = -1
local j = 0
local bonusStatus = 1
local skips = 0
local seed2 = 0
local seed3 = 0
local frameDelay = 0
local oneTime = false
local safariOffset = 0
local safarirateOffset = 0

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

function findcatchSeed(s, d)
 local t = s
 for i = 1, d do
  t = next(t)
 end
 return t
end

function findsureCatch(s, b, sz)
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

function showhiddenInfo()
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

function showrngInfo()
 gui.text(2, 122, frame)
 gui.text(1, 132, "Initial Seed: "..string.format("%04X", initSeed))
 gui.text(2, 142, "Current Seed: "..string.format("%08X", currSeed))
end

function showtrainerInfo()
 gui.text(199, 142, string.format("TID: %d", tid))
 gui.text(199, 152, string.format("SID: %d", sid))
end

while true do
 initSeed = mword(0x02020000)
 currSeed = mdword(0x03004FA0 + pointers)
 screenCheck = mdword(0x02020430 + statscreenInfo)
 statsScreen = screenCheck == 0x0D000001 or screenCheck == 0x0D000002

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

 if initSeed == currSeed or initSeed ~= tempInit then
  tempCurr = initSeed
  tempInit = initSeed
  frame = 0
 end

 tempCurr = next(tempCurr)
 frame = frame + calcFrameJump()

 if mode[index] == "Capture" then
  start = 0x02023F8C + monInfo
  moveStart = 0x02023BA8 + monInfo
  ppStart = 0x02023BC0 + monInfo
 elseif mode[index] == "Breeding" then
  partyCounter = mbyte(0x02023F89 + monInfo) - 1
  eggpartypidStart = partyStart + (partyCounter) * 0x64
  start = eggpartypidStart
 elseif mode[index] == "Pokemon Info" then
  partyScreen = screenCheck == 0x0A030100
  partyCursor = mbyte(0x0203B01D + partyselectionInfo)
  boxNum = mbyte(mdword(boxpointerAddr))
  boxStart = mdword(boxpointerAddr) + 4
  boxPosition = mbyte(0x0203976D + eggInfo)
  boxpidStart = boxStart + (0x1E * boxNum * 0x50) + (boxPosition * 0x50)
  boxCheck = mdword(mdword(currentboxpidSelected) + 0xCDC) == mdword(boxpidStart) and screenCheck == 0x080B0101 + boxcheckOff
  
  if boxCheck and not partyScreen then
   start = boxpidStart
  elseif partyScreen then
   if partyCursor ~= 0x7 then
    start = partyStart + partyCursor * 0x64
   end
  elseif statsScreen then
   if mdword(0x0201196C + startboxInfo) == 0 and  mdword(0x020032A8 + statscreenInfo2) == 0 then
    start = 0x02011970 + startboxInfo
    moveStart = 0x02011938 + startboxInfo
   elseif mdword(0x02003250 + statscreenInfo2) == 0 then  -- 1st floor box / party check
    start = 0x02006410 + startboxInfo2
    moveStart = 0x020063D8 + startboxInfo2
   else  -- 2nd floor box / daycare box check
    start = 0x0200324C + startboxInfo
    moveStart = 0x02003214 + startboxInfo
   end
  end
 end

 personality = mdword(start)
 trainerid = mdword(start + 4)
 isEgg = mword(start + 0x12) == 0x0601
 magicword = bxor(personality, trainerid)

 if mode[index] == "Pokemon Info" then
  tid = trainerid % 0x10000
  sid = floor(trainerid / 65536)
 else
  idsPointer = mdword(0x03004FAC + pointers) + 0xA
  ids = mdword(idsPointer)
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

 gui.text(2, 1, "Mode: "..mode[index])
 gui.text(95, 1, "<- 1 - 2 ->")

 if mode[index] == "Capture" then
  battleScreen = mdword(0x0600D000) ~= 0
  roamerPointer = mdword(0x03004FA8 + pointers) + 0x30D4
  roamerCheck = mdword(roamerPointer)

  if battleScreen and not statsScreen then
   showStats()
   showhiddenInfo()
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

  showrngInfo()
  showtrainerInfo()
 elseif mode[index] == "100% Catch" then
  if catchInstructions then
   gui.text(155, 1, "3 - hide instructions")
   gui.text(2, 11, "1) During battle, go to BAG > POKE BALLS")
   gui.text(2, 21, "2) Press A on the ball you want to use")
   gui.text(2, 31, "3) Move the arrow on 'USE', pause the game and save a state")
   gui.text(2, 41, "4) Advance one frame holding SELECT and then unpause the")
   gui.text(2, 51, "game holding A. Delay will be calculated")
   gui.text(2, 61, "5) Load the state you made, advance frames until counter")
   gui.text(2, 71, "become 0")
   gui.text(2, 81, "6) Unpase the game holding A")
  else
   gui.text(155, 1, "4 - show instructions")
  end
  
  prevKey = key

  battleScreen = mdword(0x0600D000) ~= 0
  status = mbyte(wildStart + 80)
  HPcurrent = mword(wildStart + 86)
  HPmax = mword(wildStart + 88)
  ballSelector = mbyte(0x0203ACA8 + startboxInfo2)
  if ballSelector > 0 and ballSelector <= 0xC then
   bonusBall = ball[ballSelector + 1]
  else
   bonusBall = 0
  end
  species = mword(0x02023528 + monInfo)
  bagScreen = screenCheck == 0x12010B00
  safariZone = mword(0x0203990E + startboxInfo2) ~= 0

  if species == 410 then
   species = 386
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
   if catchRate[species + 1] == 30 then
    safarirateOffset = 5
   elseif catchRate[species + 1] == 45 then
    safarirateOffset = 7
   elseif catchRate[species + 1] == 60 or catchRate[species + 1] == 225 then
    safarirateOffset = 9
   elseif catchRate[species + 1] == 75 or catchRate[species + 1] == 190 then
    safarirateOffset = 12
   elseif catchRate[species + 1] == 90 then
    safarirateOffset = 1
   elseif catchRate[species + 1] == 120 or catchRate[species + 1] == 235 then
    safarirateOffset = 6
   end
  else
   safariOffset = 0
   safarirateOffset = 0
  end

  a = floor(((((3*HPmax)-(2*HPcurrent))*(catchRate[species+1]-safarirateOffset)*bonusBall)/(3*HPmax))*bonusStatus)
  b = floor(1048560 / (sqrt(sqrt(16711680 / a))))

  catchKey = joypad.get(1)
  if catchKey.select then
   startingFrame = frame
   j = 0
   catchDelay = 0
   skips = 0
   oneTime = false
   seed2 = currSeed
   frameDelay = 0
  end
  
  if j <= 150 and catchDelay == 0 then
   if mbyte(0x020054C4) == 0x40 and not oneTime then
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

   if skips == 3 and frameDelay > 120 - safariOffset then  -- 0 shake
    catchDelay = frameDelay
   elseif skips == 4 and frameDelay > 120 - safariOffset then  -- 1 shake
    catchDelay = frameDelay - 1
   elseif skips == 5 and frameDelay > 120 - safariOffset then  -- 2 shake
    catchDelay = frameDelay - 2
   elseif skips == 6 and frameDelay > 120 - safariOffset then  -- 3 shake
    catchDelay = frameDelay - 3
   end
   j = j + 1
  end

  if catchDelay <= 0 then
   gui.text(2, 101, "Delay not calculated yet")
  else
   gui.text(2, 101, "Delay calculated")
  end

  catchSeed = findcatchSeed(currSeed, catchDelay)
  
  if catchDelay > 0 and a > 0 and battleScreen and ((bonusBall ~= 0 and bagScreen) or safariZone) then
   surecatchDelay = findsureCatch(catchSeed, b, safariZone) - 1
   if safariZone then
    surecatchDelay = surecatchDelay / 2
   end
   gui.text(2, 111, "100% catch missing frames: "..surecatchDelay)
  end
 elseif mode[index] == "Breeding" then
  eggpidPointer = mdword(eggpidpointerAddr) + 0x2CE0
  eggstepCounter = mbyte(eggpidPointer - 0x4)
  eggReady = mbyte(mdword(eggCheck) + 0xC1C) == 0xF8
  gui.text(2, 77, "Step Counter: "..eggstepCounter)

  if eggReady then
   egglowPid = mword(eggpidPointer)
   gui.text(2, 87, "Egg generated, go get it!")
   gui.text(2, 97, string.format("Egg lower PID: %04X", egglowPid))
  elseif eggstepCounter == 254 then
   gui.text(2, 87, "Next step might generate an egg!")
  elseif eggstepCounter == 255 then
   gui.text(2, 87, "255th step taken")
  else
   gui.text(2, 87, "Keep on steppin'")
  end

  if not eggReady then
   gui.text(2, 97, "No Egg")
  end

  if isEgg then
   showStats()
   showhiddenInfo()
  end

  showrngInfo()
  showtrainerInfo()
 elseif mode[index] == "Pandora" then
  gui.text(2, 152, "TempTID: "..initSeed)
  showrngInfo()
  showtrainerInfo()
 elseif mode[index] == "Pokemon Info" then
  if (partyScreen and partyCursor ~= 0x7) or statsScreen or boxCheck then
   if not boxCheck then
    showStats()
   end
   showhiddenInfo()
   showtrainerInfo()
  end

  if statsScreen and not isEgg then
   showMoves()
  end
 end

 if mode[index] ~= "100% Catch" then
  catchInstructions = false
 end

 emu.frameadvance()
end
