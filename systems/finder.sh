#!/bin/shs

# debug log
set -e

# 管理者パスワードを前もって聞いておく
sudo -v

# 新しいウィンドウはデフォルトでホームディレクトリを開く
defaults write com.apple.finder NewWindowTarget -string "PfDe"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"
# ステータスバーの表示
defaults write com.apple.finder ShowStatusBar -bool true
# タブバーを表示
defaults write com.apple.finder ShowTabView -bool true
# パスバーの表示
defaults write com.apple.finder ShowPathbar -bool true
# Finderの表示をカラムビューにする。「Nlsv」(リストビュー)「icnv」(アイコンビュー)、「clmv」(カラムビュー)、「Flwv」(カバーフロービュー)から選択
defaults write com.apple.Finder FXPreferredViewStyle clmv

# 設定の反映
killall Finder