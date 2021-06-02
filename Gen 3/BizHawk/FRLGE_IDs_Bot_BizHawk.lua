mword = memory.read_u16_le

local tid
local seedWritten = false
local found = false
local prevSeed = mword(0x02020000)
local targetTID = {11111, 22222, 33333, 44444, 55555, 66666, 77777, 88888, 99999}  -- Input here the target TIDs

function isFound()
 for i = 1, table.getn(targetTID) do
  if tid == targetTID[i] then
   return true
  end
 end
 return false
end

console.clear()
print("Searching...")

while not found do
 initSeed = mword(0x02020000)
 savestate.saveslot(3)
 joypad.set({A = true})
 i = 0
 while initSeed == prevSeed and i < 36 do
  emu.frameadvance()
  initSeed = mword(0x02020000)
  i = i + 1
 end
 if initSeed ~= prevSeed then
  tid = mword(0x02020000)
  found = isFound()
 end
 if not found then
  seedWritten = false
  savestate.loadslot(3)
  emu.frameadvance()
 end
end

print("")
print("Found!")
print(string.format("TID: %05d", tid))

client.pause()