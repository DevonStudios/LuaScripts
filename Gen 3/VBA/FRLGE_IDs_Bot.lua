local tid
local state = savestate.create()
local seedWritten = false
local notFound = true
local targetTID = {}

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

while true do
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
			print(tid)
			notFound = isNotFound()
		end
		if notFound then
			seedWritten = false
			savestate.load(state)
			emu.frameadvance()
		else
			break
		end
	end
	emu.pause()
	break
end