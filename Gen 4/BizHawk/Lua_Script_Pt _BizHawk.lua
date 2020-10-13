mdword = memory.read_u32_le
mword = memory.read_u16_le
mbyte = memory.readbyte
rshift = bit.rshift

local game = 0
local language = 0
local seedsOffset = 0
local delayOffset = 0
local ivrngOffset = 0
console.clear()

if mbyte(0x02FFFE0F) == 0x4A then  -- Check game language
 language = 'JPN'
 seedsOffset = 0
 delayOffset = 0
 ivrngOffset = 0
elseif mbyte(0x02FFFE0F) == 0x45 then
 language = 'USA'
 seedsOffset = 0xC00
 delayOffset = 0xC00
 ivrngOffset = 0xC08
elseif mbyte(0x02FFFE0F) == 0x49 then
 language = 'ITA'
 seedsOffset = 0xD60
 delayOffset = 0xD60
 ivrngOffset = 0xD68
elseif mbyte(0x02FFFE0F) == 0x44 then
 language = 'GER'
 seedsOffset = 0xDA0
 delayOffset = 0xDA0
 ivrngOffset = 0xDA8
elseif mbyte(0x02FFFE0F) == 0x46 then
 language = 'FRE'
 seedsOffset = 0xDE0
 delayOffset = 0xDE0
 ivrngOffset = 0xDE8
elseif mbyte(0x02FFFE0F) == 0x53 then
 language = 'SPA'
 seedsOffset = 0xE00
 delayOffset = 0xE00
 ivrngOffset = 0xE08
elseif mbyte(0x02FFFE0F) == 0x4B then
 language = 'KOR'
 seedsOffset = 0x1B00
 delayOffset = 0x1B00
 ivrngOffset = 0x1AE8
end

if mword(0x02FFFE08) == 0x4C50 then  -- Check game version
 game = 'Platinum'
elseif mbyte(0x02FFFE08) == 0x44 then
 game = 'Diamond'
elseif mbyte(0x02FFFE08) == 0x50 then
 game = 'Pearl'
elseif mword(0x02FFFE08) == 0x4748 then
 game = 'HeartGold'
elseif mword(0x02FFFE08) == 0x5353 then
 game = 'SoulSilver'
end

idsPointer = 0x021BFB94 + seedsOffset

if game ~= 'Platinum' then
 warning = ' - Wrong game version! Use Platinum instead'
else
 warning = ''
end

print('Game Version: '..game..warning)
print('Language: '..language)

local initSeed = 0
local currseed = 0
local tempCurr = 0
local delay = 0
local ivRngframe = 0
local frame = 0
client.reboot_core()

function buildseed()  -- Predict Initial Seed
 timehex = mdword(0x023FFDEC)
 datehex = mdword(0x023FFDE8)
 hour = string.format("%02X", (timehex % 0x100) % 0x40)
 minute = string.format("%02X", (rshift(timehex % 0x10000, 8)))
 second = string.format("%02X", (mbyte(0x02FFFDEE)))
 year = string.format("%02X", (mbyte(0x02FFFDE8)))
 month = string.format("%02X", (mbyte(0x02FFFDE9)))
 day = string.format("%02X", (mbyte(0x02FFFDEA)))
 ab = (month * day + minute + second) % 256  -- Build Seed
 cd = hour
 cgd = delay % 65536 + 1  -- can tweak for calibration
 abcd = ab * 0x100 + cd
 efgh = (year + cgd) % 0x10000
 nextseed = ab * 0x1000000 + cd * 0x10000 + efgh  -- Seed is built
 return nextseed
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
 if (currseed ~= 0 or frame ~= 0) and tempCurr ~= currseed then
  tempCurr2 = tempCurr
  while tempCurr ~= currseed and tempCurr2 ~= currseed do
   tempCurr = next(tempCurr)
   tempCurr2 = back(tempCurr2)
   difference = difference + 1
   if difference > 9999 then
    break
   end
  end
  if tempCurr2 == currseed then
   difference = difference * (-1)
  end
 end
 if tempCurr ~= currseed then
  tempCurr = currseed
 end
 userdata.set('temp', tempCurr)
 return difference
end

function getIVFrame()  -- IVRNG Frame Counting
 if ivRngframe >= 624 then
  ivframe = 1
 else
  ivframe = ivRngframe + 1
 end
 return ivframe
end

function setinitSeed()
 initSeed = userdata.get('seed')
 frame = userdata.get('frame')
 tempCurr = userdata.get('temp')
end

event.onloadstate(setinitSeed)

while true do
 currseed = mdword(0x021BEF14 + seedsOffset)
 ivRngframe = mdword(0x020FFC28 + ivrngOffset)
 ids = mdword(mdword(idsPointer) + 0x8C)
 sid = math.floor(ids / 0x10000)
 tid = ids % 0x10000

 if mdword(0x021BEF18 + seedsOffset) == currseed then
  initSeed = mdword(0x021BEF18 + seedsOffset)
  tempCurr = initSeed
  frame = 0
  userdata.set('seed', initSeed)
 end

 frame = frame + calcPIDFrameJump()
 userdata.set('frame', frame)

 if frame == 0 then
  delay = mdword(0x021BEAA8 + delayOffset) + 21
  gui.text(0, 365, string.format("Next Seed: %08X", buildseed()))
  gui.text(0, 690, "Delay: "..delay)
 end

 gui.text(0, 705, "Frame: "..frame)
 gui.text(0, 720, string.format("Egg Frame: %d", getIVFrame()))
 gui.text(0, 735, string.format("Initial Seed: %08X", initSeed))
 gui.text(0, 750, string.format("Current Seed: %08X", currseed))
 gui.text(410, 735, string.format("TID: %05d", tid))
 gui.text(410, 750, string.format("SID: %05d", sid))
 
 emu.frameadvance()
end