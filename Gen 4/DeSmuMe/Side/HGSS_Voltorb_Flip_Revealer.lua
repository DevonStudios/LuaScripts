read32Bit = memory.readdwordunsigned
read16Bit = memory.readwordunsigned
read8Bit = memory.readbyte

local gameVersionAddr = 0x02FFFE08
local game
local gameLang = read8Bit(0x02FFFE0F)
local language = ""
local warning

local panelTablePointer
local gameVersionOffset = 0

if read16Bit(gameVersionAddr) == 0x4C50 then  -- Check game version
 game = "Platinum"
elseif read8Bit(gameVersionAddr) == 0x44 then
 game = "Diamond"
elseif read8Bit(gameVersionAddr) == 0x50 then
 game = "Pearl"
elseif read16Bit(gameVersionAddr) == 0x4748 then
 game = "HeartGold"
elseif read16Bit(gameVersionAddr) == 0x5353 then
 game = "SoulSilver"
 gameVersionOffset = 0x20
end

if gameLang == 0x44 then  -- Check game language
 language = "GER"
 panelTablePointer = 0x021D10F0
elseif gameLang == 0x45 then
 language = "USA"
 panelTablePointer = 0x021D1110
elseif gameLang == 0x46 then
 language = "FRE"
 panelTablePointer = 0x021D1130
elseif gameLang == 0x49 then
 language = "ITA"
 panelTablePointer = 0x021D10B0
elseif gameLang == 0x4A then
 language = "JPN"
 panelTablePointer = 0x021D0650
elseif gameLang == 0x4B then
 language = "KOR"
 panelTablePointer = 0x021D1B10
elseif gameLang == 0x53 then
 language = "SPA"
 panelTablePointer = 0x021D1130 + gameVersionOffset
end

if game ~= "HeartGold" and game ~= "SoulSilver" then
 warning = " - Wrong game version! Use HeartGold/SoulSilver instead"
else
 warning = ""
end

print("Game Version: "..game..warning)
print("Language: "..language)

function showPanelTable()
 local panelTablePointerAddr = read32Bit(panelTablePointer) + 0x244
 local panelTableAddr = read32Bit(panelTablePointerAddr)

 for i = 0, 4 do
  for j = 0, 4 do
   local tileContent = read8Bit(panelTableAddr + (((i * 5) + j) * 0xC))
   gui.text(j * 32 + 15, i * 32 + 15, tileContent ~= 4 and string.format("x%d", tileContent) or "B")
  end
 end
end

function main()
 showPanelTable()
end

gui.register(main)