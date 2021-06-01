rshift = bit.rshift
lshift = bit.lshift

local gameLang = memory.readbyte(0x080000AF)
local gameVersion = memory.readbyte(0x080000AE)

if gameLang == 0x4A then  -- Check game language
 language = "JPN"
 seedOff = 0
elseif gameLang == 0x45 then
 language = "USA"
 seedOff = 0x60
else
 language = "EUR"
 seedOff = -0x50
end

if gameVersion == 0x56 then  -- Check game version
 game = "Ruby"
elseif gameVersion == 0x50 then
 game = "Sapphire"
elseif gameVersion == 0x52 then
 game = "FireRed"
elseif gameVersion == 0x47 then
 game = "LeafGreen"
elseif gameVersion == 0x45 then
 game = "Emerald"
end

if game ~= "FireRed" and game ~= "LeafGreen" then
 warning = " - Wrong game version! Use FireRed/LeafGreen instead"
else
 warning = ""
end

print("DevonStudios x Real.96")
print()
print("Game Version: "..game..warning)
print("Language: "..language)

local items = {"Oran Berry", "Cheri Berry", "Chesto Berry", "Pecha Berry", "Rawst Berry", "Aspear Berry", "Persim Berry", "TM10",
			   "PP Plus", "Rare Candy", "Nugget", "Spelon Berry", "Pamtre Berry", "Watmel Berry", "Durin Berry", "Belue Berry"}
local itemInterval = {0, 0x0F, 0x19, 0x23, 0x2D, 0x37, 0x41, 0x4B, 0x50, 0x55, 0x5A, 0x5F, 0x60, 0x61, 0x62, 0x63, 0x256}
local arrowColumnIndex = 0
local arrowRowIndex = 0
local itemIndex = 1
local key = {}
local prevKey = {}
local table = {}
local meowth = 1
local delay = 0
local isPickup = false
local isFound = false
local itemValue = 0
local frameDifference = 0
local pickupInstructions = false

function LCRNG(s)
 local a = 0x41C6 * (s % 65536) + rshift(s, 16) * 0x4E6D
 local b = 0x4E6D * (s % 65536) + (a % 65536) * 65536 + 0x6073
 local c = b % 4294967296
 return c
end

function next(s, n)
 n = n or 1
 local t = s
 for i = 1, n do
  s = LCRNG(s)
 end
 return s
end

function pickupCheck(seed, n)
 n = n or 0
 return rshift(next(seed, n), 16) % 0xA == 0
end

function getItem(seed, n)
 n = n or 1
 return rshift(next(seed, n), 16) % 0x64
end

function searchItem(startingSeed, delayFound, lowLimit, highLimit, meowth)
 local t = startingSeed
 for i = 1, delayFound do
  t = next(t)
 end
 isPickup = pickupCheck(t)
 itemValue = getItem(t, 1)
 isPickup2 = pickupCheck(t, 2)
 itemValue2 = getItem(t, 3)
 --[[isPickup3 = pickupCheck(t, 4)
 itemValue3 = getItem(t, 5)
 isPickup4 = pickupCheck(t, 6)
 itemValue4 = getItem(t, 7)
 isPickup5 = pickupCheck(t, 10)
 itemValue5 = getItem(t, 11)
 isPickup6 = pickupCheck(t, 12)
 itemValue6 = getItem(t, 13)]]

 if isPickup and itemValue >= lowLimit and itemValue < highLimit then
  if meowth == 2 then
   if isPickup2 and itemValue2 >= lowLimit and itemValue2 < highLimit then
    --if isPickup3 and itemValue3 >= lowLimit and itemValue3 < highLimit then
     --if isPickup4 and itemValue4 >= lowLimit and itemValue4 < highLimit then
      --if isPickup5 and itemValue5 >= lowLimit and itemValue5 < highLimit then
       --if isPickup6 and itemValue6 >= lowLimit and itemValue6 < highLimit then
	    return true
       --end
	  --end
	 --end
    --end
   end
  else
   return true
  end
 end
 return false
end

function printItems(i, j)
 z = 0
 for i = 0, 7 do
  for j = 0, 1 do
   gui.text(105+(72*j),43+(10*i), items[i + j + z + 1])
  end
  z = z + 1
 end
end

while true do
 key = input.get()
 if key["5"] and not prevKey["5"] then
  if meowth > 1 then
   meowth = meowth - 1
  end
 elseif key["6"] and not prevKey["6"] then
  if meowth < 2 then
   meowth = meowth + 1
  end
 end
 
 if key["3"] and not prevKey["3"] then
  pickupInstructions = true
 elseif key["4"] and not prevKey["4"] then
  pickupInstructions = false
 end

 if key["1"] and not prevKey["1"] then
  arrowColumnIndex = arrowColumnIndex - 1
  if arrowColumnIndex < 0 then
   if arrowRowIndex > 0 then
    arrowColumnIndex = 1
    arrowRowIndex = arrowRowIndex - 1
   else
    arrowColumnIndex = 0
   end
  end
  if itemIndex > 1 then
   itemIndex = itemIndex - 1
  end
 elseif key["2"] and not prevKey["2"] then
  arrowColumnIndex = arrowColumnIndex + 1
  if arrowColumnIndex > 1 then
   if arrowRowIndex < 7 then
    arrowColumnIndex = 0
    arrowRowIndex = arrowRowIndex + 1
   else
    arrowColumnIndex = 1
   end
  end
  if itemIndex < 16 then
   itemIndex = itemIndex + 1
  end
 end
 prevKey = key

 currSeed = memory.readdword(0x03004FA0 + seedOff)

 if frameDifference ~= 0 then
  frameDifference = frameDifference - 2
 end

 table = joypad.get(1)
 if table.select then
  startsearchdelay = 1
  framedelay = 2
  skips2 = 0
  seed2 = currSeed
  delayCounter = 0
  delay = 0
  state = savestate.create()
  savestate.save(state)
 end

 if startsearchdelay == 1 then
  if delayCounter <= 150 and delay == 0 then
   skips = 0

   if delayCounter == 0 then
    seedstart = currSeed
   end

   seed3 = currSeed

  if seed3 ~= seed2 then
   while seed3 ~= seed2 do
    seed2 = next(seed2)
    skips = skips + 1
    end
   end

   framedelay = framedelay + skips
   --print(delayCounter,string.format("%08X",seed3), framedelay, "+"..skips)

   if skips > skips2 and framedelay > 60 then
    delay = framedelay - ((skips - skips2) - 1)
    --print("Delay: ", delay)
	startsearchdelay = 0
   end

   skips2 = skips
   seed2 = seed3
   delayCounter = delayCounter + 1
  end

  if delayCounter == 150 then
   startsearchdelay = 0
  end
 end

 if delay ~= 0 then
  savestate.load(state)
  isFound = searchItem(seedstart, delay, itemInterval[itemIndex], itemInterval[itemIndex+1], meowth)
  while isFound ~= true or frameDifference % 2 ~= 0 do
   seedstart = next(seedstart)
   isFound = searchItem(seedstart, delay, itemInterval[itemIndex], itemInterval[itemIndex+1], meowth)
   frameDifference = frameDifference + 1
  end
  frameDifference = frameDifference + 2
  gui.text(0,105, "Delay Found!")
  gui.text(0,115, "Advancements: "..frameDifference / 2)
  --print("Advancements: ", frameDifference / 2)
  delay = 0
  emu.pause()
 end

 if pickupInstructions then
 gui.text(155,25, "4 - Hide Items")
 else
 gui.text(155,25, "3 - Show Items")
 end

 if pickupInstructions then
  gui.text(98+(72*arrowColumnIndex),43+(10*arrowRowIndex), ">")
  printItems(i, j)
 end

 gui.text(0,105, "N of Meowth: "..meowth)
 gui.text(0,115, "Item: "..items[itemIndex])
 gui.text(0,125, "Frame Counter: "..frameDifference / 2)

 emu.frameadvance()
end