function onScriptStart()
end

function onScriptUpdate()
 PressButton("D-Down")
 text = "Pressing Down"
 SetScreenText(text)
end

function onScriptCancel()
 SetScreenText("")
end

function onStateLoaded()
end

function onStateSaved()
end