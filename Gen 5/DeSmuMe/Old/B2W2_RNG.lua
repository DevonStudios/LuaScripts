-- Setup Terminology abbreviations; from FractalFusion
local band, bor, bxor, tobit, floor = bit.band, bit.bor, bit.bxor, bit.tobit, math.floor
local rshift, lshift = bit.rshift, bit.lshift
local mdword = memory.readdwordunsigned
local mword = memory.readwordunsigned
local mbyte = memory.readbyteunsigned
local wdword = memory.writedword

local game = ""
local rng = 0 -- PRNG Seed Location
local mtrng = 0 -- Mersenne Twister Table Top
local mac = 0x123456 -- MAC Address of Emulator
local storage = 0x02000200
local trackcgear = 0 -- 0 on, 1 off; disable for Standard Abuse, enable for Entralink Abuse
local language = ""

if mbyte(0X02FFFE0F) == 0x4A then  -- Check game language
 language = "JPN"
 rng = 0x021FF5B8
 mtrng = 0x021FE6C8
elseif mbyte(0X02FFFE0F) == 0x4F then
 language = "USA"
 rng = 0x021FFC18
 mtrng = 0x021FED28
elseif mbyte(0X02FFFE0F) == 0x49 then
 language = "ITA"
 rng = 0x021FFB18
 mtrng = 0x021FEC28
elseif mbyte(0X02FFFE0F) == 0x44 then
 language = "GER"
 rng = 0x021FFB58
 mtrng = 0x021FEC68
elseif mbyte(0X02FFFE0F) == 0x46 then
 language = "FRE"
 rng = 0x021FFC38
 mtrng = 0x021FED48
elseif mbyte(0X02FFFE0F) == 0x53 then
 language = "SPA"
 rng = 0x021FFBD8
 mtrng = 0x021FECE8
elseif mbyte(0X02FFFE0F) == 0x4B then
 language = "KOR"
 rng = 0x02200358
 mtrng = 0x021FF468
end

if mbyte(0x02FFFE0E) == 0x41 then  -- Check game version
 game = "White"
elseif mbyte(0x02FFFE0E) == 0x42 then
 game = "Black"
elseif mbyte(0x02FFFE0E) == 0x44 then
 game = "White 2"
 if language ~= "USA" and language ~= "ITA" then
  rng = rng + 0x20
  mtrng = mtrng + 0x20
 else
  rng = rng + 0x40
  mtrng = mtrng + 0x40
 end
elseif mbyte(0x02FFFE0E) == 0x45 then
 game = "Black 2"
end

-- Setup initial variables, rest of script detection will take care of them
local initl = 0
local inith = 0
local initm = 0
local adv = 0
local total = 0
local last = 0
local lastm = 0
local lmtp = 0
local steptable = 0
local mtf = 0
local mttrack = 0
local nextmt = 0
local second = 0
local minute = 0
local hour = 0
local cgearoff = 0
local cachevalue = 0
local notrestored = 0
local wasrestored = 0

-- S frame detection function; works off of seeing how many times the lower half was advanced
-- Lua sucks and only allows 16 bit multiplication, so 32 bit multiplication can't be used
-- The lower seed is advanced as follows, if observed as a standalone 32 bit number:
-- SEED1 = (0x6C078965 * SEED1) + 0x00269EC3; from Kazo
function next(s)
 local a = 0x6C07 * (s % 65536) + rshift(s, 16) * 0x8965
 local b = 0x8965 * (s % 65536) + (a % 65536) * 65536 + 0x00269EC3
 local c = b % 4294967296
 return c
end

-- To predict Mersenne advancement, it's a little harder. Copied and adapted pre-existing Lua
-- http://code.google.com/p/gocha-tas/source/browse/trunk/Scripts/mt19937.lua?r=117
-- Mersenne Twister: A random number generator
-- ported to Lua by gocha, based on mt19937ar.c
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
  -- assumes i<2^31
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

local mag01 = { 0, MATRIX_A }   -- mag01[x] = x * MATRIX_A  for x = 0, 1

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

-- Lua script begin!
function main()
 wdword(storage, 1)
 -- setup every loop
 seed2 = mdword(rng + 4)
 seed1 = mdword(rng)
 adv = 0
 test = last
 mtv = mdword(mtrng)
 mtp = mdword(mtrng + 0x9C0)
 delay = mdword(0x02FFFC3C)
 timehex = mdword(0x023FFDEC)
 datehex = mdword(0x023FFDE8)
 hour = string.format("%02X", (timehex % 0x100) % 0x40)				-- memory stores as decimal, but Lua reads as hex. Convert.
 minute = string.format("%02X", (rshift(timehex % 0x10000, 8)))
 second = string.format("%02X", (mbyte(0x02FFFDEE)))
 year = string.format("%02X", (mbyte(0x02FFFDE8)))
 month = string.format("%02X", (mbyte(0x02FFFDE9)))
 day = string.format("%02X", (mbyte(0x02FFFDEA)))

 -- display seeds every loop
 gui.text(1, 10, string.format("Initial: %08X%08X", inith, initl))
 gui.text(1, 20, string.format("Current: %08X%08X", seed2, seed1))

 -- Check to see if the RNG advanced from the last value
 while seed1 ~= 0 and seed2 ~= 0 and delay > 2 do
  if adv > 200 then -- RNG advanced a bunch, or the game/script was reset. Reset variables then stop loop.
   steptable = 0
   adv = 0
   if mdword(storage) == 1 and delay > 3 and mdword(storage + 0x4 * 2) ~= 0 then
    print(""..string.format("Restoring session. Please Wait..."))
    steptable = mdword(storage + 0x4 * 1)				-- restore mt
    initm = mdword(storage + 0x4 * 2)
    lastm = mdword(storage + 0x4 * 7)
    randomseed(initm)
    i = 624 * steptable + 1
    while i > 0 do										-- restore internal mt frame
     nextmt = floor(random_int32())
     i = i - 1
    end

    mttrack = 1											-- turn on tracking

    inith = mdword(storage + 0x4 * 4)					-- restore PRNG
    initl = mdword(storage + 0x4 * 3)

    cacheseed = mdword(storage + 0x4 * 5)
    cachevalue = mdword(storage + 0x4 * 6)
    lastm = mtv
    mtv = lastm
    lmtp = mtp

    if initm == 0 or inith == 0 or initl == 0 then
     print(""..string.format("Save state's session did not start with script."))
     print(""..string.format("Either load a valid save state or resume with this one."))
     initl = mdword(rng)						-- reset to session
     inith = mdword(rng + 4)
     mttrack = 0
     emu.pause()
     total = 0
     steptable = 0
     mtf = 0
     lmtp = mtp
     steptable = 0
    else
     print(""..string.format("PRNG: %08X%08X", inith, initl))
     print(""..string.format("MTRNG: %08X", initm))
     last = cacheseed
     total = cachevalue								-- restored frame
    end
    cgearoff = mdword(storage + 0x4 * 8)			-- remember if c-gear was turned on or not
    notrestored = 1
    wasrestored = 1
   elseif initm == inith then
    print(""..string.format("Game Reset. Re-initializing."))
    total = 0
    steptable = 0
    mtf = 0
    lmtp = mtp
    initl = mdword(rng)
    inith = mdword(rng + 4)
    initm = mdword(mtrng)
    if inith > 0x7FFFFFFF then wdword(storage + 0x4 * 4, inith - 0x100000000) else wdword(storage + 0x4 * 4, inith) end  -- dumb storage problems, have to make sure they are recognized as the right number type before storage
    if initl > 0x7FFFFFFF then wdword(storage + 0x4 * 3, initl - 0x100000000) else wdword(storage + 0x4 * 3, initl) end
    if initm > 0x7FFFFFFF then wdword(storage + 0x4 * 2, initm - 0x100000000) else wdword(storage + 0x4 * 2, initm) end
    lastm = initm
    randomseed(initm)
    mttrack = 1						-- enable mersenne tracking
    nextmt = random_int32()			-- get first untempered mersenne value, this is the value that will replace the MTRNG seed in the memory when the table is redone
    cgearenoff = 0
    wasrestored = 0

    print(""..string.format("Session Initial Seed: %08X%08X", inith, initl))
    --print(""..string.format("Next: %08X", nextmt)) -- debug

    -- see if initial seeding happened (high32 = mtseed)
    mttrack = 1					-- enable tracking
    print(""..string.format("Initial Seeding Detected. MTRNG Seed: %08X", initm))
   else
    print(""..string.format("Foreign Save State Detected, or Restart didn't refresh. Reset again."))
    total = 0
    steptable = 0
    mtf = 0
    lmtp = mtp
    initl = mdword(rng)
    inith = mdword(rng + 4)
    initm = mdword(mtrng)
    if inith > 0x7FFFFFFF then wdword(storage + 0x4 * 4, inith - 0x100000000) else wdword(storage + 0x4 * 4, inith) end
    if initl > 0x7FFFFFFF then wdword(storage + 0x4 * 3, initl - 0x100000000) else wdword(storage + 0x4 * 3, initl) end
    if initm > 0x7FFFFFFF then wdword(storage + 0x4 * 2, initm - 0x100000000) else wdword(storage + 0x4 * 2, initm) end
    lastm = initm
    randomseed(initm)
    mttrack = 0						-- disable mersenne tracking
    nextmt = random_int32()			-- get first untempered mersenne value, this is the value that will replace the MTRNG seed in the memory when the table is redone
    cgearenoff = 0
    wasrestored = 0
   end
   print(""..string.format(""))		-- Visual Line to separate.
   break

  elseif test ~= seed1 then 		-- RNG advanced at least once. Lets advance once and repeat the loop.
   test = next(test)
   adv = adv + 1

  elseif test == seed1 then
   break 							-- last frame's advanced RNG value matches the current. Stop loop.
  end
 end

 gui.text(180, 10, string.format("%d/%d/%d", month, day, 2000 + year))					-- Display Date
 gui.text(180, 20, string.format("%02d:%02d:%02d", hour, minute, second, delay))		-- Display Time

 -- Check to see if the MTRNG changed, only if tracking is enabled.
 if mttrack == 1 and notrestored == 0 then
  if (lmtp > mtp and delay > 50 and notrestored == 0) or (lmtp == mtp and lastm ~= mtv) then
   strmtv = string.format("%08X", mtv)			-- Mersenne Twister untempered is in one format while the memory is in another
   strnmt = string.format("%08X", nextmt)		-- Convert to a string hex so that they can be equated when their decimal isn't
   if strmtv ~= strnmt  then 					-- New untempered table value isn't as predicted, so the c-gear was turned on!
    mttrack = 1
    -- print(strmtv, strnmt, string.format("%08X", lastm)) -- debug for bad initialize
    if wasrestored == 1 then print(""..string.format("Earlier restoration may have failed. Double Check.")) print(""..string.format("If C-Gear was just turned on this frame, ignore.")) print(""..string.format("")) wasrestored = 0 end
    -- mttrack = 0
    --else
    print(""..string.format("C-Gear turned on. Determining C-Gear Seed and restarting tracking."))
    steptable = 1
    wdword(storage + 0x4 * 1, steptable)
    -- Finding the C-Gear seed you hit
    -- Load Time Values
    hour = string.format("%02X", (timehex % 0x100) % 0x40)				-- Memory stores as decimal, but Lua reads as hex. Convert.
    minute = string.format("%02X", (rshift(timehex % 0x10000, 8)))
    second = string.format("%02X", (mbyte(0x02FFFDEE)))
    year = string.format("%02X", (mbyte(0x02FFFDE8)))
    month = string.format("%02X", (mbyte(0x02FFFDE9)))
    day = string.format("%02X", (mbyte(0x02FFFDEA)))
    ab = (month * day + minute + second) % 256
    cd = hour
    cgd = delay % 65536 - 1												-- Delay from a frame before is used.
    abcd = ab * 0x100 + cd
    efgh = (year + cgd) % 0x10000
    tempcgear = (ab * 0x1000000 + cd * 0x10000 + efgh + mac) % 0x100000000
    randomseed(tempcgear)
    trialseed = random_int32()
    tempcgearuntemp = string.format("%08X", trialseed)
    if strmtv ~= tempcgearuntemp then
     second = second - 1					-- Subtract a second to check a different set.
     if second < 0 then						-- Balaning minutes
      second = 59
      minute = minute - 1
      if minute < 0 then					-- Balancing Hours
       minute = 59
       hour = hour - 1
      end
     end
     ab = (month * day + minute + second) % 256	-- Rebuild seed, try again.
     cd = hour
     abcd = ab * 0x100 + cd
     efgh = (year + cgd) % 0x10000
     tempcgear = (ab * 0x1000000 + cd * 0x10000 + efgh + mac) % 0x100000000
     randomseed(tempcgear)
     trialseed = random_int32()
     tempcgearuntemp = string.format("%08X", trialseed)
    end

    initm = tempcgear
    print(""..string.format("C-Gear Seed: %08X    Delay: %d", tempcgear, cgd))
    print(""..string.format(""))				-- Visual Blank Line
    if initm > 0x7FFFFFFF then wdword(storage + 0x4 * 2, initm - 0x100000000) else wdword(storage + 0x4 * 2, initm) end
    i = 0
    while i ~= 624 do									-- get the next untempered for the cgear
     nextmt = floor(random_int32())
     i = i + 1
    end --end
   else													-- untempered is as predicted -> predict next one for when the time rolls around

    i = 0
    while i ~= 624 do									-- do 624 iterations to build the remaining 623 and the first of the next.
     nextmt = floor(random_int32())
     i = i + 1
    end
    --print(""..string.format("Next: %08X", nextmt)) 	-- debug

    steptable = steptable + 1 							-- mersenne twister has a new table as the counter is reset to 0; tables +  +

    wdword(storage + 0x4 * 1, steptable)				-- save state storage of table refreshes
   end
  end
  gui.text(1, 160, string.format("IVs Frame: %d", mtf))
  gui.text(1, 170, string.format("MTRNG Seed: %08X", initm))
  -- gui.text(1, 38, string.format("next mt: %08X", nextmt)) -- debug
 end

 -- Advancement Tracking for the PRNG and Mersenne Twister
 total = adv + total										-- total advancements = advancements on this frame + total advancements from previous frames
 if total - cachevalue > 200 then							-- check to see if we should refresh the cached value
  cachevalue = total
 end
 mtf = mtp + (steptable - 1) * 2							-- Mersenne Twister Frame = Pointer Value + (TableRefresh - 1) * 2 ; this accounts for the initial value of 0x2 which is actually zero

 gui.text(1, 30, string.format("PID Frame: %d", total))			-- Display PRNG Frame; total advancements since the initial seed

 -- If the user specifies they want to use the C-Gear

 -- Set Up variables for next frame's pass
 lmtp = mtp
 last = seed1
 lastm = mtv
 if lastm > 0x7FFFFFFF then wdword(storage + 0x4 * 7, lastm - 0x100000000) else wdword(storage + 0x4 * 7, lastm) end
 wdword(storage + 0x4 * 6, total)
 if seed1 > 0x7FFFFFFF then wdword(storage + 0x4 * 5, seed1 - 0x100000000) else wdword(storage + 0x4 * 5, seed1) end

 notrestored = 0
 -- End Lua
end

gui.register(main)
emu.reset()