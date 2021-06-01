rshift=bit.rshift

local enc_lcrng_add = 0x20386D0
local encRate_bonus_addr = enc_lcrng_add + 0x6
local enc_time_addr = enc_lcrng_add + 0x8
local encRate
local encRate_flag = 0
local previous_bonus = 0
local encR_bonus = 0
local mod_seed = 0

function enc_lcrng_f(s)	
 local a=0x41C6*(s%65536)+rshift(s,16)*0x4E6D
 local b=0x4E6D*(s%65536)+(a%65536)*65536+0x3039
 local c=b%4294967296
 return c
end

while true do
 enc_lcrng = memory.readdwordunsigned(enc_lcrng_add)
 next_seed = enc_lcrng
 bonus = memory.readwordunsigned(encRate_bonus_addr)
 enc_time = memory.readbyte(enc_time_addr)
 counter = 0
 
 
 if bonus == 0 then
  encRate_flag = 0
  encRate = 0
 end
 
 if bonus ~= 0 and encRate_flag ~= 1 then
  encRate = 16 * bonus
  encRate_flag = 1
 end
 
 if previous_bonus ~= bonus then
  encR_bonus = math.floor((16 * bonus) / 200)
  previous_bonus = bonus
 end
 
 check = false
 
 while (encRate+encR_bonus) ~= 0 and check == false do
	next_seed = enc_lcrng_f(next_seed)
	mod_seed = (rshift(next_seed,0x10))%0x640
	counter = counter + 1
	if mod_seed < encRate+encR_bonus then
	 check = true
	end
 end
 
 gui.text(0,0,"Actual: "..string.format("%08X", enc_lcrng))
 
 gui.text(0,107, counter)
 gui.text(0,115,"16high_N: "..string.format("%04X", next_seed))
 gui.text(0,123,"Mod_A: "..string.format("%04X", mod_seed))
 gui.text(0,131,"int mod_seed: "..mod_seed)
 
 gui.text(0,143,"encRate: "..encRate)
 gui.text(60,143, encRate+encR_bonus)
 gui.text(0,151,"Bonus: "..bonus)
 gui.text(60,151,"Battle Time? "..enc_time)
 emu.frameadvance()
end