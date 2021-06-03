mdword = memory.readdwordunsigned
mword = memory.readwordunsigned
mbyte = memory.readbyte
rshift = bit.rshift
lshift = bit.lshift
band = bit.band
bor = bit.bor

local gameLang = mbyte(0x080000AF)

if gameLang == 0x4A then -- J = 0x4A
else -- U/E
 saveBlockPointer = 0x03005D8C
 mirageBytePointer = 0x02039DF8
 currentBoxPID = 0x02003F7C
 boxSelectedSlot = 0x02003F71
 currentBox = 0x02003996
end

function next(s)
 local a = 0x41C6 * (s % 65536) + rshift(s, 16) * 0x4E6D
 local b = 0x4E6D * (s % 65536) + (a % 65536) * 65536 + 0x6073
 local c = b % 4294967296
 return c
end

function next(s, mul1, mul2, sum)
 local a = mul1 * (s % 65536) + rshift(s, 16) * mul2
 local b = mul2 * (s % 65536) + (a % 65536) * 65536 + sum
 local c = b % 4294967296
 return c
end

function getMirageIslandSeed()
 mirageHighSeed = mword(mdword(saveBlockPointer) + (2 * 0x4024) - 0x6C64)
 mirageLowSeed = mword(mdword(saveBlockPointer) + (2 * 0x4025) - 0x6C64)
 return bor(lshift(mirageHighSeed, 16), mirageLowSeed)
end

function hitMirageIslandSeed()
 pid = mdword(currentBoxPID)
 lowPID = band(pid, 0xFFFF)
 currMirageSeed = getMirageIslandSeed()
 days = 0

 while lowPID ~= rshift(currMirageSeed, 16) do
  currMirageSeed = next(currMirageSeed, 0x41C6, 0x4E6D, 0x3039)
  days = days + 1
 end

 return {days, currMirageSeed}
end

print("New Order of Breeding x Real.96")

while true do
 mirageSeed = getMirageIslandSeed()
 mirageValue = rshift(mirageSeed, 16)
 daysAndSeed = hitMirageIslandSeed()

 gui.text(0, 115, string.format("Mirage Island Value: %04X", mirageValue))
 gui.text(0, 125, string.format("Mirage Island Seed: %08X", mirageSeed))
 --gui.text(0, 135, string.format("Mirage Island Next Seed: %08X", next(mirageSeed, 0x41C6, 0x4E6D, 0x3039)))
 gui.text(0, 135, string.format("Selected Pokemon PID: %08X", mdword(currentBoxPID)))
 gui.text(0, 145, string.format("Days to advance for Mirage Island: %d (%08X)", daysAndSeed[1], daysAndSeed[2]))

 emu.frameadvance()
end