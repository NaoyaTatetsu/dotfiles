#!/bin/shs

# debug log
set -e

# 管理者パスワードを前もって聞いておく
sudo -v

# Dock---------------------------------------------------------------------------------------------------------
# Dockのサイズを30にする
defaults write com.apple.dock tilesize -int 30
# Dock拡大
defaults write com.apple.dock magnification -bool true
defaults write com.apple.dock largesize -int 80
# 起動中のアプリケーションをアニメションで表示（チェックボックスオン）
defaults delete com.apple.dock launchanim
# 最近使ったアプリケーションをDockに表示
defaults write com.apple.dock show-recents -bool false

# Finder--------------------------------------------------------------------------------------------------------
# Finder sidebar
mysides add ${HOME} file://${HOME}/
mysides remove Applications
mysides remove Desktop
mysides remove Documents
mysides remove Downloads
# Delete tags in sidebar
defaults write com.apple.finder ShowRecentTags -bool false
# 新しいウィンドウはデフォルトでホームディレクトリを開く
defaults write com.apple.finder NewWindowTarget -string "PfDe"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"
# Finderタイトルをフルパスに変更
defaults write com.apple.finder _FXShowPosixPathInTitle -boolean true
# ステータスバーの表示
defaults write com.apple.finder ShowStatusBar -bool true
# タブバーを表示
defaults write com.apple.finder ShowTabView -bool true
# パスバーの表示
defaults write com.apple.finder ShowPathbar -bool true
# Finderの表示をカラムビューにする。「Nlsv」(リストビュー)「icnv」(アイコンビュー)、「clmv」(カラムビュー)、「Flwv」(カバーフロービュー)から選択
defaults write com.apple.Finder FXPreferredViewStyle clmv
# 名前で並べ替えを選択時にディレクトリを前に置くようにする
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Keyboard--------------------------------------------------------------------------------------------------------
# キーのリピートを環境設定よりも早くする
defaults write -g InitialKeyRepeat -int 15
defaults write -g KeyRepeat -int 2
killall SystemUIServer

# Enable `Tap to click` （タップでクリックを有効にする）------------------------------------------------------------------------
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1


# その他--------------------------------------------------------------------------------------------------------
# 時計アイコンクリック時に OS やホスト名 IP を表示する
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName
# System Appearance
defaults write NSGlobalDomain "AppleInterfaceStyle" -string "Dark"
# バッテリー残量のパーセンテージ表示
defaults write com.apple.menuextra.battery ShowPercent -string "YES"

# Launchpad--------------------------------------------------------------------------------------------------------
# 表示件数を8x10にする
defaults write com.apple.dock springboard-rows -int 8
defaults write com.apple.dock springboard-columns -int 10
# Reset LaunchPad (but not regular)
defaults write com.apple.dock ResetLaunchPad -bool true

# 設定の反映---------------------------------------------------------------------------------------------------------
killall Dock
killall Finder
killall SystemUIServer

# End & Reboot---------------------------------------------------------------------------------------------------
sudo shutdown -r now