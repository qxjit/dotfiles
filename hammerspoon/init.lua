hotkeys = hs.hotkey.modal.new({"cmd"}, "h", "Hotkeys")

-- Disable animations for window movements
hs.window.animationDuration = 0

hotkeys:bind({"cmd"}, "h", "Exit HotKeys", function()
  hotkeys:exit()
end)

hotkeys:bind({}, "d", function()
  switchLayoutToDvorak()
  hs.alert.show(hs.keycodes.currentLayout())
  hotkeys:exit()
end)

hotkeys:bind({}, "u", function()
  switchLayoutToUS()
  hs.alert.show(hs.keycodes.currentLayout())
  hotkeys:exit()
end)

hotkeys:bind({}, "f", function()
  local win = hs.window.focusedWindow()
  win:toggleFullScreen()
  hotkeys:exit()
end)

hotkeys:bind({}, "m", function()
  local currScreen = hs.mouse.getCurrentScreen()
  moveMouseTo(currScreen:next())
  hotkeys:exit()
end)

hotkeys:bind("shift", "m", function()
  local currScreen = hs.mouse.getCurrentScreen()
  moveMouseTo(currScreen:previous())
  hotkeys:exit()
end)

function moveMouseTo(screen)
  local pos = hs.mouse.getRelativePosition()
  hs.mouse.setRelativePosition(pos, screen)
end

function switchLayoutToDvorak()
  hs.keycodes.setLayout("Dvorak")
  setKotoeriLayout("Dvorak")
end

function switchLayoutToUS()
  hs.keycodes.setLayout("U.S.")
  setKotoeriLayout("US")
end

function setKotoeriLayout(layout)
  hs.execute("defaults write com.apple.inputmethod.Kotoeri JIMPrefRomajiKeyboardLayoutKey com.apple.keylayout." .. layout)
end

function usbCallback(data)
  if (data["productName"] == "Model 01") then
    if (data["eventType"] == "added") then
      switchLayoutToUS()
    elseif (data["eventType"] == "removed") then
      switchLayoutToDvorak()
    end
  end
end

usbWatcher = hs.usb.watcher.new(usbCallback)
usbWatcher:start()
