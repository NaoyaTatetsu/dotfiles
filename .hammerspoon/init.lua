-- HANDLE SCROLLING

local deferred = false

overrideRightMouseDown = hs.eventtap.new({ hs.eventtap.event.types.rightMouseDown }, function(e)
        --print("down"))
        deferred = true
        return true
end)

overrideRightMouseUp = hs.eventtap.new({ hs.eventtap.event.types.rightMouseUp }, function(e)
        -- print("up"))
        if deferred then
                overrideRightMouseDown:stop()
                overrideRightMouseUp:stop()
                hs.eventtap.rightClick(e:location())
                overrideRightMouseDown:start()
                overrideRightMouseUp:start()
                return true
        end

        return false
end)

local oldmousepos = {}
local scrollmult = -1 -- negative multiplier makes mouse work like traditional scrollwheel
dragRightToScroll = hs.eventtap.new({ hs.eventtap.event.types.rightMouseDragged }, function(e)
        -- print("scroll");

        deferred = false

        oldmousepos = hs.mouse.getAbsolutePosition()

        local dx = e:getProperty(hs.eventtap.event.properties["mouseEventDeltaX"])
        local dy = e:getProperty(hs.eventtap.event.properties["mouseEventDeltaY"])
        local scroll = hs.eventtap.event.newScrollEvent({ -dx * scrollmult, -dy * scrollmult }, {}, "pixel")

        -- put the mouse back
        hs.mouse.setAbsolutePosition(oldmousepos)

        return true, { scroll }
end)

overrideRightMouseDown:start()
overrideRightMouseUp:start()
dragRightToScroll:start()

-- Chrome 垂直タブの開閉トグル
hs.hotkey.bind({ "cmd" }, "B", function()
        local script = [[
    tell application "System Events"
      tell process "Google Chrome"
        set frontWin to first window whose value of attribute "AXMain" is true
        set base to group 1 of group 1 of group 1 of group 1 of frontWin
        click button 1 of group 1 of UI element 3 of base
      end tell
    end tell
  ]]
        local ok, result = hs.osascript.applescript(script)
        if not ok then
                hs.alert.show("垂直タブ切り替え失敗: " .. tostring(result))
        end
end)

-- init.lua の変更を検知して自動リロード
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", hs.reload):start()
hs.alert.show("Hammerspoon 設定をロードしました")
