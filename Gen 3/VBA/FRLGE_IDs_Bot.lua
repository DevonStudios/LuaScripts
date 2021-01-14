local tid
local state = savestate.create()
local seedWritten = false
local notFound = true
local targetTID = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}

function writeCheck()
	seedWritten = true
end

function isNotFound()
	for i = 1, table.getn(targetTID) do
		if tid == targetTID[i] then
			return false
		end
	end
	return true
end

memory.registerwrite(0x2020000, writeCheck)

print("Searching...")

while notFound do
	savestate.save(state)
	joypad.set(1, {A=true})
	i = 0
	while seedWritten == false and i < 36 do
		emu.frameadvance()
		i = i + 1
	end
	if seedWritten then
		tid = memory.readword(0x2020000)
		notFound = isNotFound()
	end
	if notFound then
		seedWritten = false
		savestate.load(state)
		emu.frameadvance()
	end
end

print()
print("Found!")
print(string.format("TID: %05d", tid))
emu.pause()