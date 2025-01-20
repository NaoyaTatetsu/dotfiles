#!/bin/shs

# debug log
set -e

# 管理者パスワードを前もって聞いておく
sudo -v
# 表示件数を8x10にする
defaults write com.apple.dock springboard-rows -int 8
defaults write com.apple.dock springboard-columns -int 10
# Reset LaunchPad (but not regular)
defaults write com.apple.dock ResetLaunchPad -bool true

# 設定の反映
killall Dock
