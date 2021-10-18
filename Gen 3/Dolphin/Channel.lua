read32Bit = ReadValue32

local natureName = {
 "Hardy", "Lonely", "Brave", "Adamant", "Naughty",
 "Bold", "Docile", "Relaxed", "Impish", "Lax",
 "Timid", "Hasty", "Serious", "Jolly", "Naive",
 "Modest", "Mild", "Quiet", "Bashful", "Rash",
 "Calm", "Gentle", "Sassy", "Careful", "Quirky"}

local hpTypeName = {
 "Fighting", "Flying", "Poison", "Ground",
 "Rock", "Bug", "Ghost", "Steel",
 "Fire", "Water", "Grass", "Electric",
 "Psychic", "Ice", "Dragon", "Dark"}

local prngAddr
local initSeed
local tempCurr
local advances

function LCRNG(s, mul1, mul2, sum)
 local a = mul1 * (s % 0x10000) + (s >> 16) * mul2
 local b = mul2 * (s % 0x10000) + (a % 0x10000) * 0x10000 + sum
 local c = b % 4294967296

 return c
end

function getInitialSeed()
 initSeed = read32Bit(prngAddr)
 tempCurr = initSeed
 advances = 0
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
    tempCurr = seed
    advances = 0
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

function getIVs(seed)
 local ivs = {0, 0, 0, 0, 0, 0}

 for i = 1, 4 do
  seed = LCRNG(seed, 0x3, 0x43FD, 0x269EC3)
 end

 ivs[1] = (seed >> 16) >> 11
 seed = LCRNG(seed, 0x3, 0x43FD, 0x269EC3)
 ivs[2] = (seed >> 16) >> 11
 seed = LCRNG(seed, 0x3, 0x43FD, 0x269EC3)
 ivs[3] = (seed >> 16) >> 11
 seed = LCRNG(seed, 0x3, 0x43FD, 0x269EC3)
 ivs[6] = (seed >> 16) >> 11
 seed = LCRNG(seed, 0x3, 0x43FD, 0x269EC3)
 ivs[4] = (seed >> 16) >> 11
 seed = LCRNG(seed, 0x3, 0x43FD, 0x269EC3)
 ivs[5] = (seed >> 16) >> 11

 return ivs
end

function getHP(ivs)
 local hpType = ((ivs[1]%2 + 2*(ivs[2]%2) + 4*(ivs[3]%2) + 8*(ivs[6]%2) + 16*(ivs[4]%2) + 32*(ivs[5]%2))*15) // 63
 local hpBase = (((ivs[1]&2)/2 + (ivs[2]&2) + 2*(ivs[3]&2) + 4*(ivs[6]&2) + 8*(ivs[4]&2) + 16*(ivs[5]&2))*40) // 63 + 30

 hiddenPower = string.format("HPower: %s %02d", hpTypeName[hpType + 1], hpBase)

 return hiddenPower
end

function shinyCheck(highPID, lowPID, trainerID, trainerSID)
 local shinyType = trainerID ~ trainerSID ~ highPID ~ lowPID

 if shinyType == 0 then
  return "- Square Shiny"
 elseif shinyType < 8 then
  return "- Star Shiny"
 else
  return ""
 end
end

function getJirachiStats(seed)
 local tid = 40122
 seed = LCRNG(seed, 0x3, 0x43FD, 0x269EC3)
 local sid = seed >> 16
 seed = LCRNG(seed, 0x3, 0x43FD, 0x269EC3)
 local high = seed >> 16
 seed = LCRNG(seed, 0x3, 0x43FD, 0x269EC3)
 local low = seed >> 16

 if low > 7 and 0 or 1 ~= (high ~ tid ~ sid) then
  high = high ~ 0x8000
 end

 local pid = (high << 16) + low
 local isShiny = shinyCheck(high, low, tid, sid)
 local ability = low & 1
 local nature = natureName[(pid % 25) + 1]

 local ivs = getIVs(seed)
 local stats = "\nJirachi Stats:\n"
 stats = stats..string.format("PID: %08X %s\nNature: %s\nIVs: %02d", pid, isShiny, nature, ivs[1])

 for i = 2, 6 do
  stats = stats.."/"..string.format("%02d", ivs[i])
 end

 local hiddenPower = getHP(ivs)
 stats = stats.."\n"..hiddenPower

 return stats
end

function onScriptStart()
 prngAddr = 0x33D888
 initSeed = 0
 tempCurr = 0
 advances = 0
end

function onScriptUpdate()
 if initSeed == 0 then
  getInitialSeed()
 end

 currSeed = read32Bit(prngAddr)
 advances = advances + calcAdvancesJump(currSeed)
 jirachiStats = getJirachiStats(currSeed)

 text = string.format("Initial Seed: %08X\nCurrent Seed: %08X\nAdvances: %d\n%s", initSeed, currSeed, advances, jirachiStats)
 SetScreenText(text)
end

function onScriptCancel()
 SetScreenText("")
end

function onStateLoaded()

end

function onStateSaved()

end