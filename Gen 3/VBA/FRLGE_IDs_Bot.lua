local tid
local state = savestate.create()
local seedWritten = false
local found = false
local targetTID = {11111, 22222, 33333, 44444, 55555, 66666, 77777, 88888, 99999}  -- Input here the target TIDs

function writeCheck()
 seedWritten = true
end

function isFound()
 for i = 1, table.getn(targetTID) do
  if tid == targetTID[i] then
   return true
  end
 end
 return false
end

memory.registerwrite(0x02020000, writeCheck)

print("Searching...")

while not found do
 savestate.save(state)
 joypad.set(1, {A=true})
 i = 0
 while seedWritten == false and i < 36 do
  emu.frameadvance()
  i = i + 1
 end
 if seedWritten then
  tid = memory.readword(0x02020000)
  found = isFound()
 end
 if not found then
  seedWritten = false
  savestate.load(state)
  emu.frameadvance()
 end
end

print()
print("Found!")
print(string.format("TID: %05d", tid))

emu.pause()