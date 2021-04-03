-- Setup Terminology abbreviations; from FractalFusion
local bnd,br,bxr=bit.band,bit.bor,bit.bxor
local rshift, lshift=bit.rshift, bit.lshift
local mdword=memory.readdwordunsigned
local mword=memory.readwordunsigned
local mbyte=memory.readbyteunsigned
local wdword=memory.writedword
local md,mw,mb=memory.readdwordunsigned,memory.readwordunsigned,memory.readbyteunsigned

local game=0 -- 0 for white2, 1 for black2
local rng=0x021FFC58-0x40*game -- PRNG Seed Location
local mtrng=0x021FED68-0x40*game -- Mersenne Twister Table Top
local mac=0x123456 -- MAC Address of Emulator
local pos_m=md(0x02000024)+0x36780

local storage=0x02000200
local trackcgear=0 -- 0 on, 1 off; disable for Standard Abuse, enable for Entralink Abuse
local research=0 -- 0 on, 1 off; only enable for dev features (unneeded)

-- Setup initial variables, rest of script detection will take care of them
local initl=0
local inith=0
local initm=0
local adv=0
local jump1=0
local jump2=0
local jump3=0
local jump4=0
local jump5=0
local jump6=0
local jump7=0
local jump8=0
local jump9=0
local jump10=0
local jump11=0
local jump12=0
local jump13=0
local jump14=0
local jump15=0
local jump16=0
local jump17=0
local jump18=0
local jump19=0
local jump20=0
local total=0
local last=0
local lastm=0
local lmtp=0
local steptable=0
local mtf=0
local mttrack=0
local nextmt=0
local second=0
local minute=0
local hour=0
local cgearoff=0
local cachevalue=0
local notrestored=0
local wasrestored=0

-- S frame detection function; works off of seeing how many times the lower half was advanced
-- Lua sucks and only allows 16 bit multiplication, so 32 bit multiplication can't be used
-- The lower seed is advanced as follows, if observed as a standalone 32 bit number:
-- SEED1 = (0x6C078965 * SEED1) + 0x00269EC3; from Kazo
function next(s)
local a=0x6C07*(s%65536)+rshift(s,16)*0x8965
local b=0x8965*(s%65536)+(a%65536)*65536+0x00269EC3
local c=b%4294967296
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
local MATRIX_A = 0x9908b0df   -- constant vector a
local UPPER_MASK = 0x80000000 -- most significant w-r bits
local LOWER_MASK = 0x7fffffff -- least significant r bits

local mt = {}     -- the array for the state vector
local mti = N + 1 -- mti==N+1 means mt[N] is not initialized

-- initializes mt[N] with a seed
function randomseed(s)
   s = bit.band(s, 0xffffffff)
   mt[1] = s
   for i = 1, N - 1 do
       -- s = 1812433253 * (bit.bxor(s, bit.rshift(s, 30))) + i
       s = bit.bxor(s, bit.rshift(s, 30))
       local s_lo = bit.band(s, 0xffff)
       local s_hi = bit.rshift(s, 16)
       local s_lo2 = bit.band(1812433253 * s_lo, 0xffffffff)
       local s_hi2 = bit.band(1812433253 * s_hi, 0xffff)
       s = bit.bor(bit.lshift(bit.rshift(s_lo2, 16) + s_hi2, 16),
           bit.band(s_lo2, 0xffff))
       -- s = bit.band(s + i, 0xffffffff)
       local s_lim = -bit.tobit(s)
       -- assumes i<2^31
       if (s_lim > 0 and s_lim <= i) then
           s = i - s_lim
       else
           s = s + i
       end
       mt[i+1] = s
       -- See Knuth TAOCP Vol2. 3rd Ed. P.106 for multiplier.
       -- In the previous versions, MSBs of the seed affect
       -- only MSBs of the array mt[].
       -- 2002/01/09 modified by Makoto Matsumoto
   end
   mti = N
end

local mag01 = { 0, MATRIX_A }   -- mag01[x] = x * MATRIX_A  for x=0,1

-- generates a random number on [0,0xffffffff]-interval
function random_int32()
   local y

   if (mti >= N) then -- generate N words at one time
       local kk

       if (mti == N + 1) then -- if init_genrand() has not been called,
           mt19937.randomseed(5489) -- a default initial seed is used
       end

       for kk = 1, N - M do
           y = bit.bor(bit.band(mt[kk], UPPER_MASK), bit.band(mt[kk+1], LOWER_MASK))
           mt[kk] = bit.bxor(mt[kk+M], bit.rshift(y, 1), mag01[1 + bit.band(y, 1)])
       end
       for kk = N - M + 1, N - 1 do
           y = bit.bor(bit.band(mt[kk], UPPER_MASK), bit.band(mt[kk+1], LOWER_MASK))
           mt[kk] = bit.bxor(mt[kk+(M-N)], bit.rshift(y, 1), mag01[1 + bit.band(y, 1)])
       end
       y = bit.bor(bit.band(mt[N], UPPER_MASK), bit.band(mt[1], LOWER_MASK))
       mt[N] = bit.bxor(mt[M], bit.rshift(y, 1), mag01[1 + bit.band(y, 1)])

       mti = 0
   end

   y = mt[mti+1]
   mti = mti + 1



   return y
end

function random(...)
   -- local r = mt19937.random_int32() * (1.0/4294967296.0)
   local rtemp = mt19937.random_int32()
   local r = (bit.band(rtemp, 0x7fffffff) * (1.0/4294967296.0)) + (bit.tobit(rtemp) < 0 and 0.5 or 0)
   local arg = {...}
   if #arg == 0 then
       return r
   elseif #arg == 1 then
       local u = math.floor(arg[1])
       if 1 <= u then
           return math.floor(r*u)+1
       else
           error("bad argument #1 to 'random' (internal is empty)")
       end
   elseif #arg == 2 then
       local l, u = math.floor(arg[1]), math.floor(arg[2])
       if l <= u then
           return math.floor((r*(u-l+1))+l)
       else
           error("bad argument #2 to 'random' (internal is empty)")
       end
   else
       error("wrong number of arguments")
   end
end

-- Lua script begin!
function main()
wdword(storage,1)
-- setup every loop
seed2=mdword(rng+4)
seed1=mdword(rng)
adv=0
test=last
mtv=mdword(mtrng)
mtp=mdword(mtrng+0x9C0)
delay=mdword(0x02FFFC3C)
timehex=mdword(0x023FFDEC)
datehex=mdword(0x023FFDE8)
hour=string.format("%02X",(timehex%0x100)%0x40)				-- memory stores as decimal, but Lua reads as hex. Convert.
minute=string.format("%02X",(rshift(timehex%0x10000,8)))
second=string.format("%02X",(mbyte(0x02FFFDEE)))
year=string.format("%02X",(mbyte(0x02FFFDE8)))
month=string.format("%02X",(mbyte(0x02FFFDE9)))
day=string.format("%02X",(mbyte(0x02FFFDEA)))

-- display seeds every loop
gui.text(1,10,string.format("Current: %08X%08X",seed2,seed1))
gui.text(1,180,string.format("Initial: %08X%08X",inith,initl))
gui.text(1,170, string.format("M: %d, X: %d, Y: %d, Z: %d", mword(pos_m), mword(pos_m+0x6), mword(pos_m+0xE), mword(pos_m+0xA)))

-- Check to see if the RNG advanced from the last value
while seed1~=0 and seed2~=0 and delay > 2 do
	if adv>200 then -- RNG advanced a bunch, or the game/script was reset. Reset variables then stop loop.
		steptable=0
		adv  =0
		jump1=0
		jump2=0
		jump3=0
		jump4=0
		jump5=0
		jump6=0
		jump7=0
		jump8=0
		jump9=0
		jump10=0
		jump11=0
		jump12=0
		jump13=0
		jump14=0
		jump15=0
		jump16=0
		jump17=0
		jump18=0
		jump19=0
		jump20=0
		if mdword(storage)==1 and delay>3 and mdword(storage+0x4*2)~=0 then
			print(""..string.format("Restoring session. Please Wait..."))
			steptable=mdword(storage+0x4*1)				-- restore mt
			initm=mdword(storage+0x4*2)
			lastm=mdword(storage+0x4*7)
			randomseed(initm)
			i=624*steptable+1
			while i>0 do								-- restore internal mt frame
					nextmt=math.floor(random_int32())
					i=i-1
			end

			mttrack=1									-- turn on tracking

			inith=mdword(storage+0x4*4)					-- restore PRNG
			initl=mdword(storage+0x4*3)

			cacheseed=mdword(storage+0x4*5)
			cachevalue=mdword(storage+0x4*6)
			lastm=mtv
			mtv=lastm
			lmtp=mtp

			if initm==0 or inith==0 or initl==0 then
				print(""..string.format("Save state's session did not start with script."))
				print(""..string.format("Either load a valid save state or resume with this one."))
				initl=mdword(rng)						-- reset to session
				inith=mdword(rng+4)
				mttrack=0
				emu.pause()
				total=0
				steptable=0
				mtf=0
				lmtp=mtp
				steptable=0
			else
				print(""..string.format("PRNG: %08X%08X",inith,initl))
				print(""..string.format("MTRNG: %08X", initm))
				last=cacheseed
				total=cachevalue							-- restored frame
			end
			cgearoff=mdword(storage+0x4*8)			-- remember if c-gear was turned on or not
			notrestored=1
			wasrestored=1
		elseif initm==inith then
			print(""..string.format("Game Reset. Re-initializing."))
			total=0
			steptable=0
			mtf=0
			lmtp=mtp
			initl=mdword(rng)
			inith=mdword(rng+4)
			initm=mdword(mtrng)
			if inith>0x7FFFFFFF then wdword(storage+0x4*4,inith-0x100000000) else wdword(storage+0x4*4,inith) end  -- dumb storage problems, have to make sure they are recognized as the right number type before storage
			if initl>0x7FFFFFFF then wdword(storage+0x4*3,initl-0x100000000) else wdword(storage+0x4*3,initl) end
			if initm>0x7FFFFFFF then wdword(storage+0x4*2,initm-0x100000000) else wdword(storage+0x4*2,initm) end
			lastm=initm
			randomseed(initm)
			mttrack=1						-- enable mersenne tracking
			nextmt=random_int32()			-- get first untempered mersenne value, this is the value that will replace the MTRNG seed in the memory when the table is redone
			cgearenoff=0
			wasrestored=0

		print(""..string.format("Session Initial Seed: %08X%08X",inith,initl))
		--print(""..string.format("Next: %08X", nextmt)) -- debug

		-- see if initial seeding happened (high32=mtseed)
			mttrack=1					-- enable tracking
			print(""..string.format("Initial Seeding Detected. MTRNG Seed: %08X", initm))
		else
			print(""..string.format("Foreign Save State Detected, or Restart didn't refresh. Reset again."))
			total=0
			steptable=0
			mtf=0
			lmtp=mtp
			initl=mdword(rng)
			inith=mdword(rng+4)
			initm=mdword(mtrng)
			if inith>0x7FFFFFFF then wdword(storage+0x4*4,inith-0x100000000) else wdword(storage+0x4*4,inith) end
			if initl>0x7FFFFFFF then wdword(storage+0x4*3,initl-0x100000000) else wdword(storage+0x4*3,initl) end
			if initm>0x7FFFFFFF then wdword(storage+0x4*2,initm-0x100000000) else wdword(storage+0x4*2,initm) end
			lastm=initm
			randomseed(initm)
			mttrack=0						-- disable mersenne tracking
			nextmt=random_int32()			-- get first untempered mersenne value, this is the value that will replace the MTRNG seed in the memory when the table is redone
			cgearenoff=0
			wasrestored=0
		end
		print(""..string.format(""))	-- Visual Line to separate.
		break

	elseif test~=seed1 then 			-- RNG advanced at least once. Lets advance once and repeat the loop.
		test=next(test)
		adv=adv+1

	elseif test==seed1 then
		if adv > 0 then 				-- Refresh Frame Advancement Table if there's more than one advancement this frame.
			jump20=jump19
			jump19=jump18
			jump18=jump17
			jump17=jump16
			jump16=jump15
			jump15=jump14
			jump14=jump13
			jump13=jump12
			jump12=jump11
			jump11=jump10
			jump10=jump9
			jump9=jump8
			jump8=jump7
			jump7=jump6
			jump6=jump5
			jump5=jump4
			jump4=jump3
			jump3=jump2
			jump2=jump1
			jump1=adv
		end
		break 							-- last frame's advanced RNG value matches the current. Stop loop.
	end
end


gui.text(180,10,string.format("%d/%d/%d",month,day,2000+year))					-- Display Date
gui.text(180,19,string.format("%02d:%02d:%02d",hour,minute,second,delay))		-- Display Time

-- Check to see if the MTRNG changed, only if tracking is enabled.
if mttrack==1 and notrestored == 0 then
	if (lmtp>mtp and delay > 50 and notrestored==0) or (lmtp==mtp and lastm~=mtv) then
			strmtv=string.format("%08X",mtv)		-- Mersenne Twister untempered is in one format while the memory is in another
			strnmt=string.format("%08X",nextmt)		-- Convert to a string hex so that they can be equated when their decimal isn't
		if strmtv~=strnmt  then 					-- New untempered table value isn't as predicted, so the c-gear was turned on!
			mttrack=1
			-- print(strmtv,strnmt,string.format("%08X",lastm)) -- debug for bad initialize
			if wasrestored==1 then print(""..string.format("Earlier restoration may have failed. Double Check.")) print(""..string.format("If C-Gear was just turned on this frame, ignore.")) print(""..string.format("")) wasrestored=0 end
			-- mttrack=0
			--else
			print(""..string.format("C-Gear turned on. Determining C-Gear Seed and restarting tracking."))
			steptable=1
			wdword(storage+0x4*1, steptable)
			-- Finding the C-Gear seed you hit
			-- Load Time Values
				hour=string.format("%02X",(timehex%0x100)%0x40)				-- Memory stores as decimal, but Lua reads as hex. Convert.
				minute=string.format("%02X",(rshift(timehex%0x10000,8)))
				second=string.format("%02X",(mbyte(0x02FFFDEE)))
				year=string.format("%02X",(mbyte(0x02FFFDE8)))
				month=string.format("%02X",(mbyte(0x02FFFDE9)))
				day=string.format("%02X",(mbyte(0x02FFFDEA)))
						ab=(month*day+minute+second)%256
						cd=hour
						cgd=delay%65536-1									-- Delay from a frame before is used.
						abcd=ab*0x100+cd
						efgh=(year+cgd)%0x10000
						tempcgear=(ab*0x1000000+cd*0x10000+efgh+mac)%0x100000000
				randomseed(tempcgear)
				trialseed=random_int32()
				tempcgearuntemp=string.format("%08X",trialseed)
				if strmtv~=tempcgearuntemp then
					second=second-1					-- Subtract a second to check a different set.
					if second < 0 then				-- Balaning minutes
						second=59
						minute=minute-1
						if minute<0 then			-- Balancing Hours
							minute=59
							hour=hour-1
						end
					end
					ab=(month*day+minute+second)%256	-- Rebuild seed, try again.
					cd=hour
					abcd=ab*0x100+cd
					efgh=(year+cgd)%0x10000
					tempcgear=(ab*0x1000000+cd*0x10000+efgh+mac)%0x100000000
					randomseed(tempcgear)
					trialseed=random_int32()
					tempcgearuntemp=string.format("%08X",trialseed)
				end

				initm=tempcgear
				print(""..string.format("C-Gear Seed: %08X    Delay: %d",tempcgear,cgd))
				print(""..string.format(""))				-- Visual Blank Line
				cgearenabled=2
				wdword(storage+0x4*8,cgearenabled)
				if initm>0x7FFFFFFF then wdword(storage+0x4*2,initm-0x100000000) else wdword(storage+0x4*2,initm) end
				i=0
				while i~=624 do								-- get the next untempered for the cgear
					nextmt=math.floor(random_int32())
					i=i+1
				end --end
		else												-- untempered is as predicted -> predict next one for when the time rolls around

			i=0
			while i~=624 do									-- do 624 iterations to build the remaining 623 and the first of the next.
				nextmt=math.floor(random_int32())
				i=i+1
			end
		--print(""..string.format("Next: %08X", nextmt)) 	-- debug



			steptable=steptable+1 							-- mersenne twister has a new table as the counter is reset to 0; tables++

			wdword(storage+0x4*1, steptable)				-- save state storage of table refreshes
		end
	end
gui.text(1,160,string.format("MTRNG Seed: %08X",initm))
gui.text(1,150,string.format("Frame: %d",mtf))
-- gui.text(1,38,string.format("next mt: %08X", nextmt)) -- debug
end


-- Advancement Tracking for the PRNG and Mersenne Twister
total=adv+total										-- total advancements = advancements on this frame + total advancements from previous frames
if total-cachevalue>200 then						-- check to see if we should refresh the cached value
	cachevalue=total
end
mtf=mtp+(steptable-1)*2							-- Mersenne Twister Frame = Pointer Value + (TableRefresh-1)*2 ; this accounts for the initial value of 0x2 which is actually zero

gui.text(1,19,string.format("Frame: %d", total))	-- Display PRNG Frame; total advancements since the initial seed

-- If the user specifies they want to use the C-Gear

-- If user specifies they want to see the frame advancement chart
if research==0 then									-- Display framebased advancement table
gui.text(1,37,string.format("%d", jump1)) gui.text(1,46,string.format("%d", jump2)) gui.text(1,55,string.format("%d", jump3)) gui.text(1,64,string.format("%d", jump4))
gui.text(1,73,string.format("%d", jump5)) gui.text(1,82,string.format("%d", jump6)) gui.text(1,91,string.format("%d", jump7)) gui.text(1,100,string.format("%d", jump8))
gui.text(1,109,string.format("%d", jump9)) gui.text(1,118,string.format("%d", jump10)) gui.text(20,37,string.format("%d", jump11)) gui.text(20,46,string.format("%d", jump12))
gui.text(20,55,string.format("%d", jump13)) gui.text(20,64,string.format("%d", jump14))	gui.text(20,73,string.format("%d", jump15))	gui.text(20,82,string.format("%d", jump16))
gui.text(20,91,string.format("%d", jump17)) gui.text(20,100,string.format("%d", jump18)) gui.text(20,109,string.format("%d", jump19)) gui.text(20,118,string.format("%d", jump20))
end

-- Set Up variables for next frame's pass
lmtp=mtp
last=seed1
lastm=mtv
if lastm>0x7FFFFFFF then wdword(storage+0x4*7,lastm-0x100000000) else wdword(storage+0x4*7,lastm) end
	wdword(storage+0x4*6,total)
			if seed1>0x7FFFFFFF then wdword(storage+0x4*5,seed1-0x100000000) else wdword(storage+0x4*5,seed1) end

notrestored=0
-- End Lua
end

gui.register(main)
emu.reset()