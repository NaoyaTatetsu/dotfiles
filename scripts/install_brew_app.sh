#! /bin/shs

# debug log
set -e

# 管理者パスワードを前もって聞いておく
sudo -v

brew install asdf
brew install k9s
brew install tree
brew install jq

brew install --cask clipy
brew install --cask docker
brew install --cask google-chrome
brew install --cask google-drive
brew install --cask google-japanese-ime
brew install --cask iterm2
brew install --cask karabiner-elements
brew install --cask meetingbar
brew install --cask microsoft-edge
brew install --cask mongodb-compass
brew install --cask notion
brew install --cask rectangle
brew install --cask slack
brew install --cask visual-studio-code
brew install --cask zoom