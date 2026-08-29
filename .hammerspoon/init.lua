require("hs.ipc")

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

-- Chrome 垂直タブ（サイドバー）の展開/折りたたみトグル
--
-- 垂直タブバーは Chrome ウィンドウ内の AXTabGroup。
-- ただしタブグループ（「4D CMS」など）も AXTabGroup なので、
-- 「AXSlider（サイズ変更ハンドル）を子に持つ」ことで垂直タブバー本体を判別する。
-- 展開/折りたたみボタンはその先頭 AXGroup の先頭 AXButton
-- （desc が「タブを開く」⇄「タブを閉じる」で切り替わる同一ボタン）。
--
-- 旧実装は "UI element 3 of group 1 of ... of window" とインデックス直打ちだったため、
-- 情報バーの表示有無などで位置がずれて壊れた。以下は構造で辿るので影響を受けない。

local axuielement = require("hs.axuielement")

local PRUNE_ROLES = { AXWebArea = true, AXScrollArea = true, AXMenuBar = true }

local function isVerticalTabStrip(el)
	if el:attributeValue("AXRole") ~= "AXTabGroup" then
		return false
	end
	for _, child in ipairs(el:attributeValue("AXChildren") or {}) do
		if child:attributeValue("AXRole") == "AXSlider" then
			return true
		end
	end
	return false
end

local function findVerticalTabStrip(el, depth)
	if depth > 6 then
		return nil
	end
	local children = el:attributeValue("AXChildren") or {}
	for _, child in ipairs(children) do
		if isVerticalTabStrip(child) then
			return child
		end
	end
	for _, child in ipairs(children) do
		if not PRUNE_ROLES[child:attributeValue("AXRole")] then
			local found = findVerticalTabStrip(child, depth + 1)
			if found then
				return found
			end
		end
	end
	return nil
end

local function findToggleButton(strip)
	for _, child in ipairs(strip:attributeValue("AXChildren") or {}) do
		if child:attributeValue("AXRole") == "AXGroup" then
			for _, grandchild in ipairs(child:attributeValue("AXChildren") or {}) do
				if grandchild:attributeValue("AXRole") == "AXButton" then
					return grandchild
				end
			end
		end
	end
	return nil
end

local function toggleVerticalTabs()
	local app = hs.application.get("Google Chrome")
	if not app then
		hs.alert.show("Chrome が見つかりません")
		return
	end

	local axApp = axuielement.applicationElement(app)
	local win = axApp and axApp:attributeValue("AXFocusedWindow")
	if not win then
		hs.alert.show("Chrome のウィンドウが見つかりません")
		return
	end

	local strip = findVerticalTabStrip(win, 0)
	if not strip then
		hs.alert.show("垂直タブバーが見つかりません（「表示 > タブを縦方向に表示」が有効か確認）")
		return
	end

	local button = findToggleButton(strip)
	if not button then
		hs.alert.show("垂直タブの開閉ボタンが見つかりません")
		return
	end

	button:performAction("AXPress")
end

chromeVerticalTabsHotkey = hs.hotkey.new({ "ctrl" }, "D", toggleVerticalTabs)

-- Chrome がアクティブなときだけ ctrl+D を奪う（他アプリでは EOF などが通る）
local function syncChromeHotkey(appName)
	if appName == "Google Chrome" then
		chromeVerticalTabsHotkey:enable()
	else
		chromeVerticalTabsHotkey:disable()
	end
end

chromeAppWatcher = hs.application.watcher.new(function(name, event, _)
	if event == hs.application.watcher.activated then
		syncChromeHotkey(name)
	end
end)
chromeAppWatcher:start()

local frontApp = hs.application.frontmostApplication()
syncChromeHotkey(frontApp and frontApp:name())

-- init.lua の変更を検知して自動リロード
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", hs.reload):start()
hs.alert.show("Hammerspoon 設定をロードしました")
