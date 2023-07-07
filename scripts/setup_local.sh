#! /bin/shs

# debug log
set -e

# brew
if !  (type "brew" > /dev/null 2>&1); then
  echo "Install brew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo "Completed installing brew."
else
    echo "brew is already installed"
fi