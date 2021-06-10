mdword = memory.readdwordunsigned
mword = memory.readwordunsigned
mbyte = memory.readbyte
rshift = bit.rshift
lshift = bit.lshift
band = bit.band
bor = bit.bor
floor = math.floor

local gameVersion = mbyte(0x080000AE)
local game
local gameLang = mbyte(0x080000AF)
local language = ""
local warning
local itemPrize = {"PP-UP", "Exp. Share", "Max Revive", "Master Ball"}
local itemIndex = 1
local winningTicket = 0
local key = {}
local prevKey = {}
local table = {}
local arrowColumnIndex = 0
local arrowRowIndex = 0
local showLotteryPrizes = false

local saveBlockPointer
local selectedBoxPID

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

if game == "Ruby" or game == "Sapphire" then
 if gameLang == 0x4A then
  language = "JPN"
  saveBlockPointer = 0x0201E7D4
  prngAddr = 0x03004748
  idsAddr = 0x02024C0E
 elseif gameLang == 0x45 then
  language = "USA"
  saveBlockPointer = 0x0201EA74
  prngAddr = 0x3004818
  idsAddr = 0x02024EAE
 else
  language = "EUR"
  saveBlockPointer = 0x0201EA74
  prngAddr = 0x03004828
  idsAddr = 0x02024EAE
 end
elseif game == "Emerald" then
 if gameLang == 0x4A then
  language = "JPN"
  saveBlockPointer = 0x03005AEC
  prngAddr = 0x03005AE0
  idsAddr = 0x03005AF0
 else
  language = "USA/EUR"
  saveBlockPointer = 0x03005D8C
  prngAddr = 0x03005D80
  idsAddr = 0x3005D90
 end
end

if game ~= "Ruby" and game ~= "Sapphire" and game ~= "Emerald" then
 warning = " - Wrong game version! Use Ruby/Sapphire/Emerald instead"
else
 warning = ""
end

print("Devon Studios x Real.96")
print()
print("Game Version: "..game..warning)
print("Language: "..language)

function next(s, mul1, mul2, sum)
 local a = mul1 * (s % 65536) + rshift(s, 16) * mul2
 local b = mul2 * (s % 65536) + (a % 65536) * 65536 + sum
 local c = b % 4294967296

 return c
end

function nextCurrSeedForLottery(seed)
 local lotteryDelay
 
 if game == "Emerald" then
  lotteryDelay = 84
 else
  lotteryDelay = 25
 end

 for i = 1, lotteryDelay do
  seed = next(seed, 0x41C6, 0x4E6D, 0x6073)
 end

 return rshift(seed, 16)
end

function convertToLotterySeed(seed)
 return next(seed, 0x41C6, 0x4E6D, 0x3039)
end

function getCurrLotterySeed()
 local pointer
 local off

 if game == "Emerald" then
  pointer = mdword(saveBlockPointer)
  off = 0x6C64
 else
  pointer = saveBlockPointer
  off = 0
 end

 lotteryHighSeed = mword(pointer + (2 * 0x404B) - off)
 lotteryLowSeed = mword(pointer + (2 * 0x404C) - off)

 return bor(lshift(lotteryLowSeed, 16), lotteryHighSeed)
end

function getMatchingDigits(lotteryNumber)
 local idsPointer
 
 if game == "Emerald" then
  idsPointer = mdword(idsAddr) + 0xA
 else
  idsPointer = idsAddr
 end

 ids = mdword(idsPointer)
 tid = ids % 0x10000

 matchingDigits = 0
 
 for i = 1, 5 do
  checkedLotteryNumber = lotteryNumber % 10
  checkedTid = tid % 10

  if checkedLotteryNumber == checkedTid then
   lotteryNumber = floor(lotteryNumber / 10)
   tid = floor(tid / 10)
   matchingDigits = matchingDigits + 1
  else
   break
  end
 end
 
 return matchingDigits == itemIndex + 1
end

function findWinningLotteryTicketSeed(seed)
 i = 0
 while not getMatchingDigits(band(convertToLotterySeed(nextCurrSeedForLottery(seed)), 0xFFFF)) do
  seed = next(seed, 0x41C6, 0x4E6D, 0x6073)
  i = i + 1
 end

 return i
end

function printItems()
 z = 0
 for i = 0, 1 do
  for j = 0, 1 do
   gui.text(105 + (72 * j), 43 + (10 * i), itemPrize[i + j + z + 1])
  end
  z = z + 1
 end
 gui.text(98 + (72 * arrowColumnIndex), 43 + (10 * arrowRowIndex), ">")
end

while warning == "" do
 key = input.get()
 if key["3"] and not prevKey["3"] then
  showLotteryPrizes = true
 elseif key["4"] and not prevKey["4"] then
  showLotteryPrizes = false
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
   if arrowRowIndex < 1 then
    arrowColumnIndex = 0
    arrowRowIndex = arrowRowIndex + 1
   else
    arrowColumnIndex = 1
   end
  end
  if itemIndex < 4 then
   itemIndex = itemIndex + 1
  end
 end
 prevKey = key

 currSeed = mdword(prngAddr)
 nextLotterySeed = convertToLotterySeed(nextCurrSeedForLottery(currSeed))
 nextLotteryNumber = band(nextLotterySeed, 0xFFFF)
 lotterySeed = getCurrLotterySeed()

 table = joypad.get(1)
 if table.select then
  winningTicket = findWinningLotteryTicketSeed(currSeed)
 end

 if showLotteryPrizes then
 gui.text(155, 25, "4 - Hide Items")
 printItems()
 else
 gui.text(155, 25, "3 - Show Items")
 end

 gui.text(0, 85, string.format("Next Lottery Seed: %08X (%05d)", nextLotterySeed, nextLotteryNumber))
 gui.text(0, 95, string.format("Lottery Seed: %08X", lotterySeed))
 gui.text(0, 105, string.format("Lottery Number: %05d", band(lotterySeed, 0xFFFF)))
 gui.text(0, 115, string.format("Next Winning Lottery Ticket: "..winningTicket))
 gui.text(0, 125, "Item Prize: "..itemPrize[itemIndex])

 if winningTicket ~= 0 then
  winningTicket = winningTicket - 1
 end

 emu.frameadvance()
end