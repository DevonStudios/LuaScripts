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

function getInitialSeed()
 initSeed = ReadValue32(seedAddrs)
 tempSeed = initSeed
 frame = 0
end

function calcFrameJump()
 local calibrationFrame = 0

 if tempSeed ~= currSeed then
  local tempSeed2 = tempSeed

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

 hiddenPower = string.format("HP: %s %02d", hpTypeName[hpType + 1], hpBase)

 return hiddenPower
end

function getPID(seed)
 local trainerID = 31121
 local trainerSID = 0
 seed = next(seed)
 local highPID = seed >> 16
 seed = next(seed)
 local lowPID = seed >> 16

 while (trainerID ~ trainerSID ~ highPID ~ lowPID) < 8 do
  seed = next(seed)
  highPID = seed >> 16
  seed = next(seed)
  lowPID = seed >> 16
 end

 return (highPID << 16) + lowPID
end

function getCelebiStats(seed)
 for i = 1, 23 do
  seed = next(seed)
 end

 local iv1 = seed >> 16
 seed = next(seed)
 local iv2 = seed >> 16
 seed = next(seed)
 local ability = (seed >> 16) & 1
 local pid = getPID(seed)
 local nature = natureName[(pid % 25) + 1]

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
 seedAddrs = 0x477098
 initSeed = 0
 currSeed = 0
 tempSeed = 0
 frame = 0
end

function onScriptUpdate()
 if initSeed == 0 then
  getInitialSeed()
 end

 currSeed = ReadValue32(seedAddrs)
 frame = frame + calcFrameJump()
 celebiStats = getCelebiStats(currSeed)

 text = "Visual Frame: "..GetFrameCount()
 text = text..string.format("\n\nInitial Seed: %08X\nCurrent Seed: %08X\nFrame: %d\n%s", initSeed, currSeed, frame, celebiStats)
 SetScreenText(text)
end

function onScriptCancel()
 SetScreenText("")
end

function onStateLoaded()

end

function onStateSaved()

end