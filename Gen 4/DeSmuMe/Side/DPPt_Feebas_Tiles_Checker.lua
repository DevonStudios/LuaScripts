mdword = memory.readdwordunsigned
mword = memory.readwordunsigned
mbyte = memory.readbyte
rshift = bit.rshift
band = bit.band

local gameVersion = mbyte(0x080000AE)
local game
local gameLang = mbyte(0x080000AF)
local language = ""
local warning

local feebasTiles = {0, 0, 0, 0}
local tiles = {
 [16] = {},
 [17] = {},
 [18] = {[9] = 0, [10] = 1, [11] = 2, [12] = 3, [13] = 4, [14] = 5, [15] = 6, [16] = 7, [17] = 8, [18] = 9, [19] = 10, [20] = 11, [21] = 12, [22] = 13, [23] = 14, [24] = 15, [25] = 16, [26] = 17},
 [19] = {[9] = 18, [10] = 19, [11] = 20, [12] = 21, [13] = 22, [14] = 23, [15] = 24, [16] = 25, [17] = 26, [18] = 27, [19] = 28, [20] = 29, [21] = 30, [22] = 31, [23] = 32, [24] = 33, [25] = 34, [26] = 35},
 [20] = {[9] = 36, [10] = 37, [11] = 38, [12] = 39, [13] = 40, [14] = 41, [15] = 42, [16] = 43, [17] = 44, [18] = 45, [19] = 46, [20] = 47, [21] = 48, [22] = 49, [23] = 50, [25] = 51, [26] = 52},
 [21] = {[9] = 53, [10] = 54, [11] = 55, [13] = 56, [14] = 57, [15] = 58, [16] = 59, [17] = 60, [18] = 61, [19] = 62, [20] = 63, [21] = 64, [22] = 65, [23] = 66, [24] = 67, [25] = 68, [26] = 69},
 [22] = {[9] = 70, [10] = 71, [11] = 72, [12] = 73, [13] = 74, [14] = 75, [15] = 76, [16] = 77, [17] = 78, [18] = 79, [19] = 80, [20] = 81, [21] = 82, [22] = 83, [23] = 84, [24] = 85, [25] = 86, [26] = 87},
 [23] = {[9] = 88, [10] = 89, [11] = 90, [12] = 91, [13] = 92, [14] = 93, [15] = 94, [16] = 95, [17] = 96, [18] = 97, [19] = 98, [20] = 99, [21] = 100, [22] = 101, [23] = 102, [24] = 103, [25] = 104, [26] = 105},
 [24] = {[9] = 106, [10] = 107, [11] = 108, [12] = 109, [13] = 110, [14] = 111, [15] = 112, [16] = 113, [17] = 114, [18] = 115, [19] = 116, [20] = 117, [21] = 118, [22] = 119, [23] = 120, [24] = 121, [25] = 122, [26] = 123},
 [25] = {[9] = 124, [10] = 125, [11] = 126, [12] = 127, [13] = 128, [14] = 129, [15] = 130, [16] = 131, [17] = 132, [18] = 133, [19] = 134, [20] = 135, [21] = 136, [22] = 137, [23] = 138, [24] = 139, [25] = 140, [26] = 141},
 [26] = {[9] = 142, [10] = 143, [11] = 144, [12] = 145, [13] = 146, [14] = 147, [15] = 148, [16] = 149, [17] = 150, [18] = 151, [19] = 152, [20] = 153, [21] = 154, [22] = 155, [23] = 156, [24] = 157, [25] = 158, [26] = 159},
 [27] = {[9] = 160, [10] = 161, [11] = 162, [12] = 163, [13] = 164, [14] = 165, [16] = 166, [17] = 167, [18] = 168, [19] = 169, [20] = 170, [21] = 171, [22] = 172, [23] = 173, [24] = 174, [25] = 175, [26] = 176},
 [28] = {[9] = 177, [10] = 178, [11] = 179, [12] = 180, [13] = 181, [14] = 182, [15] = 183, [16] = 184, [17] = 185, [18] = 186, [19] = 187, [20] = 188, [21] = 189, [22] = 190, [23] = 191, [24] = 192, [25] = 193, [26] = 194},
 [29] = {[9] = 195, [10] = 196, [11] = 197, [12] = 198, [13] = 199, [14] = 200, [15] = 201, [16] = 202, [24] = 203, [25] = 204, [26] = 205},
 [30] = {[9] = 206, [10] = 207, [11] = 208, [12] = 209, [13] = 210, [14] = 211, [15] = 212, [16] = 213, [24] = 214, [25] = 215, [26] = 216},
 [31] = {[9] = 217, [10] = 218, [11] = 219, [12] = 220, [13] = 221, [14] = 222, [15] = 223, [16] = 224, [24] = 225, [25] = 226, [26] = 227},
 [32] = {[9] = 228, [10] = 229, [13] = 230, [14] = 231, [15] = 232, [16] = 233, [24] = 234, [25] = 235, [26] = 236},
 [33] = {[9] = 237, [10] = 238, [13] = 239, [14] = 240, [15] = 241, [16] = 242, [24] = 243, [25] = 244, [26] = 245},
 [34] = {[9] = 246, [10] = 247, [11] = 248, [12] = 249, [13] = 250, [14] = 251, [15] = 252, [16] = 253, [24] = 254, [25] = 255, [26] = 256},
 [35] = {[9] = 257, [10] = 258, [11] = 259, [12] = 260, [13] = 261, [14] = 262, [15] = 263, [16] = 264, [24] = 265, [25] = 266, [26] = 267},
 [36] = {[9] = 268, [10] = 269, [11] = 270, [12] = 271, [13] = 272, [14] = 273, [15] = 274, [16] = 275, [17] = 276, [18] = 277, [19] = 278, [20] = 279, [23] = 280, [24] = 281, [25] = 282, [26] = 283},
 [37] = {[9] = 284, [10] = 285, [11] = 286, [12] = 287, [13] = 288, [14] = 289, [15] = 290, [16] = 291, [17] = 292, [18] = 293, [19] = 294, [20] = 295, [23] = 296, [24] = 297, [25] = 298, [26] = 299},
 [38] = {[9] = 300, [10] = 301, [11] = 302, [12] = 303, [13] = 304, [14] = 305, [15] = 306, [16] = 307, [17] = 308, [18] = 309, [19] = 310, [20] = 311, [21] = 312, [22] = 313, [23] = 314, [24] = 315, [25] = 316, [26] = 317},
 [39] = {[9] = 318, [10] = 319, [11] = 320, [12] = 321, [13] = 322, [14] = 323, [15] = 324, [16] = 325, [17] = 326, [18] = 327, [19] = 328, [20] = 329, [21] = 330, [22] = 331, [23] = 332, [24] = 333, [25] = 334, [26] = 335},
 [40] = {[9] = 336, [10] = 337, [11] = 338, [12] = 339, [13] = 340, [14] = 341, [15] = 342, [16] = 343, [17] = 344, [18] = 345, [19] = 346, [20] = 347, [21] = 348, [25] = 349, [26] = 350},
 [41] = {[9] = 351, [10] = 352, [11] = 353, [12] = 354, [13] = 355, [14] = 356, [15] = 357, [16] = 358, [17] = 359, [18] = 360, [19] = 361, [20] = 362, [21] = 363, [25] = 364, [26] = 365},
 [42] = {[9] = 366, [10] = 367, [11] = 368, [12] = 369, [13] = 370, [14] = 371, [15] = 372, [16] = 373, [17] = 374, [18] = 375, [19] = 376, [20] = 377, [21] = 378, [25] = 379, [26] = 380},
 [43] = {[9] = 381, [10] = 382, [11] = 383, [12] = 384, [13] = 385, [14] = 386, [15] = 387, [16] = 388, [17] = 389, [18] = 390, [19] = 391, [20] = 392, [21] = 393, [22] = 394, [23] = 395, [24] = 396, [25] = 397, [26] = 398},
 [44] = {[9] = 399, [10] = 400, [11] = 401, [12] = 402, [13] = 403, [14] = 404, [15] = 405, [16] = 406, [17] = 407, [18] = 408, [20] = 409, [21] = 410, [22] = 411, [23] = 412, [24] = 413, [25] = 414, [26] = 415},
 [45] = {[9] = 416, [10] = 417, [11] = 418, [15] = 419, [16] = 420, [17] = 421, [18] = 422, [19] = 423, [20] = 424, [21] = 425, [22] = 426, [23] = 427, [24] = 428, [25] = 429, [26] = 430},
 [46] = {[9] = 431, [10] = 432, [11] = 433, [15] = 434, [16] = 435, [17] = 436, [18] = 437, [19] = 438, [20] = 439, [21] = 440, [22] = 441, [23] = 442, [24] = 443, [25] = 444, [26] = 445},
 [47] = {[9] = 446, [10] = 447, [11] = 448, [15] = 449, [16] = 450, [17] = 451, [18] = 452, [19] = 453, [20] = 454, [23] = 455, [24] = 456, [25] = 457, [26] = 458},
 [48] = {[9] = 459, [10] = 460, [11] = 461, [12] = 462, [13] = 463, [14] = 464, [15] = 465, [16] = 466, [17] = 467, [18] = 468, [19] = 469, [20] = 470, [23] = 471, [24] = 472, [25] = 473, [26] = 474},
 [49] = {[9] = 475, [10] = 476, [12] = 477, [13] = 478, [14] = 479, [15] = 480, [16] = 481, [17] = 482, [18] = 483, [19] = 484, [20] = 485, [21] = 486, [22] = 487, [23] = 488, [24] = 489, [25] = 490, [26] = 491},
 [50] = {[9] = 492, [10] = 493, [11] = 494, [12] = 495, [13] = 496, [14] = 497, [15] = 498, [16] = 499, [17] = 500, [18] = 501, [19] = 502, [20] = 503, [21] = 504, [22] = 505, [23] = 506, [24] = 507, [25] = 508, [26] = 509},
 [51] = {[9] = 510, [10] = 511, [11] = 512, [12] = 513, [13] = 514, [14] = 515, [15] = 516, [16] = 517, [17] = 518, [18] = 519, [19] = 520, [20] = 521, [21] = 522, [22] = 523, [23] = 524, [24] = 525, [25] = 526, [26] = 527},
 [52] = {}
}

local feebasSeedPointer
local feebasSeedOff
local locationOff
local posXAddr
local posYAddr

if mword(0x02FFFE08) == 0x4C50 then  -- Check game version
 game = "Platinum"
elseif mbyte(0x02FFFE08) == 0x44 then
 game = "Diamond"
elseif mbyte(0x02FFFE08) == 0x50 then
 game = "Pearl"
elseif mword(0x02FFFE08) == 0x4748 then
 game = "HeartGold"
elseif mword(0x02FFFE08) == 0x5353 then
 game = "SoulSilver"
end

if game == "Diamond" or game == "Pearl" then
 if mbyte(0x02FFFE0F) == 0x4A then  -- Check game language
  language = "JPN"
  feebasSeedPointer = 0x02108944
  feebasSeedOff = 0x125B0
  locationOff = 0xE44C
  posXAddr = 0x021D0556
  posYAddr = 0x021D055E
 elseif mbyte(0x02FFFE0F) == 0x45 then
  language = "USA"
  feebasSeedPointer = 0x02106FAC
  feebasSeedOff = 0x125B0
  locationOff = 0xE44C
  posXAddr = 0x021CEF72
  posYAddr = 0x021CEF7A
 elseif mbyte(0x02FFFE0F) == 0x49 then
  language = "ITA"
  feebasSeedPointer = 0x0210708C
  feebasSeedOff = 0x125B0
  locationOff = 0xE44C
  posXAddr = 0x021CF052
  posYAddr = 0x021CF05A
 elseif mbyte(0x02FFFE0F) == 0x44 then
  language = "GER"
  feebasSeedPointer = 0x021070EC
  feebasSeedOff = 0x125B0
  locationOff = 0xE44C
  posXAddr = 0x021CF0B2
  posYAddr = 0x021CF0BA
 elseif mbyte(0x02FFFE0F) == 0x46 then
  language = "FRE"
  feebasSeedPointer = 0x0210712C
  feebasSeedOff = 0x125B0
  locationOff = 0xE44C
  posXAddr = 0x021CF0F2
  posYAddr = 0x021CF0FA
 elseif mbyte(0x02FFFE0F) == 0x53 then
  language = "SPA"
  feebasSeedPointer = 0x0210714C
  feebasSeedOff = 0x125B0
  locationOff = 0xE44C
  posXAddr = 0x021CF112
  posYAddr = 0x021CF11A
 elseif mbyte(0x02FFFE0F) == 0x4B then
  language = "KOR"
  feebasSeedPointer = 0x021045AC
  feebasSeedOff = 0x125DC
  locationOff = 0xE44C
  posXAddr = 0x021CC59E
  posYAddr = 0x021CC5A6
 end
elseif game == "Platinum" then
 if mbyte(0x02FFFE0F) == 0x4A then
  language = "JPN"
  feebasSeedPointer = 0x0210112C
  feebasSeedOff = 0x1262C
  locationOff = 0xE274
  posXAddr = 0x021C50E6
  posYAddr = 0x021C50EE
 elseif mbyte(0x02FFFE0F) == 0x45 then
  language = "USA"
  feebasSeedPointer = 0x02101D2C
  feebasSeedOff = 0x1262C
  locationOff = 0xE274
  posXAddr = 0x021C5CE6
  posYAddr = 0x021C5CEE
 elseif mbyte(0x02FFFE0F) == 0x49 then
  language = "ITA"
  feebasSeedPointer = 0x02101E8C
  feebasSeedOff = 0x1262C
  locationOff = 0xE274
  posXAddr = 0x021C5E46
  posYAddr = 0x021C5E4E
 elseif mbyte(0x02FFFE0F) == 0x44 then
  language = "GER"
  feebasSeedPointer = 0x02101ECC
  feebasSeedOff = 0x1262C
  locationOff = 0xE274
  posXAddr = 0x021C5E86
  posYAddr = 0x021C5E8E
 elseif mbyte(0x02FFFE0F) == 0x46 then
  language = "FRE"
  feebasSeedPointer = 0x02101F0C
  feebasSeedOff = 0x1262C
  locationOff = 0xE274
  posXAddr = 0x021C5EC6
  posYAddr = 0x021C5ECE
 elseif mbyte(0x02FFFE0F) == 0x53 then
  language = "SPA"
  feebasSeedPointer = 0x02101F2C
  feebasSeedOff = 0x1262C
  locationOff = 0xE274
  posXAddr = 0x021C5EE6
  posYAddr = 0x021C5EEE
 elseif mbyte(0x02FFFE0F) == 0x4B then
  language = "KOR"
  feebasSeedPointer = 0x02102C2C
  feebasSeedOff = 0x12658
  locationOff = 0xE274
  posXAddr = 0x021C6BCE
  posYAddr = 0x021C6BD6
 end
end

if game ~= "Diamond" and game ~= "Pearl" and game ~= "Platinum" then
 warning = " - Wrong game version! Use Diamon/Pearl/Platinum instead"
else
 warning = ""
end

print("Devon Studios x Real.96")
print()
print("Game Version: "..game..warning)
print("Language: "..language)

function getFeebasSeed()
 local feebasSeedAddr

 feebasSeedAddr = mdword(feebasSeedPointer) + feebasSeedOff

 return mdword(feebasSeedAddr)
end

function findFeebasTiles(seed)
 for i = 0, 3 do
  feebasTiles[i + 1] = (band(rshift(seed, (24 - (8 * i))), 0xFF) % 0x84) + (0x84 * i)
 end
end

function showFeebasTiles()
 gui.text(1, -180, "Tile 1: "..feebasTiles[1])
 gui.text(1, -170, "Tile 2: "..feebasTiles[2])
 gui.text(1, -160, "Tile 3: "..feebasTiles[3])
 gui.text(1, -150, "Tile 4: "..feebasTiles[4])
end

function getTileColor(tile, currTile)
 for i = 1, table.getn(feebasTiles) do
  if tile == feebasTiles[i] then
   if currTile == "" then
    return "green"
   else
    return "orange"
   end
  end
 end

 return "red"
end

function isMtCoronetFeebasRoom()
 return mword(mdword(feebasSeedPointer) + locationOff) == 0xDB
end

function showWaterTiles()
 local posX = mbyte(posXAddr)
 local posY = mbyte(posYAddr)

 if posY >= 17 and posY <= 51 then
  upTile = tiles[posY - 1][posX]
  downTile = tiles[posY + 1][posX]
  currTile = tiles[posY][posX]
  leftTile = tiles[posY][posX - 1]
  rightTile = tiles[posY][posX + 1]

  if upTile then
   gui.text(121, -120, string.format("%2d", upTile), getTileColor(upTile, ""))
  end

  if downTile then
   gui.text(121, -86, string.format("%2d", downTile), getTileColor(downTile, ""))
  end

  if currTile then
   gui.text(121, -102, string.format("%2d", currTile), getTileColor(currTile, "currTile"))
  end

  if leftTile then
   gui.text(100, -102, string.format("%2d", leftTile), getTileColor(leftTile, ""))
  end

  if rightTile then
   gui.text(142, -102, string.format("%2d", rightTile), getTileColor(rightTile, ""))
  end
 end
end

function main()
 currFeebasSeed = getFeebasSeed()

 findFeebasTiles(currFeebasSeed)
 showFeebasTiles()

 if isMtCoronetFeebasRoom() then
  showWaterTiles()
 end

 gui.text(1, -190, string.format("Feebas Seed: %08X", currFeebasSeed))
end

gui.register(main)