#!/bin/shs

# debug log
set -e

# 管理者パスワードを前もって聞いておく
sudo -v

# キーのリピートを環境設定よりも早くする
defaults write -g InitialKeyRepeat -int 15
defaults write -g KeyRepeat -int 2
killall SystemUIServer

# Enable `Tap to click` （タップでクリックを有効にする）------------------------------------------------------------------------
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# 設定の反映
killall Dock