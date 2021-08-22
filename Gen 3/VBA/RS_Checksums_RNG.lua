mdword = memory.readdwordunsigned
mword = memory.readwordunsigned
mbyte = memory.readbyte
bxor = bit.bxor

local gameVersion = mbyte(0x080000AE)
local game
local gameLang = mbyte(0x080000AF)
local language = ""
local warning

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

if gameLang == 0x4A then  -- Check game language
 language = "JPN"
elseif gameLang == 0x45 then
 language = "USA"
else
 language = "EUR"
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

local time = 0x02F64EB3
local mode = {"Jirachi", "10th Anniv/Aura Mew"}
local index = 1
local prevKey = {}
local leftArrowColor
local rightArrowColor

local savePath = "D:\\Desktop\\VBA RNG v23.5\\battery\\Pokemon - Ruby Version (USA, Europe) (Rev 2).sav"
local targetSeed = 0x4A4
local targetHour = 0
local targetMinute = 9
local targetSecond = 55
local targetSixtiethSecond = 3
local delaySecond = 1
local delaySixtiethSecond = 46
local baseHour = targetHour
local baseMinute = targetMinute
local baseSecond = targetSecond
local baseSixtiethSecond = targetSixtiethSecond

baseSixtiethSecond = baseSixtiethSecond - delaySixtiethSecond

if baseSixtiethSecond < 0 then
 baseSixtiethSecond = 60 + baseSixtiethSecond
 baseSecond = baseSecond - 1

 if baseSecond < 0 then
  baseSecond = 60 + baseSecond
  baseMinute = baseMinute - 1

  if baseMinute < 0 then
   baseMinute = 60 + baseMinute
   baseHour = baseHour - 1
  end
 end
end

baseSecond = baseSecond - delaySecond

if baseSecond < 0 then
 baseSecond = 60 + baseSecond
 baseSecond = baseSecond - 1

 if baseSecond < 0 then
  baseSecond = 60 + baseSecond
  baseMinute = baseMinute - 1

  if baseMinute < 0 then
   baseMinute = 60 + baseMinute
   baseHour = baseHour - 1
  end
 end
end

function getInput()
 leftArrowColor = "gray"
 rightArrowColor = "gray"

 local key = input.get()

 if key["1"] and not prevKey["1"] then
  leftArrowColor = "orange"
  index = index - 1
  if index < 1 then
   index = 2
  end
 elseif key["2"] and not prevKey["2"] then
  rightArrowColor = "orange"
  index = index + 1
  if index > 2 then
   index = 1
  end
 end

 prevKey = key
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

function isSeedGenerated()
 return mdword(0x0E000FF8) ~= 0
end

function getSaveBlockSeedAddr()
 local startingCheckSeed = 0x0E0022F6
 local addOffset = 0x1000

 while mdword(startingCheckSeed) ~= 0x1000 and addOffset <= 0xF000 do
  startingCheckSeed = startingCheckSeed + addOffset
  addOffset = addOffset + 0x1000
 end

 local saveBlockSeedAddr = startingCheckSeed - 0x1300

 return saveBlockSeedAddr
end

function getAllChecksums()
 local saveFile = assert(io.open(savePath, "rb"))
 local bytes = saveFile:read(0x20000)
 saveFile:close()
 local saveBlockStart = 0xFF7
 local saveBlockChecksums = {}

 for i = 0, 0x1F000, 0x1000 do
  checkSumAddr = saveBlockStart + i
  checkSum = string.format("%02X%02X", bytes:byte(checkSumAddr + 1), bytes:byte(checkSumAddr))
  checkSum = tonumber(checkSum, 16)
  table.insert(saveBlockChecksums, checkSum)
 end
 
 return saveBlockChecksums
end

function clalcXorSeed(checkSums)
 local xorSeed = 0
 
 for i = 1, table.getn(checkSums) do
  xorSeed = bxor(xorSeed, checkSums[i])
 end

 return xorSeed
end

--[[function printCheckSums(checkSums)
 local x = 145
 local y = 55
 local line = 0
 gui.text(x - 40, y - 10, "Checksums:")

 for i = 1, 32 do
  if line > 7 then
   x = x + 25
   line = line % 8
  end
  
  gui.text(x, y + (line * 10), string.format("%04X", checkSums[i]))
  line = line + 1
 end
end]]

while warning == "" do
 getInput()
 gui.text(1, 1, "Mode: "..mode[index])
 drawArrowLeft(110, 1, leftArrowColor)
 gui.text(120, 1, "1 - 2")
 drawArrowRight(148, 1, rightArrowColor)

 hour = string.format("%02d", mword(0x02024EB2))
 minute = string.format("%02d", mbyte(time + 0x01))
 second = string.format("%02d", mbyte(time + 0x02))
 sixtiethSecond = string.format("%02d", mbyte(time + 0x03))

 currSeed = mdword(0x03004818)

 tid = mword(0x2024EAE)
 sid = mword(0x2024EB0)

 gui.text(1, 15, string.format("Time: %02d:%02d:%02d:%02d", hour, minute, second, sixtiethSecond))
 gui.text(1, 25, "Visual Frame: "..vba.framecount() - 5)
 gui.text(1, 35, string.format("Current Seed: %04X", currSeed))
 gui.text(1, 55, string.format("Target Seed: %04X", targetSeed))
 gui.text(1, 65, string.format("Target Time: %02d:%02d:%02d:%02d", targetHour, targetMinute, targetSecond, targetSixtiethSecond))
 gui.text(1, 75, string.format("Delay: %02d:%02d", delaySecond, delaySixtiethSecond))
 gui.text(1, 85, string.format("Base Save Time: %02d:%02d:%02d:%02d", baseHour, baseMinute, baseSecond, baseSixtiethSecond))

 if isSeedGenerated() then
  currSaveBlockSeedAddr = getSaveBlockSeedAddr()
  firstSegmentSeed = mword(currSaveBlockSeedAddr)

  if mode[index] == "10th Anniv/Aura Mew" then
   checkSums = getAllChecksums()
   --printCheckSums(checkSums)
   actualSeed = clalcXorSeed(checkSums)
   xorTargetSeed = bxor(bxor(actualSeed, firstSegmentSeed), targetSeed)

   gui.text(1, 95, string.format("Checksum Seed: %04X", firstSegmentSeed))
   gui.text(1, 142, string.format("Actual XOR Seed: %04X", actualSeed))
   gui.text(1, 152, string.format("Target Checksum Seed: %04X", xorTargetSeed))
  else
   gui.text(1, 95, string.format("Jirachi Seed: %04X", firstSegmentSeed))
  end
 end

 gui.text(199, 142, "TID: "..tid)
 gui.text(199, 152, "SID: "..sid)

 emu.frameadvance()
end