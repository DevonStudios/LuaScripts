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

function claclFrameJump()
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

function getIVs(seed)
 local ivs = {0, 0, 0, 0, 0, 0}

 for i = 1, 4 do
  seed = next(seed)
 end

 ivs[1] = (seed >> 16) >> 11
 seed = next(seed)
 ivs[2] = (seed >> 16) >> 11
 seed = next(seed)
 ivs[3] = (seed >> 16) >> 11
 seed = next(seed)
 ivs[6] = (seed >> 16) >> 11
 seed = next(seed)
 ivs[4] = (seed >> 16) >> 11
 seed = next(seed)
 ivs[5] = (seed >> 16) >> 11

 return ivs
end

function getHP(ivs)
 local hpType = ((ivs[1]%2 + 2*(ivs[2]%2) + 4*(ivs[3]%2) + 8*(ivs[6]%2) + 16*(ivs[4]%2) + 32*(ivs[5]%2))*15) // 63
 local hpBase = (((ivs[1]&2)/2 + (ivs[2]&2) + 2*(ivs[3]&2) + 4*(ivs[6]&2) + 8*(ivs[4]&2) + 16*(ivs[5]&2))*40) // 63 + 30

 hiddenPower = string.format("HP: %s %02d", hpTypeName[hpType + 1], hpBase)

 return hiddenPower
end

function getJirachiStats(seed)
 --local tid = 40122
 seed = next(seed)
 local sid = seed >> 16
 seed = next(seed)
 local high = seed >> 16
 seed = next(seed)
 local low = seed >> 16

 if low > 7 and 0 or 1 ~= (high ~ 40122 ~ sid) then
  high = high ~ 0x8000
 end

 local pid = (high << 16) + low
 local ability = low & 1
 local nature = natureName[(pid % 25) + 1]

 local ivs = getIVs(seed)
 local stats = "\nJirachi Stats:\n"
 stats = stats..string.format("PID: %08X\nNature: %s\nIVs: %02d", pid, nature, ivs[1])

 for i = 2, 6 do
  stats = stats.."/"..string.format("%02d", ivs[i])
 end

 local hiddenPower = getHP(ivs)
 stats = stats.."\n"..hiddenPower

 return stats
end

function onScriptStart()
 seedAddrs = 0x33D888
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
 frame = frame + claclFrameJump()
 jirachiStats = getJirachiStats(currSeed)

 text = string.format("Initial Seed: %08X\nCurrent Seed: %08X\nFrame: %d\n%s", initSeed, currSeed, frame, jirachiStats)
 SetScreenText(text)
end

function onScriptCancel()
 SetScreenText("")
end

function onStateLoaded()

end

function onStateSaved()

end