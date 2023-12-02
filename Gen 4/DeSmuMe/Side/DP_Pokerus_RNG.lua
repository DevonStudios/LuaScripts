mdword=memory.readdwordunsigned
rshift=bit.rshift

local gamelang = memory.readbyte(0x02FFFE0F)

if gamelang == 0x49 then --I = 49, E/U all the rest
 off = 0
elseif gamelang == 0x45 then --U = 45
 off = 0xE0
elseif gamelang == 0x4A then --J = 4A
 off = -(0x1780)
elseif gamelang == 0x44 then --D = 44
 off = -(0x60)
elseif gamelang == 0x46 then --F = 46
 off = -(0xA0)
elseif gamelang == 0x53 then --S = 53
 off = -(0xC0)
else --K = 4B
 off = 0x2AE0
end

local currseed2 = mdword(0x021C4E28-off)
local initial = currseed2
local singlepress = 0										--check that the Select button is pressed only one time
local offset = 0
local table={}
local delay

function next(s)	
 local a=0x41C6*(s%65536)+rshift(s,16)*0x4E6D
 local b=0x4E6D*(s%65536)+(a%65536)*65536+0x6073
 local c=b%4294967296
 return c
end

function back(s)	
  local a=0xEEB9*(s%65536)+rshift(s,16)*0xEB65
  local b=0xEB65*(s%65536)+(a%65536)*65536+0x0A3561A1
  local c=b%4294967296
  return c
end
 
print("New Order of Breeding x Real.96")
 
while true do
 
table=joypad.get(1)
 if table.select and singlepress == 0 then
  startsearchdelay = 1
  framedelay = 1
  j = 1
  delay = 0
 end
 if startsearchdelay == 1 then
  if j <= 950 and delay == 0 then
   singlepress = 1
   skips = 0
   currseed3 = mdword(0x021C4E28-off)
    
   if currseed3 ~= currseed2 then
    while currseed3 ~= currseed2 do
     currseed2 = next(currseed2)
     skips = skips + 1
    end
   end
    
   framedelay = framedelay + skips
    
   print(j,string.format("%08X",currseed3), framedelay, "+"..skips)
   
   if skips == 3 and framedelay > 250 then
    delay = framedelay-2
    print("Delay: ", delay)
	print("Initial Seed: ", string.format("%08X",back(initial)))	
	startsearchdelay = 0
	break
   end
    
   currseed2 = currseed3
   j = j + 1
  end
  if j == 950 then
   startsearchdelay = 0
   break
  end
 end
 
 emu.frameadvance()
 emu.frameadvance()
 
end

function main()
 currseed = mdword(0x021C4E28-off)
 tinitial = back(initial)
 frame = 0
 
 if back(initial) ~= currseed and currseed ~= 0 then		-- PIDRNG Frame Counting
  tinitial = back(initial)
  while tinitial ~= currseed do
   tinitial = next(tinitial)
   frame = frame + 1
   if frame > 99999 then 
    break
   end
  end
 end
 
 gui.text(0,180,string.format("Initial Seed: %08X", back(initial)))
 gui.text(0,170,string.format("Current Frame: %d", frame))
 
end
 
gui.register(main)