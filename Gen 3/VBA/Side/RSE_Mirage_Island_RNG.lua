mdword = memory.readdwordunsigned
mword = memory.readwordunsigned
mbyte = memory.readbyte
rshift = bit.rshift
lshift = bit.lshift
band = bit.band
bor = bit.bor

local gameVersion = mbyte(0x080000AE)
local game
local gameLang = mbyte(0x080000AF)
local language = ""
local warning

local saveBlockPointer
local selectedBoxPID

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

if game == "Ruby" or game == "Sapphire" then
 if gameLang == 0x4A then  -- Check game language
  language = "JPN"
  saveBlockPointer = 0x0201E7D4
  selectedBoxPID = 0x02000C1C
 else
  language = "USA/EUR"
  saveBlockPointer = 0x0201EA74
  selectedBoxPID = 0x020011EC
 end
elseif game == "Emerald" then
 if gameLang == 0x4A then
  language = "JPN"
  saveBlockPointer = 0x03005AEC
  selectedBoxPID = 0x02003CB4
 else
  language = "USA/EUR"
  saveBlockPointer = 0x03005D8C
  selectedBoxPID = 0x02003F7C
 end
end

if game ~= "Ruby" and game ~= "Sapphire" and game ~= "Emerald" then
 warning = " - Wrong game version! Use Ruby/Sapphire/Emerald instead"
else
 warning = ""
end

print("Devon Studios x Real.96")
print()
print("Game Version: "..game..warning)
print("Language: "..language)

function next(s, mul1, mul2, sum)
 local a = mul1 * (s % 65536) + rshift(s, 16) * mul2
 local b = mul2 * (s % 65536) + (a % 65536) * 65536 + sum
 local c = b % 4294967296

 return c
end

function getCurrMirageIslandSeed()
 local mirageSeedPointer
 local off

 if game == "Emerald" then
  mirageSeedPointer = mdword(saveBlockPointer)
  off = 0x6C64
 else
  mirageSeedPointer = saveBlockPointer
  off = 0
 end

 local mirageHighSeed = mword(mirageSeedPointer + (2 * 0x4024) - off)
 local mirageLowSeed = mword(mirageSeedPointer + (2 * 0x4025) - off)

 return bor(lshift(mirageHighSeed, 16), mirageLowSeed)
end

function findMirageIsland(currMirageSeed)
 local pid = mdword(selectedBoxPID)
 local lowPID = band(pid, 0xFFFF)
 local days = 0

 while lowPID ~= rshift(currMirageSeed, 16) and days <= 10000 do
  currMirageSeed = next(currMirageSeed, 0x41C6, 0x4E6D, 0x3039)
  days = days + 1
 end

 if lowPID ~= rshift(currMirageSeed, 16) then
  days = 0
  currMirageSeed = 0
 end

 return {days, currMirageSeed}
end

while warning == "" do
 mirageSeed = getCurrMirageIslandSeed()
 mirageValue = rshift(mirageSeed, 16)
 mirageDaysAndSeed = findMirageIsland(mirageSeed)

 gui.text(0, 115, string.format("Mirage Island Value: %04X", mirageValue))
 gui.text(0, 125, string.format("Mirage Island Seed: %08X", mirageSeed))
 gui.text(0, 135, string.format("Selected Pokemon PID: %08X", mdword(selectedBoxPID)))
 gui.text(0, 145, string.format("Days to advance for Mirage Island: %d (%08X)", mirageDaysAndSeed[1], mirageDaysAndSeed[2]))

 emu.frameadvance()
end