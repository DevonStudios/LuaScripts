mdword = memory.read_u32_le
mword = memory.read_u16_le
mbyte = memory.readbyte
rshift = bit.rshift

local prngAddr = 0
local mtSeedAddr = 0
local initSeedHigh = 0
local initSeedLow = 0
local tempCurrLow = 0
local currSeedHigh = 0
local currSeedLow = 0
local ivsFrame = 0
local frame = 0
local initSet = 0
local idsAddr = 0

local game = ""
local language = ""
local warning = ""

console.clear()

if mbyte(0X02FFFE0F) == 0x4A then  -- Check game language
 language = "JPN"
 prngAddr = 0x021FF5B8
 mtSeedAddr = 0x021FE6C8
 idsAddr = 0x0221E398
elseif mbyte(0X02FFFE0F) == 0x4F then
 language = "USA"
 prngAddr = 0x021FFC18
 mtSeedAddr = 0x021FED28
 idsAddr = 0x0221E9F8
elseif mbyte(0X02FFFE0F) == 0x49 then
 language = "ITA"
 prngAddr = 0x021FFB18
 mtSeedAddr = 0x021FEC28
 idsAddr = 0x0221E8F8
elseif mbyte(0X02FFFE0F) == 0x44 then
 language = "GER"
 prngAddr = 0x021FFB58
 mtSeedAddr = 0x021FEC68
 idsAddr = 0x0221E938
elseif mbyte(0X02FFFE0F) == 0x46 then
 language = "FRE"
 prngAddr = 0x021FFC38
 mtSeedAddr = 0x021FED48
 idsAddr = 0x0221EA18
elseif mbyte(0X02FFFE0F) == 0x53 then
 language = "SPA"
 prngAddr = 0x021FFBD8
 mtSeedAddr = 0x021FECE8
 idsAddr = 0x0221E9B8
elseif mbyte(0X02FFFE0F) == 0x4B then
 language = "KOR"
 prngAddr = 0x02200358
 mtSeedAddr = 0x021FF468
 idsAddr = 0x0221F138
end

if mbyte(0x02FFFE0E) == 0x41 then  -- Check game version
 game = "White"
elseif mbyte(0x02FFFE0E) == 0x42 then
 game = "Black"
elseif mbyte(0x02FFFE0E) == 0x44 then
 game = "White 2"
 if language ~= "USA" and language ~= "ITA" then
  prngAddr = prngAddr + 0x20
  mtSeedAddr = mtSeedAddr + 0x20
  idsAddr = idsAddr + 0x20
 else
  prngAddr = prngAddr + 0x40
  mtSeedAddr = mtSeedAddr + 0x40
  idsAddr = idsAddr + 0x40
 end
elseif mbyte(0x02FFFE0E) == 0x45 then
 game = "Black 2"
end

if game ~= "Black 2" and game ~= "White 2" then
 warning = " - Wrong game version! Use Black 2/White 2 instead"
else
 warning = ""
end

print("Game Version: "..game..warning)
print("Language: "..language)

client.reboot_core()

function next(s)
 local a = 0x6C07 * (s % 65536) + rshift(s, 16) * 0x8965
 local b = 0x8965 * (s % 65536) + (a % 65536) * 65536 + 0x00269EC3
 local c = b % 4294967296
 return c
end

function back(s)
 local a = 0x9638 * (s % 65536) + rshift(s, 16) * 0x806D
 local b = 0x806D * (s % 65536) + (a % 65536) * 65536 + 0xA384E6F9
 local c = b % 4294967296
 return c
end

function calcFrameJump(tempCurr, curr)
 calibrationFrame = 0
 if tempCurr ~= curr then
  tempCurr2 = tempCurr
  while tempCurr ~= curr and tempCurr2 ~= curr do
   tempCurr = next(tempCurr)
   tempCurr2 = back(tempCurr2)
   calibrationFrame = calibrationFrame + 1
   if calibrationFrame > 99999 then
    calibrationFrame = 0
    break
   end
  end
  if tempCurr2 == curr then
   calibrationFrame = (-1) * calibrationFrame
   tempCurrLow = tempCurr2
  else
   tempCurrLow = tempCurr
  end
 end
 userdata.set("temp", tempCurrLow)
 return calibrationFrame
end

function setInitseed()
 initSeedHigh = userdata.get("seedHigh")
 initSeedLow = userdata.get("seedLow")
 frame = userdata.get("frame")
 tempCurrLow = userdata.get("temp")
end

event.onloadstate(setInitseed)

while true do
 if mdword(prngAddr) ~= 0 and initSet == 0 then
  initSeedHigh = mdword(prngAddr + 0x4)
  initSeedLow = mdword(prngAddr)
  print("")
  print(string.format("Initial Seed: %08X%08X", initSeedHigh, initSeedLow))
  tempCurrLow = initSeedLow
  initSet = 1
 elseif mdword(prngAddr) == 0 then
  initSeedHigh = 0
  initSeedLow = 0
  frame = 0
  initSet = 0
 end

 userdata.set("seedHigh", initSeedHigh)
 userdata.set("seedLow", initSeedLow)
 currSeedHigh = mdword(prngAddr + 0x4)
 currSeedLow = mdword(prngAddr)
 ivsFrame = mdword(mtSeedAddr + 0x9C0) - 2
 frame = frame + calcFrameJump(tempCurrLow, currSeedLow)
 userdata.set("frame", frame)
 sid = math.floor(mdword(idsAddr) / 0x10000)
 tid = mdword(idsAddr) % 0x10000

 timehex = mdword(0x023FFDEC)
 datehex = mdword(0x023FFDE8)
 hour = string.format("%02X", (timehex % 0x100) % 0x40)
 minute = string.format("%02X", (rshift(timehex % 0x10000, 8)))
 second = string.format("%02X", (mbyte(0x02FFFDEE)))
 year = string.format("%02X", (mbyte(0x02FFFDE8)))
 month = string.format("%02X", (mbyte(0x02FFFDE9)))
 day = string.format("%02X", (mbyte(0x02FFFDEA)))

 gui.text(0, 383, string.format("Initial Seed: %08X%08X", initSeedHigh, initSeedLow))
 gui.text(0, 398, string.format("Current Seed: %08X%08X", currSeedHigh, currSeedLow))
 gui.text(0, 413, string.format("PID Frame: %d", frame))
 gui.text(0, 428, string.format("IVs Frame: %d", ivsFrame))
 gui.text(410, 383, string.format("%02d/%02d/%d", month, day, 2000 + year))
 gui.text(430, 398, string.format("%02d:%02d:%02d", hour, minute, second))
 gui.text(409, 735, string.format("TID: %05d", tid))
 gui.text(409, 750, string.format("SID: %05d", sid))

 emu.frameadvance()
end