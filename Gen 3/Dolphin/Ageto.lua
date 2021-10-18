read32Bit = ReadValue32

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

local prngAddr
local initSeed
local tempCurr
local advances
local initSet
local prevInitSeed

function LCRNG(s, mul1, mul2, sum)
 local a = mul1 * (s % 0x10000) + (s >> 16) * mul2
 local b = mul2 * (s % 0x10000) + (a % 0x10000) * 0x10000 + sum
 local c = b % 4294967296

 return c
end

function getInitialSeed(current)
 if initSet == 2 then
  initSeed = current
  tempCurr = initSeed
  advances = 0
 end
end

function calcAdvancesJump(seed)
 local calibrationAdvances = 0

 if tempCurr ~= seed then
  local tempCurr2 = tempCurr

  while tempCurr ~= seed and tempCurr2 ~= seed do
   tempCurr = LCRNG(tempCurr, 0x3, 0x43FD, 0x269EC3)
   tempCurr2 = LCRNG(tempCurr2, 0xB9B3, 0x3155, 0xA170F641)
   calibrationAdvances = calibrationAdvances + 1

   if calibrationAdvances > 999999 then
    initSeed = 0
	initSet = 0
    tempCurr = seed
	prevInitSeed = 0
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

function getIVs(iv1, iv2)
 local ivs = {0, 0, 0, 0, 0, 0}

 ivs[1] = iv1 & 0x1F
 ivs[2] = (iv1 >> 5) & 0x1F
 ivs[3] = (iv1 >> 10) & 0x1F
 ivs[4] = (iv2 >> 5) & 0x1F
 ivs[5] = (iv2 >> 10) & 0x1F
 ivs[6] = iv2 & 0x1F

 return ivs
end

function getHP(ivs)
 local hpType = ((ivs[1]%2 + 2*(ivs[2]%2) + 4*(ivs[3]%2) + 8*(ivs[6]%2) + 16*(ivs[4]%2) + 32*(ivs[5]%2))*15) // 63
 local hpBase = (((ivs[1]&2)/2 + (ivs[2]&2) + 2*(ivs[3]&2) + 4*(ivs[6]&2) + 8*(ivs[4]&2) + 16*(ivs[5]&2))*40) // 63 + 30

 hiddenPower = string.format("HPower: %s %02d", HPTypeNamesList[hpType + 1], hpBase)

 return hiddenPower
end

function getPID(seed)
 local trainerID = 31121
 local trainerSID = 0
 seed = LCRNG(seed, 0x3, 0x43FD, 0x269EC3)
 local highPID = seed >> 16
 seed = LCRNG(seed, 0x3, 0x43FD, 0x269EC3)
 local lowPID = seed >> 16

 while (trainerID ~ trainerSID ~ highPID ~ lowPID) < 8 do
  seed = LCRNG(seed, 0x3, 0x43FD, 0x269EC3)
  highPID = seed >> 16
  seed = LCRNG(seed, 0x3, 0x43FD, 0x269EC3)
  lowPID = seed >> 16
 end

 return (highPID << 16) + lowPID
end

function getCelebiStats(seed)
 for i = 1, 23 do
  seed = LCRNG(seed, 0x3, 0x43FD, 0x269EC3)
 end

 local iv1 = seed >> 16
 seed = LCRNG(seed, 0x3, 0x43FD, 0x269EC3)
 local iv2 = seed >> 16
 seed = LCRNG(seed, 0x3, 0x43FD, 0x269EC3)
 local ability = (seed >> 16) & 1
 local pid = getPID(seed)
 local nature = natureNamesList[(pid % 25) + 1]

 local ivs = getIVs(iv1, iv2)
 local stats = "\nCelebi Stats:\n"
 stats = stats..string.format("PID: %08X\nNature: %s\nIVs: %02d", pid, nature, ivs[1])

 for i = 2, 6 do
  stats = stats.."/"..string.format("%02d", ivs[i])
 end

 local hiddenPower = getHP(ivs)
 stats = stats.."\n"..hiddenPower

 return stats
end

function onScriptStart()
 prngAddr = 0x477098
 initSeed = 0
 tempCurr = 0
 advances = 0
 initSet = 0
 prevInitSeed = 0
end

function onScriptUpdate()
 currSeed = read32Bit(prngAddr)

 if initSeed == 0 and prevInitSeed ~= currSeed then
  initSet = initSet + 1
  getInitialSeed(currSeed)
  prevInitSeed = currSeed
 end

 if initSeed ~= 0 then
  advances = advances + calcAdvancesJump(currSeed)
 end

 celebiStats = getCelebiStats(currSeed)

 text = "Visual Advances: "..GetFrameCount()
 text = text..string.format("\n\nInitial Seed: %08X\nCurrent Seed: %08X\nAdvances: %d\n%s", initSeed, currSeed, advances, celebiStats)
 SetScreenText(text)
end

function onScriptCancel()
 SetScreenText("")
end

function onStateLoaded()
end

function onStateSaved()
end