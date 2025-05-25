#!/bin/shs

# debug log
set -e

# 管理者パスワードを前もって聞いておく
sudo -v
# 表示件数を8x10にする
defaults write com.apple.dock springboard-rows -int 8
defaults write com.apple.dock springboard-columns -int 10
# 並び順を整える
sudo find 2>/dev/null /private/var/folders/ -type d -name com.apple.dock.launchpad -exec rm -rf {} +

# 設定の反映
killall Dock
