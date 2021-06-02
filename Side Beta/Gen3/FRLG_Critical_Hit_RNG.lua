mdword = memory.readdwordunsigned
mbyte = memory.readbyte
rshift = bit.rshift
band = bit.band

local gameLang = mbyte(0x080000AF)

if gameLang == 0x4A then -- J = 0x4A
 currSeedAddr = 0x03004FA0
elseif gameLang == 0x45 then -- U = 0x45
 currSeedAddr = 0x3005000
else -- E all the rest
 currSeedAddr = 0x03004F50
end

local table = {}
local delay = 0
local critHit = 1
local seedToCheck = 1
local off = 1
local reloadState = false

function next(s)
 local a = 0x41C6 * (s % 65536) + rshift(s, 16) * 0x4E6D
 local b = 0x4E6D * (s % 65536) + (a % 65536) * 65536 + 0x6073
 local c = b % 4294967296
 return c
end

function searcHit(startingSeed, delayFound) -- Find next seed that is going to be checked
 local t = startingSeed
 for i = 1, delayFound do
  t = next(t)
 end
 return t
end

function isCritHit(startingSeed, delayFound) -- Critical hit check
 hitSeed = searcHit(startingSeed, delayFound)
 return band(rshift(hitSeed, 16), 0xF) == 0
end

print("New Order of Breeding x Real.96")

while true do
 currSeed = mdword(currSeedAddr)
 frameDifference = 0

 table = joypad.get(1)
 if table.start then
  startDelayResearch = 1
  frameDelay = 0
  skips2 = 0
  seed2 = currSeed
  delayCounter = 0
  delay = 0
  state = savestate.create()
  savestate.save(state)
 end

 if startDelayResearch == 1 then -- Search critical hit delay
  if delayCounter <= 150 and delay == 0 then
   skips = 0
   seed3 = currSeed

  if seed3 ~= seed2 then
   while seed3 ~= seed2 do
    seed2 = next(seed2)
    skips = skips + 1
    end
   end

   frameDelay = frameDelay + skips

   print(delayCounter, string.format("%08X", seed3), frameDelay, "+"..skips)

   if skips > skips2 and frameDelay > 60 then
    delay = frameDelay
    print("Delay: ", delay)
    startDelayResearch = 0
    reloadState = true
   end

   skips2 = skips
   seed2 = seed3
   delayCounter = delayCounter + 1
  end
  if delayCounter == 150 then
   startDelayResearch = 0
  end
 end

 if delay ~= 0 then
  if reloadState then
   savestate.load(state)
   emu.pause()
   reloadState = false
  end
  seedToCheck = currSeed
  off = skips2 - 1
  while not isCritHit(seedToCheck, delay) or frameDifference % off ~= 0 do
   seedToCheck = next(seedToCheck)
   frameDifference = frameDifference + 1
  end
 end

 if frameDifference == 0 then
  gui.text(0, 115, "Critical Hit")
 else
  gui.text(0, 115, "Normal Hit")
 end
 gui.text(0, 125, frameDifference / off)

 emu.frameadvance()
end