mdword=memory.readdwordunsigned
mbyte=memory.readbyte
rshift=bit.rshift
lshift=bit.lshift

local initial = 0
local currseed = 0
local frame = 0
local iframe = 0
local predicted_bseed = 0

if mdword(0x02FFFE0C) == 0x49555043 then
 game = 'Pt'
 off = 0			-- Initial/Current Seed
 off2 = 0			-- Delay
 off3 = 0			-- IRNG Frame
elseif mdword(0x02FFFE0C) == 0x49414441 then
 game = 'D'
 off = 0x51B4		-- Initial/Current Seed
 off2 = 0x51BC		-- Delay
 off3 = 0x52F8		-- IVRNG Frame
elseif mdword(0x02FFFE0C) == 0x49415041 then
 game = 'P'
 off = 0x51B4		-- Initial/Current Seed
 off2 = 0x51BC		-- Delay
 off3 = 0x5300		-- IVRNG Frame
else
 game = 'HGSS'
 off = 0x118D4		-- Initial/Current Seed
 off2 = 0x118D0		-- Delay
 off3 = 0xECDC		-- IVRNG Frame
end

function buildseed()
 delay=mdword(0x021BF808+off2)+21
 timehex=mdword(0x023FFDEC)
 datehex=mdword(0x023FFDE8)
 hour=string.format("%02X",(timehex%0x100)%0x40)
 minute=string.format("%02X",(rshift(timehex%0x10000,8)))
 second=string.format("%02X",(mbyte(0x02FFFDEE)))
 year=string.format("%02X",(mbyte(0x02FFFDE8)))
 month=string.format("%02X",(mbyte(0x02FFFDE9)))
 day=string.format("%02X",(mbyte(0x02FFFDEA)))
 ab=(month*day+minute+second)%256		-- Build Seed
 cd=hour
 cgd=delay%65536 +1						-- can tweak for calibration
 abcd=ab*0x100+cd
 efgh=(year+cgd)%0x10000
 nextseed=ab*0x1000000+cd*0x10000+efgh	-- Seed is built
 return nextseed		
end

function next(s)
 local a=0x41C6*(s%65536)+rshift(s,16)*0x4E6D
 local b=0x4E6D*(s%65536)+(a%65536)*65536+0x6073
 local c=b%4294967296
 return c
end

function find_catch(s)
 if (predicted_bseed % 2 ~= initial % 2) then
  count = 0 
  
  for j = 0, 11 do
   s = next(s)
  end
  
  while rshift(s, 16) < 16643 and count < 4 do
   s = next(s)
   count = count + 1
  end
  
  if count == 4 then
   return true
  else
   return false
  end
  
 else
  return false
 end
end

function main()
 currseed = mdword(0x021BFC74+off)
 ivrngframeaddress = mdword(0x02100990+off3)
 delay = mdword(0x021BF808+off2)+21
 initial = mdword(0x021BFC78+off)
 tinitial = initial
 frame = 0
 battle_seed_address = mdword(0x21D10B0) + 0x2448 --eng 0x021D1110
 battle_seed = mdword(battle_seed_address)
 predicted_bseed = lshift(rshift(initial, 16), 16) + delay + 74
 counter = 0
 found = false
 
 while found == false do
  found = find_catch(predicted_bseed)
  
  if found ~= true then
   predicted_bseed = predicted_bseed + 1
  end
  
  counter = counter + 1
 end
 
 if initial == 0 then								-- if seed is 0, reset everything
  frame = 0
  iframe = 0
 end
 
 if initial ~= currseed and currseed ~= 0 then		-- PIDRNG Frame Counting
  tinitial = initial
  while tinitial ~= currseed do
   tinitial = next(tinitial)
   frame = frame + 1
   if frame > 9999 then 
    break
   end
  end
 end
 
 if ivrngframeaddress >= 624 then					-- IVRNG Frame Counting
  iframe = 0
 else
  iframe = ivrngframeaddress
 end
 
 if frame == 0 then
  gui.text(0,-10,string.format("Next Seed: %08X", buildseed()))
 end
 
 gui.text(0,180,string.format("Current Seed: %08X", currseed))
 gui.text(0,170,string.format("Initial Seed: %08X", initial))
 gui.text(0,160,string.format("Egg Frame: %d", iframe+1))
 gui.text(0,150,string.format("Current Frame: %d", frame))
 gui.text(0,140,string.format("Delay: %d", delay))
 gui.text(0,130,string.format("Battle Seed: %08X", predicted_bseed))
 gui.text(0,110,string.format("Battle Seed: %08X", battle_seed))
 gui.text(0,120,string.format("counter: %d", counter-1))
end

gui.register(main)
emu.reset()