function next(s)
 local a = 0x3 * (s % 65536) + (s >> 16) * 0x43FD
 local b = 0x43FD * (s % 65536) + (a % 65536) * 65536 + 0x269EC3
 local c = b % 4294967296
 return c
end

function back(s)
 local a = 0xB9B3 * (s % 65536) + (s >> 16) * 0x3155
 local b = 0x3155 * (s % 65536) + (a % 65536) * 65536 + 0xA170F641
 local c = b % 4294967296
 return c
end

function claclFrameJump()
 calibrationFrame = 0
 if tempSeed ~= currSeed then
  tempSeed2 = tempSeed
  while tempSeed ~= currSeed and tempSeed2 ~= currSeed do
   tempSeed = next(tempSeed)
   tempSeed2 = back(tempSeed2)
   calibrationFrame = calibrationFrame + 1
  end

  if tempSeed2 == currSeed and tempSeed2 ~= tempSeed then
   calibrationFrame = (-1) * calibrationFrame
   tempSeed = tempSeed2
  end
 end
 return calibrationFrame
end

function onScriptStart()
 seedAddrs = 0x477098
 initSeed = 0
 currSeed = 0
 tempSeed = 0
 frame = 0
end

function onScriptUpdate()
 if ReadValue32(seedAddrs) > 0xFFFF and initSeed == 0 then
  initSeed = ReadValue32(seedAddrs)
  tempSeed = initSeed
  frame = 0
 end

 currSeed = ReadValue32(seedAddrs)
 frame = frame + claclFrameJump()

 text = string.format("Initial Seed: %08X\nCurrent Seed: %08X\nFrame: %d", initSeed, currSeed, frame)
 SetScreenText(text)
end

function onScriptCancel()
 SetScreenText("")
end

function onStateLoaded()

end

function onStateSaved()

end