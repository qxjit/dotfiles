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

hotkeys:bind({}, "Left", function()
  local win = hs.window.focusedWindow()
  savingAndRestoringFullscreen(win, function()
    win:moveOneScreenWest()
  end)
  hotkeys:exit()
end)

hotkeys:bind({}, "Right", function()
  local win = hs.window.focusedWindow()
  savingAndRestoringFullscreen(win, function()
    win:moveOneScreenEast()
  end)
  hotkeys:exit()
end)

function savingAndRestoringFullscreen(win, fn)
  local wasFullscreen = win:isFullScreen()

  if (wasFullscreen) then
    win:setFullScreen(false)
  end

  fn()

  if (wasFullscreen) then
    hs.timer.doAfter(0.6, function()
      win:setFullScreen(true)
    end)
  end
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
