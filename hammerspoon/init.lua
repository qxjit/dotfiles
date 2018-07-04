hs.hotkey.bind({"cmd", "alt", "ctrl"}, "d", function()
  switchLayoutToDvorak()
  hs.alert.show(hs.keycodes.currentLayout())
end)

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "u", function()
  switchLayoutToUS()
  hs.alert.show(hs.keycodes.currentLayout())
end)

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
