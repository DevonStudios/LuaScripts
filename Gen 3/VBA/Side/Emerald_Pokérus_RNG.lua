rshift=bit.rshift

local gamelang = memory.readbyte(0x080000AF)

if gamelang == 0x4A then --J = 4A, E/U all the rest
 off = 0
 frameoff = 0
else
 off = 0x2A0
 frameoff = 0x35C
end 

local initial = memory.readwordunsigned(0x02020000)
local seed = 0x03005AE0+off
local offset = 0
local table={}
local delay = 0
 
print("New Order of Breeding x Real.96")
 
while true do

 frame = memory.readdword(0x02024664+frameoff)
 
 table=joypad.get(1)
 if table.select then
  startsearchdelay = 1
  initialframe = memory.readdword(0x02024664+frameoff)
  j = 0
  delay = 0
 end
 if startsearchdelay == 1 then  
  if j <= 150 and delay == 0 then
   frame = memory.readdword(0x02024664+frameoff)
   
   print(j,string.format("%08X",memory.readdword(seed)), frame - initialframe, "+"..frame - offset)
   
   if frame - offset == 4 and frame - initialframe > 120 then
	delay = frame - initialframe - 2
    print("Delay: "..delay)
	startsearchdelay = 0
   end
   j = j + 1
  end
  if j == 150 then
   startsearchdelay = 0
  end
 end
 
 offset = frame
 gui.text(0,95,frame)
 gui.text(0,115,"Initial Seed: "..string.format("%04X", initial)) 
 
 emu.frameadvance()
 
end