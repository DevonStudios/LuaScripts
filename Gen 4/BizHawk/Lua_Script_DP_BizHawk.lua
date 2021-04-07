mdword = memory.read_u32_le
mword = memory.read_u16_le
mbyte = memory.readbyte
rshift = bit.rshift

local game = 0
local language = 0
local seedsOffset = 0
local delayOffset = 0
local ivsRngOffset = 0
local jpnIdsOffset = 0
console.clear()

if mbyte(0x02FFFE0F) == 0x4A then  -- Check game language
 language = "JPN"
 seedsOffset = 0x4260
 delayOffset = 0x4260
 ivsRngOffset = 0x43BC
 jpnIdsOffset = 0xA
elseif mbyte(0x02FFFE0F) == 0x45 then
 language = "USA"
 seedsOffset = 0x2A00
 delayOffset = 0x2A00
 ivsRngOffset = 0x2B00
elseif mbyte(0x02FFFE0F) == 0x49 then
 language = "ITA"
 seedsOffset = 0x2AE0
 delayOffset = 0x2AE0
 ivsRngOffset = 0x2BE0
elseif mbyte(0x02FFFE0F) == 0x44 then
 language = "GER"
 seedsOffset = 0x2B40
 delayOffset = 0x2B40
 ivsRngOffset = 0x2C40
elseif mbyte(0x02FFFE0F) == 0x46 then
 language = "FRE"
 seedsOffset = 0x2B80
 delayOffset = 0x2B80
 ivsRngOffset = 0x2C80
elseif mbyte(0x02FFFE0F) == 0x53 then
 language = "SPA"
 seedsOffset = 0x2BA0
 delayOffset = 0x2BA0
 ivsRngOffset = 0x2CA0
elseif mbyte(0x02FFFE0F) == 0x4B then
 language = "KOR"
 seedsOffset = 0
 delayOffset = 0
 ivsRngOffset = 0
end

if mword(0x02FFFE08) == 0x4C50 then  -- Check game version
 game = "Platinum"
elseif mbyte(0x02FFFE08) == 0x44 then
 game = "Diamond"
elseif mbyte(0x02FFFE08) == 0x50 then
 game = "Pearl"
 ivsRngOffset = ivsRngOffset + 0x8
elseif mword(0x02FFFE08) == 0x4748 then
 game = "HeartGold"
elseif mword(0x02FFFE08) == 0x5353 then
 game = "SoulSilver"
end

idsPointer = 0x021C2FC8 + seedsOffset + jpnIdsOffset

if game ~= "Diamond" and game ~= "Pearl" then
 warning = " - Wrong game version! Use Diamon/Pearl instead"
else
 warning = ""
end

print("Game Version: "..game..warning)
print("Language: "..language)

local initSeed = 0
local currSeed = 0
local tempCurr = 0
local delay = 0
local ivsRngFrame = 0
local frame = 0
local calculateJump = true
local nullFrame = 0
client.reboot_core()

function buildSeed()  -- Predict Initial Seed
 timehex = mdword(0x023FFDEC)
 datehex = mdword(0x023FFDE8)
 hour = string.format("%02X", (timehex % 0x100) % 0x40)
 minute = string.format("%02X", (rshift(timehex % 0x10000, 8)))
 second = string.format("%02X", (mbyte(0x02FFFDEE)))
 year = string.format("%02X", (mbyte(0x02FFFDE8)))
 month = string.format("%02X", (mbyte(0x02FFFDE9)))
 day = string.format("%02X", (mbyte(0x02FFFDEA)))
 gui.text(0, 335, string.format(day.."/"..month.."/20"..year))
 gui.text(0, 350, string.format(hour..":"..minute..":"..second))
 ab = (month * day + minute + second) % 256  -- Build Seed
 cd = hour
 cgd = delay % 65536 + 1  -- can tweak for calibration
 abcd = ab * 0x100 + cd
 efgh = (year + cgd) % 0x10000
 nextSeed = ab * 0x1000000 + cd * 0x10000 + efgh  -- Seed is built
 return nextSeed
end

function next(s) -- LCRNG
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

function calcPIDFrameJump()  -- PIDRNG Frame Counting
 difference = 0
 if (currSeed ~= 0 or frame > 0) and tempCurr ~= currSeed then
  tempCurr2 = tempCurr
  while tempCurr ~= currSeed and tempCurr2 ~= currSeed do
   tempCurr = next(tempCurr)
   tempCurr2 = back(tempCurr2)
   difference = difference + 1
   if difference > 9999 then
    nullFrame = 0
	difference = userdata.get("frame")
	calculateJump = false
    break
   else
    nullFrame = 1
   end
  end
  if tempCurr2 == currSeed then
   difference = difference * (-1)
   tempCurr = tempCurr2
  end
 end
 return difference
end

function getIVsFrame()  -- IVRNG Frame Counting
 if ivsRngFrame >= 624 then
  ivsFrame = 1
 else
  ivsFrame = ivsRngFrame + 1
 end
 return ivsFrame
end

function setInitSeed()
 initSeed = userdata.get("seed")
 frame = userdata.get("frame")
 tempCurr = userdata.get("temp")
end

event.onloadstate(setInitSeed)

while true do
 currSeed = mdword(0x021C2348 + seedsOffset)
 ivsRngFrame = mdword(0x021030A8 + ivsRngOffset)
 ids = mdword(mdword(idsPointer) + 0x288)
 sid = math.floor(ids / 0x10000)
 tid = ids % 0x10000

 if mdword(0x021C234C + seedsOffset) == currSeed then
  initSeed = mdword(0x021C234C + seedsOffset)
  tempCurr = initSeed
  frame = 0
  userdata.set("seed", initSeed)
 end

 if calculateJump then
  frame = (frame * nullFrame) + calcPIDFrameJump()
  userdata.set("frame", frame)
 end

 if emu.framecount() % 100 == 0 and not calculateJump then
  calculateJump = true
  tempCurr = initSeed
 end

 userdata.set("temp", tempCurr)

 if frame == 0 and initSeed == currseed then
  delay = mdword(0x021C1EE4 + delayOffset) + 21
  gui.text(0, 365, string.format("Next Seed: %08X", buildSeed()))
  gui.text(0, 690, "Delay: "..delay)
 end

 gui.text(0, 705, "Frame: "..frame)
 gui.text(0, 720, string.format("Egg Frame: %d", getIVsFrame()))
 gui.text(0, 735, string.format("Initial Seed: %08X", initSeed))
 gui.text(0, 750, string.format("Current Seed: %08X", currSeed))
 gui.text(410, 735, string.format("TID: %05d", tid))
 gui.text(410, 750, string.format("SID: %05d", sid))

 emu.frameadvance()
end