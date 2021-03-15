mdword = memory.readdwordunsigned
mword = memory.readword
mbyte = memory.readbyte
rshift = bit.rshift

local mode = {"Normal", "Weather Fix"}
local index = 1
local key = {}
local prevKey = {}
local delay = 0
local ivrngframe = 0

if mbyte(0x02FFFE0F) == 0x4A then  -- Check game language
 language = "JPN"
 seedsOffset = 0
 delayOffset = 0
 ivrngOffset = 0
elseif mbyte(0x02FFFE0F) == 0x45 then
 language = "USA"
 seedsOffset = 0xC00
 delayOffset = 0xC00
 ivrngOffset = 0xC08
elseif mbyte(0x02FFFE0F) == 0x49 then
 language = "ITA"
 seedsOffset = 0xD60
 delayOffset = 0xD60
 ivrngOffset = 0xD68
elseif mbyte(0x02FFFE0F) == 0x44 then
 language = "GER"
 seedsOffset = 0xDA0
 delayOffset = 0xDA0
 ivrngOffset = 0xDA8
elseif mbyte(0x02FFFE0F) == 0x46 then
 language = "FRE"
 seedsOffset = 0xDE0
 delayOffset = 0xDE0
 ivrngOffset = 0xDE8
elseif mbyte(0x02FFFE0F) == 0x53 then
 language = "SPA"
 seedsOffset = 0xE00
 delayOffset = 0xE00
 ivrngOffset = 0xE08
elseif mbyte(0x02FFFE0F) == 0x4B then
 language = "KOR"
 seedsOffset = 0x1B00
 delayOffset = 0x1B00
 ivrngOffset = 0x1AE8
end

if mword(0x02FFFE08) == 0x4C50 then  -- Check game version
 game = "Platinum"
elseif mbyte(0x02FFFE08) == 0x44 then
 game = "Diamond"
elseif mbyte(0x02FFFE08) == 0x50 then
 game = "Pearl"
elseif mword(0x02FFFE08) == 0x4748 then
 game = "HeartGold"
elseif mword(0x02FFFE08) == 0x5353 then
 game = "SoulSilver"
end

idspointer = 0x021BFB94 + seedsOffset

if game ~= "Platinum" then
 warning = " - Wrong game version! Use Platinum instead"
else
 warning = ""
end

print("Game Version: "..game..warning)
print("Language: "..language)

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

function calcPIDFrame(i, c)  -- PIDRNG Frame Counting
 f = 0
 if c ~= 0 then
  while i ~= c do
   i = next(i)
   f = f + 1
   if f > 9999 then
    break
   end
  end
 end
 return f
end

function getIVFrame()  -- IVRNG Frame Counting
 if ivrngframe >= 624 then
  ivframe = 1
 else
  ivframe = ivrngframe + 1
 end
 return ivframe
end

function main()
 currseed = mdword(0x021BEF14 + seedsOffset)
 ivrngframe = mdword(0x020FFC28 + ivrngOffset)
 delay = mdword(0x021BEAA8 + delayOffset) + 21
 ids = mdword(mdword(idspointer) + 0x8C)
 sid = math.floor(ids / 0x10000)
 tid = ids % 0x10000

 key = input.get()
 if key["1"] and not prevKey["1"] then
  index = index - 1
  if index < 1 then
   index = 2
  end
 elseif key["2"] and not prevKey["2"] then
  index = index + 1
  if index > 2 then
   index = 1
  end
 end

 prevKey = key

 if mode[index] == "Normal" then
  initial = mdword(0x021BEF18 + seedsOffset)
 else
  if mdword(0x021BEF18 + seedsOffset) == currseed then
   initial = mdword(0x021BEF18 + seedsOffset)
  end
 end

 frame = calcPIDFrame(initial, currseed)

 if frame == 0 then
  gui.text(0, -10, string.format("Next Seed: %08X", buildseed()))
  gui.text(0, 140, string.format("Delay: %d", delay))
 end

 gui.text(0, 150, string.format("Frame: %d", frame))
 gui.text(0, 160, string.format("Egg Frame: %d", getIVFrame()))
 gui.text(0, 170, string.format("Initial Seed: %08X", initial))
 gui.text(0, 180, string.format("Current Seed: %08X", currseed))
 gui.text(195, 170, string.format("TID: %05d", tid))
 gui.text(195, 180, string.format("SID: %05d", sid))
end

gui.register(main)
emu.reset()