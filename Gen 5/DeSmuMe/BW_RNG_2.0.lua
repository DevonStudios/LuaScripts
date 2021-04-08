mdword = memory.readdwordunsigned
mword = memory.readword
mbyte = memory.readbyte
rshift = bit.rshift
lshift = bit.lshift
band = bit.band
bxor = bit.bxor
bor = bit.bor
tobit = bit.tobit

local mode = {"Normal", "C-Gear"}
local index = 1
local key = {}
local prevKey = {}
local prngAddr = 0
local mtSeedAddr = 0
local delay = 0
local initSeedHigh = 0
local initSeedLow = 0
local mtSeed = 0
local hitMtSeed = 0
local hitDelay = 0
local currSeedHigh = 0
local currSeedLow = 0
local tempCurrLow = 0
local ivsFrame = 0
local prevMtSeed = 0
local frame = 0
local initSet = 0
local idsAddr = 0
local mac = 0x123456 -- MAC Address of Emulator
local timehex = 0
local datehex = 0
local hour = 0
local minute = 0
local second = 0
local year = 0
local month = 0
local day = 0

local game = ""
local language = ""
local warning = ""

if mbyte(0X02FFFE0F) == 0x4A then  -- Check game language
 language = "JPN"
 prngAddr = 0x02216084
 mtSeedAddr = 0x022151B4
 idsAddr = 0x02234E20
elseif mbyte(0X02FFFE0F) == 0x4F then
 language = "USA"
 prngAddr = 0x02216224
 mtSeedAddr = 0x02215354
 idsAddr = 0x02234FC0
elseif mbyte(0X02FFFE0F) == 0x49 then
 language = "ITA"
 prngAddr = 0x02216124
 mtSeedAddr = 0x2215254
 idsAddr = 0x02234EC0
elseif mbyte(0X02FFFE0F) == 0x44 then
 language = "GER"
 prngAddr = 0x02216164
 mtSeedAddr = 0x02215294
 idsAddr = 0x02234F00
elseif mbyte(0X02FFFE0F) == 0x46 then
 language = "FRE"
 prngAddr = 0x022161A4
 mtSeedAddr = 0x022152D4
 idsAddr = 0x02234F40
elseif mbyte(0X02FFFE0F) == 0x53 then
 language = "SPA"
 prngAddr = 0x022161E4
 mtSeedAddr = 0x02215314
 idsAddr = 0x02234F80
elseif mbyte(0X02FFFE0F) == 0x4B then
 language = "KOR"
 prngAddr = 0x02216924
 mtSeedAddr = 0x02215A54
 idsAddr = 0x022356C0
end

if mbyte(0x02FFFE0E) == 0x41 then  -- Check game version
 game = "White"
 if language ~= "KOR" and language ~= "SPA" then
  prngAddr = prngAddr + 0x20
  mtSeedAddr = mtSeedAddr + 0x20
  idsAddr = idsAddr + 0x20
 end
elseif mbyte(0x02FFFE0E) == 0x42 then
 game = "Black"
elseif mbyte(0x02FFFE0E) == 0x44 then
 game = "White 2"
elseif mbyte(0x02FFFE0E) == 0x45 then
 game = "Black 2"
end

if game ~= "Black" and game ~= "White" then
 warning = " - Wrong game version! Use Black/White instead"
else
 warning = ""
end

print("Game Version: "..game..warning)
print("Language: "..language)

module("mt19937", package.seeall)
require "bit"

-- Period parameters
local N = 624
local M = 397
local MATRIX_A = 0x9908B0DF   -- constant vector a
local UPPER_MASK = 0x80000000 -- most significant w-r bits
local LOWER_MASK = 0x7FFFFFFF -- least significant r bits

local mt = {}     -- the array for the state vector
local mti = N + 1 -- mti == N + 1 means mt[N] is not initialized

-- initializes mt[N] with a seed
function randomseed(s)
 s = band(s, 0xFFFFFFFF)
 mt[1] = s
 for i = 1, N - 1 do
  -- s = 1812433253 * (bxor(s, rshift(s, 30))) + i
  s = bxor(s, rshift(s, 30))
  local s_lo = band(s, 0xFFFF)
  local s_hi = rshift(s, 16)
  local s_lo2 = band(1812433253 * s_lo, 0xFFFFFFFF)
  local s_hi2 = band(1812433253 * s_hi, 0xFFFF)
  s = bor(lshift(rshift(s_lo2, 16) + s_hi2, 16), band(s_lo2, 0xFFFF))
  -- s = band(s + i, 0xFFFFFFFF)
  local s_lim = -tobit(s)
  -- assumes i < 2^31
  if (s_lim > 0 and s_lim <= i) then
   s = i - s_lim
  else
   s = s + i
  end
  mt[i + 1] = s
  -- See Knuth TAOCP Vol2. 3rd Ed. P.106 for multiplier.
  -- In the previous versions, MSBs of the seed affect
  -- only MSBs of the array mt[].
  -- 2002/01/09 modified by Makoto Matsumoto
 end

 mti = N
end

local mag01 = { 0, MATRIX_A } -- mag01[x] = x * MATRIX_A  for x = 0, 1

-- generates a random number on [0, 0xFFFFFFFF] - interval
function random_int32()
 local y

 if (mti >= N) then -- generate N words at one time
  local kk

  if (mti == N + 1) then -- if init_genrand() has not been called,
   mt19937.randomseed(5489) -- a default initial seed is used
  end

  for kk = 1, N - M do
   y = bor(band(mt[kk], UPPER_MASK), band(mt[kk + 1], LOWER_MASK))
   mt[kk] = bxor(mt[kk + M], rshift(y, 1), mag01[1 + band(y, 1)])
  end
  for kk = N - M + 1, N - 1 do
   y = bor(band(mt[kk], UPPER_MASK), band(mt[kk + 1], LOWER_MASK))
   mt[kk] = bxor(mt[kk + (M - N)], rshift(y, 1), mag01[1 + band(y, 1)])
  end
  y = bor(band(mt[N], UPPER_MASK), band(mt[1], LOWER_MASK))
  mt[N] = bxor(mt[M], rshift(y, 1), mag01[1 + band(y, 1)])

  mti = 0
 end

 y = mt[mti + 1]
 mti = mti + 1

 return y
end

function buildSeed() -- Predict C-Gear Seed
 ab = (month * day + minute + second) % 256							-- Build Seed
 cd = hour
 cgd = delay % 65536 + 1
 abcd = ab * 0x100 + cd
 efgh = (year + cgd) % 0x10000
 betaseed = ab * 0x1000000 + cd * 0x10000 + efgh					-- Seed before MAC applied
 cgearseed = betaseed + mac											-- Seed after MAC applied, return this value.

 return cgearseed
end

function getCGearSeed()  -- C-Gear Seed Generation Loop
 strmtv = string.format("%08X", mtSeed)  -- Mersenne Twister untempered is in one format while the memory is in another
 ab = (month * day + minute + second) % 256  -- Build Seed
 cd = hour
 cgd = delay % 65536 - 1
 abcd = ab * 0x100 + cd
 efgh = (year + cgd) % 0x10000
 nextseed = ab * 0x1000000 + cd * 0x10000 + efgh  -- Seed is built
 tempcgear = (ab * 0x1000000 + cd * 0x10000 + efgh + mac) % 0x100000000
 randomseed(tempcgear)
 trialseed = random_int32()
 tempcgearuntemp = string.format("%08X", trialseed)

 if strmtv ~= tempcgearuntemp then
  newsecond = second - 1  -- Subtract a second to check a different set.
  newminute = minute
  newhour = hour
  if newsecond < 0 then  -- Balaning minutes
   newsecond = 59
   newminute = newminute - 1
   if newminute < 0 then  -- Balancing Hours
    newminute = 59
    newhour = newhour - 1
	if newhour < 0 then
	 newhour = 23
	end
   end
  end

  ab = (month * day + newminute + newsecond) % 256  -- Rebuild seed, try again.
  cd = newhour
  abcd = ab * 0x100 + cd
  efgh = (year + cgd) % 0x10000
  tempcgear = (ab * 0x1000000 + cd * 0x10000 + efgh + mac) % 0x100000000
  randomseed(tempcgear)
  trialseed = random_int32()
  tempcgearuntemp = string.format("%08X", trialseed)
 end

 hitMtSeed = tempcgear
 hitDelay = cgd
end

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
 return calibrationFrame
end

function main()
 if mdword(prngAddr) ~= 0 and initSet == 0 then
  initSeedHigh = mdword(prngAddr + 0x4)
  initSeedLow = mdword(prngAddr)
  print()
  print(string.format("Initial Seed: %08X%08X", initSeedHigh, initSeedLow))
  tempCurrLow = initSeedLow
  prevMtSeed = mdword(mtSeedAddr)
  initSet = 1
 elseif mdword(prngAddr) == 0 then
  initSeedHigh = 0
  initSeedLow = 0
  frame = 0
  initSet = 0
  frame = 0
  hitMtSeed = 0
  hitDelay = 0
 end

 currSeedHigh = mdword(prngAddr + 0x4)
 currSeedLow = mdword(prngAddr)
 mtSeed = mdword(mtSeedAddr)

 if mdword(mtSeedAddr + 0x9C0) == 624 then
  ivsFrame = 0
 else
  ivsFrame = mdword(mtSeedAddr + 0x9C0)
 end

 frame = frame + calcFrameJump(tempCurrLow, currSeedLow)
 sid = math.floor(mdword(idsAddr) / 0x10000)
 tid = mdword(idsAddr) % 0x10000

 delay = mdword(0x02FFFC3C)
 timehex = mdword(0x023FFDEC)
 datehex = mdword(0x023FFDE8)
 hour = string.format("%02X", (timehex % 0x100) % 0x40)
 minute = string.format("%02X", (rshift(timehex % 0x10000, 8)))
 second = string.format("%02X", (mbyte(0x02FFFDEE)))
 year = string.format("%02X", (mbyte(0x02FFFDE8)))
 month = string.format("%02X", (mbyte(0x02FFFDE9)))
 day = string.format("%02X", (mbyte(0x02FFFDEA)))

 if prevMtSeed ~= mtSeed and delay > 200 then
  prevMtSeed = mdword(mtSeedAddr)
  getCGearSeed()
 end

 prevMtSeed = mtSeed

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

 gui.text(0, 0, "Mode: "..mode[index])
 gui.text(110, 1, "<- 1 - 2 ->")
 gui.text(0, 15, string.format("Initial Seed: %08X%08X", initSeedHigh, initSeedLow))
 gui.text(0, 25, string.format("Current Seed: %08X%08X", currSeedHigh, currSeedLow))
 gui.text(0, 35, string.format("PID Frame: %d", frame))
 gui.text(0, 45, string.format("IVs Frame: %d", ivsFrame))

 if mode[index] == "C-Gear" then
  gui.text(1, 120, string.format("Next C-Gear: %08X", buildSeed()))
  gui.text(1, 130, string.format("Delay: %d", delay))
  gui.text(1, 140, string.format("C-Gear Seed: %08X", hitMtSeed))
  gui.text(1, 150, string.format("Hit Delay: %d", hitDelay))
 end

 gui.text(195, 15, string.format("%d/%d/%d", month, day, 2000 + year))
 gui.text(207, 25, string.format("%02d:%02d:%02d", hour, minute, second))
 gui.text(195, 173, string.format("TID: %05d", tid))
 gui.text(195, 183, string.format("SID: %05d", sid))
end

gui.register(main)
emu.reset()