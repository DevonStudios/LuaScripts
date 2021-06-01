rshift=bit.rshift

local gamelang = memory.readbyte(0x080000AF)

if gamelang == 0x4A then 	 --J = 4A
 off = 0
 frameoff = 0
elseif gamelang == 0x45 then --U = 45
 off = 0xD0
 frameoff = 0x90
else					 	 --E all the rest
 off = 0xE0
 frameoff = 0x90
end 

local initial = 0
local framecounter
local tinitial = 0
local frame = 0
local adjustFrame = 0
local calibrationFrame = 0
local backSeed = 0
local table={}
local delay = 0

joypad.set(1, {A=true, B=true, select=true, start=true})
 
function next(s)	
 local a=0x41C6*(s%65536)+rshift(s,16)*0x4E6D
 local b=0x4E6D*(s%65536)+(a%65536)*65536+0x6073
 local c=b%4294967296
 return c
end

-- Thanks to https://github.com/kwsch/FindFrame/blob/master/FindFrame.py#L37-L42
function back(s)	
  local a=0xEEB9*(s%65536)+rshift(s,16)*0xEB65
  local b=0xEB65*(s%65536)+(a%65536)*65536+0x0A3561A1
  local c=b%4294967296
  return c
 end

print("New Order of Breeding x Real.96")

while true do

 seed = memory.readdwordunsigned(0x03004748+off)
 framecounter = memory.readdwordunsigned(0x03001700+frameoff)
 
 if seed <= 0xFFFF and frame < 8 then							-- start counting the Frame
  initial = memory.readwordunsigned(0x03004748+off)				-- when Initial Seed is generated
  tinitial = initial
 end
	
 if frame > 4 then
  tinitial = next(tinitial)
 end
	
 frame = frame + 1
	
 if seed == 0 and framecounter == 0 then 						-- restarting the Frame if there is a soft-reset
  initial = 0			
  frame = 0			
  adjustFrame = 0			
 end			
			
 if frame > 4 and tinitial ~= seed then           				-- Tracked seed doesn't match game seed
  backSeed = tinitial                            				-- Setup
  calibrationFrame = 0			
			
  while tinitial ~= seed and backSeed ~= seed do 				-- Find frame difference
   tinitial = next(tinitial)			
   backSeed = back(backSeed)			
   calibrationFrame = calibrationFrame + 1			
  end			
			
  if backSeed == seed then                      				-- Previous save state was loaded - move frames back
    adjustFrame = adjustFrame - calibrationFrame			
    tinitial = seed                             				-- Adjust our tracked seed
  else                                          				-- Game advanced extra frames or future save state was loaded
    adjustFrame = adjustFrame + calibrationFrame
  end

 end
 
 table=joypad.get(1)
 if table.select then
  startsearchdelay = 1
  framedelay = 0
  seed2 = memory.readdword(0x03004748+off)
  j = 0
  delay = 0
 end
 if startsearchdelay == 1 then  
  if j <= 150 and delay == 0 then
   skips = 0
   seed3 = memory.readdword(0x03004748+off)
    
  if seed3 ~= seed2 then
   while seed3 ~= seed2 do
    seed2 = next(seed2)
    skips = skips + 1
    end
   end
    
   framedelay = framedelay + skips
    
   print(j,string.format("%08X",seed3), framedelay, "+"..skips)
   
   if skips == 4 and framedelay > 120 then
    delay = framedelay-2
    print("Delay: ", delay)
	startsearchdelay = 0
   end
    
   seed2 = seed3
   j = j + 1
  end
  if j == 150 then
   startsearchdelay = 0
  end
 end
 
 gui.text(0,95,adjustFrame+frame-5)
 gui.text(0,115,"Initial Seed: "..string.format("%04X", initial)) 

 emu.frameadvance()

end