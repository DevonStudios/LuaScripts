mdword = memory.readdwordunsigned
mword = memory.readwordunsigned
mbyte = memory.readbyte
rshift = bit.rshift

local gameVersion = mbyte(0x080000AE)
local game
local gameLang = mbyte(0x080000AF)
local language = ""
local warning

local feebasTiles = {0, 0, 0, 0, 0, 0}
local tiles = {
 [24] = {},
 [25] = {[25] = 4},
 [26] = {[25] = 5, [26] = 6},
 [27] = {[23] = 7, [24] = 8, [25] = 9, [26] = 10},
 [28] = {[24] = 11, [25] = 12, [26] = 13},
 [29] = {[24] = 14, [25] = 15, [26] = 16},
 [30] = {[24] = 17, [25] = 18, [26] = 19},
 [31] = {[24] = 20, [25] = 21, [26] = 22},
 [32] = {},
 [33] = {},
 [34] = {},
 [35] = {},
 [36] = {[24] = 23, [25] = 24, [26] = 25},
 [37] = {[24] = 26, [25] = 27, [26] = 28},
 [38] = {[23] = 29, [24] = 30, [25] = 31, [26] = 32, [27] = 33},
 [39] = {[23] = 34, [24] = 35, [25] = 36, [26] = 37, [27] = 38},
 [40] = {},
 [41] = {},
 [42] = {[23] = 39, [24] = 40, [25] = 41, [26] = 42, [27] = 43},
 [43] = {[23] = 44, [24] = 45, [25] = 46, [26] = 47, [27] = 48},
 [44] = {[23] = 49, [24] = 50, [25] = 51, [26] = 52, [27] = 53},
 [45] = {[23] = 54, [24] = 55, [25] = 56, [26] = 57, [27] = 58, [28] = 59, [29] = 60},
 [46] = {[23] = 61, [24] = 62, [25] = 63, [26] = 64, [27] = 65, [28] = 66, [29] = 67},
 [47] = {[23] = 68, [24] = 69, [25] = 70, [26] = 71, [27] = 72, [28] = 73, [29] = 74},
 [48] = {[23] = 75, [24] = 76, [25] = 77, [26] = 78, [27] = 79, [28] = 80, [29] = 81},
 [49] = {[23] = 82, [24] = 83, [25] = 84, [26] = 85, [27] = 86, [28] = 87, [29] = 88, [30] = 89},
 [50] = {[23] = 90, [24] = 91, [25] = 92, [26] = 93, [27] = 94, [28] = 95, [29] = 96, [30] = 97, [31] = 98, [32] = 99, [33] = 100, [34] = 101, [35] = 102, [36] = 103, [37] = 104},
 [51] = {[26] = 105, [27] = 106, [28] = 107, [29] = 108, [30] = 109, [31] = 110, [32] = 111, [33] = 112, [34] = 113, [35] = 114, [36] = 115, [37] = 116, [38] = 117, [39] = 118},
 [52] = {[27] = 119, [28] = 120, [29] = 121, [30] = 122, [31] = 123, [32] = 124, [33] = 125, [34] = 126, [35] = 127, [36] = 128, [37] = 129, [38] = 130, [39] = 131},
 [53] = {[30] = 132, [31] = 133, [32] = 134, [33] = 135, [34] = 136, [35] = 137, [36] = 138, [37] = 139, [38] = 140, [39] = 141, [40] = 142, [41] = 143},
 [54] = {[34] = 144, [35] = 145, [36] = 146, [37] = 147, [38] = 148, [39] = 149, [40] = 150, [41] = 151},
 [55] = {[37] = 152, [38] = 153, [39] = 154, [40] = 155, [41] = 156},
 [56] = {[38] = 157, [39] = 158, [40] = 159, [41] = 160, [42] = 161},
 [57] = {[38] = 162, [39] = 163, [40] = 164},
 [58] = {[38] = 165, [39] = 166, [40] = 167},
 [59] = {[38] = 168, [39] = 169, [40] = 170, [41] = 171, [42] = 172},
 [60] = {[38] = 173, [39] = 174, [40] = 175, [41] = 176, [42] = 177},
 [61] = {[40] = 178, [41] = 179, [42] = 180},
 [62] = {[40] = 181, [41] = 182, [42] = 183},
 [63] = {[38] = 184, [39] = 185, [40] = 186, [41] = 187, [42] = 188},
 [64] = {[38] = 189, [39] = 190, [40] = 191, [41] = 192, [42] = 193},
 [65] = {[37] = 194, [38] = 195, [39] = 196, [40] = 197, [41] = 198, [42] = 199},
 [66] = {[34] = 200, [35] = 201, [36] = 202, [37] = 203, [38] = 204, [39] = 205, [40] = 206, [41] = 207},
 [67] = {[33] = 208, [34] = 209, [35] = 210, [36] = 211, [37] = 212, [38] = 213, [39] = 214, [40] = 215},
 [68] = {[33] = 216, [34] = 217, [35] = 218, [36] = 219, [37] = 220, [38] = 221},
 [69] = {[33] = 222, [34] = 223, [35] = 224, [36] = 225, [37] = 226, [38] = 227},
 [70] = {[33] = 228, [34] = 229, [35] = 230, [36] = 231, [37] = 232, [38] = 233, [39] = 234},
 [71] = {[31] = 235, [32] = 236, [33] = 237, [34] = 238, [35] = 239, [36] = 240},
 [72] = {[31] = 241, [32] = 242, [33] = 243, [34] = 244, [35] = 245},
 [73] = {[29] = 246, [30] = 247, [31] = 248, [32] = 249, [33] = 250, [34] = 251, [35] = 252},
 [74] = {[29] = 253, [30] = 254, [31] = 255, [32] = 256, [33] = 257, [34] = 258, [35] = 259},
 [75] = {[29] = 260, [30] = 261, [31] = 262, [32] = 263, [33] = 264},
 [76] = {[27] = 265, [28] = 266, [29] = 267, [30] = 268, [31] = 269, [32] = 270, [33] = 271},
 [77] = {[27] = 272, [28] = 273, [29] = 274, [30] = 275, [31] = 276, [32] = 277},
 [78] = {[27] = 278, [28] = 279, [29] = 280, [30] = 281, [31] = 282, [32] = 283},
 [79] = {[27] = 284, [28] = 285, [29] = 286, [30] = 287, [31] = 288, [32] = 289},
 [80] = {[27] = 290, [28] = 291, [29] = 292, [30] = 293},
 [81] = {[28] = 294},
 [82] = {[28] = 295},
 [83] = {},
 [84] = {},
 [85] = {},
 [86] = {},
 [87] = {},
 [88] = {},
 [89] = {},
 [90] = {},
 [91] = {},
 [92] = {},
 [93] = {},
 [94] = {},
 [95] = {},
 [96] = {},
 [97] = {},
 [98] = {},
 [99] = {},
 [100] = {},
 [101] = {},
 [102] = {},
 [103] = {},
 [104] = {},
 [105] = {[21] = 299},
 [106] = {[21] = 300},
 [107] = {[21] = 301, [22] = 302, [23] = 303, [26] = 304, [27] = 305, [30] = 306, [31] = 307},
 [108] = {[21] = 308, [22] = 309, [23] = 310, [24] = 311, [25] = 312, [26] = 313, [27] = 314, [28] = 315, [29] = 316, [30] = 317, [31] = 318},
 [109] = {[21] = 319, [22] = 320, [23] = 321, [24] = 322, [25] = 323, [26] = 324, [27] = 325, [28] = 326, [29] = 327, [30] = 328, [31] = 329},
 [110] = {[21] = 330, [22] = 331, [23] = 332, [24] = 333, [25] = 334, [26] = 335, [27] = 336, [28] = 337, [29] = 338, [30] = 339, [31] = 340},
 [111] = {[21] = 341, [22] = 342, [23] = 343, [24] = 344, [25] = 345, [26] = 346, [27] = 347, [28] = 348, [29] = 349, [30] = 350, [31] = 351, [32] = 352},
 [112] = {[21] = 353, [22] = 354, [23] = 355, [24] = 356, [25] = 357, [26] = 358, [27] = 359, [28] = 360, [29] = 361, [30] = 362, [31] = 363, [32] = 364},
 [113] = {[16] = 365, [17] = 366, [18] = 367, [19] = 368, [20] = 369, [21] = 370, [22] = 371, [23] = 372, [24] = 373, [25] = 374, [26] = 375, [27] = 376, [30] = 377, [31] = 378, [32] = 379},
 [114] = {[14] = 380, [15] = 381, [16] = 382, [17] = 383, [18] = 384, [19] = 385, [20] = 386, [21] = 387, [22] = 388, [23] = 389, [24] = 390, [25] = 391, [26] = 392, [27] = 393, [30] = 394, [31] = 395, [32] = 396},
 [115] = {[16] = 397, [17] = 398, [18] = 399, [19] = 400, [20] = 401, [21] = 402, [22] = 403, [23] = 404, [24] = 405, [25] = 406, [26] = 407, [27] = 408, [28] = 409, [29] = 410, [30] = 411, [31] = 412, [32] = 413},
 [116] = {[16] = 414, [17] = 415, [18] = 416, [19] = 417, [20] = 418, [21] = 419, [22] = 420, [23] = 421, [24] = 422, [25] = 423, [26] = 424, [27] = 425, [28] = 426, [29] = 427, [30] = 428},
 [117] = {[15] = 429, [16] = 430, [17] = 431, [18] = 432, [19] = 433, [20] = 434, [21] = 435, [22] = 436, [23] = 437, [24] = 438, [25] = 439, [26] = 440},
 [118] = {[15] = 441, [16] = 442, [17] = 443, [18] = 444, [19] = 445},
 [119] = {[14] = 446, [15] = 447},
 [120] = {}
}

local saveBlockPointer
local currMapAddr
local posXAddr
local posYAddr

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
 if gameLang == 0x4A then  -- Check game language
  language = "JPN"
  saveBlockPointer = 0x02025494
  currMapAddr = 0x02029A84
  posXAddr = 0x030047E4
  posYAddr = 0x030047E2
 elseif gameLang == 0x45 then
  language = "USA"
  saveBlockPointer = 0x02025734
  currMapAddr = 0x02029D24
  posXAddr = 0x030048B4
  posYAddr = 0x030048B2
 else
  language = "EUR"
  saveBlockPointer = 0x02025734
  currMapAddr = 0x02029D24
  posXAddr = 0x030048C4
  posYAddr = 0x030048C2
 end
elseif game == "Emerald" then
 if gameLang == 0x4A then
  language = "JPN"
  saveBlockPointer = 0x03005AEC
  currMapAddr = 0x020324B4
  posXAddr = 0x02037004
  posYAddr = 0x02037002
 else
  language = "USA/EUR"
  saveBlockPointer = 0x03005D8C
  currMapAddr = 0x02032814
  posXAddr = 0x02037360
  posYAddr = 0x02037362
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

function LCRNG(s, mul1, mul2, sum)
 local a = mul1 * (s % 65536) + rshift(s, 16) * mul2
 local b = mul2 * (s % 65536) + (a % 65536) * 65536 + sum
 local c = b % 4294967296

 return c
end

function getFeebasSeed()
 local feebasSeed

 if game == "Emerald" then
  feebasSeed = mdword(saveBlockPointer) + 0x2E6A
 else
  feebasSeed = saveBlockPointer + 0x2DD6
 end

 return mword(feebasSeed)
end

function findFeebasTiles(seed)
 local i = 1

 while i <= 6 do
  seed = LCRNG(seed, 0x41C6, 0x4E6D, 0x3039)
  feebasTiles[i] = (rshift(seed, 16)) % 0x1BF

  if feebasTiles[i] == 0 then
   feebasTiles[i] = 447
  end

  if feebasTiles[i] < 1 or feebasTiles[i] >= 4 then
   i = i + 1
  end
 end

 table.sort(feebasTiles)
end

function showFeebasTiles()
 gui.text(1, 11, "Tile 1: "..feebasTiles[1])
 gui.text(1, 21, "Tile 2: "..feebasTiles[2])
 gui.text(1, 31, "Tile 3: "..feebasTiles[3])
 gui.text(1, 41, "Tile 4: "..feebasTiles[4])
 gui.text(1, 51, "Tile 5: "..feebasTiles[5])
 gui.text(1, 61, "Tile 6: "..feebasTiles[6])
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

function isRoute119()
 return mbyte(currMapAddr) == 0x16
end

function showWaterTiles()
 local posX = mbyte(posXAddr)
 local posY = mbyte(posYAddr)

 if posY >= 25 and posY <= 119 then
  upTile = tiles[posY - 1][posX]
  downTile = tiles[posY + 1][posX]
  currTile = tiles[posY][posX]
  leftTile = tiles[posY][posX - 1]
  rightTile = tiles[posY][posX + 1]

  if upTile then
   gui.text(117, 57, upTile, getTileColor(upTile, ""))
  end

  if downTile then
   gui.text(117, 95, downTile, getTileColor(downTile, ""))
  end

  if currTile then
   gui.text(117, 77, currTile, getTileColor(currTile, "currTile"))
  end

  if leftTile then
   gui.text(101, 77, leftTile, getTileColor(leftTile, ""))
  end

  if rightTile then
   gui.text(133, 77, rightTile, getTileColor(rightTile, ""))
  end
 end
end

while warning == "" do
 currFeebasSeed = getFeebasSeed()

 findFeebasTiles(currFeebasSeed)
 showFeebasTiles()

 if isRoute119() then
  showWaterTiles()
 end

 gui.text(1, 1, string.format("Feebas Seed: %04X", currFeebasSeed))

 emu.frameadvance()
end