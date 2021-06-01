rshift=bit.rshift
lshift=bit.lshift

--local gamelang = memory.readbyte(0x080000AF)

--[[if gamelang == 0x4A then 	 --J = 4A
 off = 0
 frameoff = 0
elseif gamelang == 0x45 then --U = 45
 off = 0xD0
 frameoff = 0x90
else					 	 --E all the rest
 off = 0xE0
 frameoff = 0x90
end ]]

local table={}
local delay = 0
local crithit = 1
local iscritical = 1
local off = 1
local check = 0
 
function next(s)	
 local a=0x41C6*(s%65536)+rshift(s,16)*0x4E6D
 local b=0x4E6D*(s%65536)+(a%65536)*65536+0x6073
 local c=b%4294967296
 return c
end

function calchit(currseed)
 local t = currseed
 return rshift(t,16)-lshift(rshift(rshift(t,16), 4), 4)
end

function searchit(startingseed,delayfound)
 local t = startingseed
 for i=1,delayfound do
  t = next(t)
 end
 return calchit(t)
end

print("New Order of Breeding x Real.96")

while true do

 seed = memory.readdwordunsigned(0x03004F50)
 framedifference = 0
 
 table=joypad.get(1)
 if table.start then
  startsearchdelay = 1
  framedelay = 0
  skips2 = 0
  seed2 = memory.readdword(0x03004F50)
  j = 0
  delay = 0
  state = savestate.create()
  savestate.save(state)
 end
 
 if startsearchdelay == 1 then  
  if j <= 150 and delay == 0 then
   skips = 0
   seed3 = memory.readdword(0x03004F50)
    
  if seed3 ~= seed2 then
   while seed3 ~= seed2 do
    seed2 = next(seed2)
    skips = skips + 1
    end
   end
    
   framedelay = framedelay + skips
    
   print(j,string.format("%08X",seed3), framedelay, "+"..skips)
   
   if skips > skips2 and framedelay > 60 then
    delay = framedelay
    print("Delay: ", delay)
	startsearchdelay = 0
   end
   
   skips2 = skips
   seed2 = seed3
   j = j + 1
   check = 1
  end
  if j == 150 then
   startsearchdelay = 0
  end
 end
 
 if delay ~= 0 then
  iscritical = seed
  off = skips2 - 1
  while searchit(iscritical,delay) ~= 0 or framedifference % (skips2 - 1) ~= 0 do 
   iscritical = next(iscritical)
   framedifference = framedifference + 1
  end
  if (check == 1) then
   savestate.load(state)
   emu.pause()
   check = 0
  end
 end
 
 if framedifference == 0 then
  gui.text(0,115, "Critical Hit")
 else
  gui.text(0,115, "Normal Hit")
 end
 gui.text(0,125,framedifference / off)

 emu.frameadvance()

end