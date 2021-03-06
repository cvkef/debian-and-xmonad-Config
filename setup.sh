#!/bin/bash

cd

echo "Installing Software .."
echo "deb http://cdn.debian.net/debian unstable main" | sudo tee -a /etc/apt/sources.list
sudo apt-get update
sudo apt-get install $(< apps)
# install iceweasel from sid
sudo apt-get install -t unstable iceweasel

echo "Setting zsh as default shell .."
chsh -s `which zsh`

echo "Setting urxvt as default terminal emulator .."
sudo update-alternatives --set x-terminal-emulator /usr/bin/urxvt

echo "Getting patched font for Powerline .."
wget https://github.com/Lokaltog/powerline-fonts/raw/master/Inconsolata/Inconsolata%20for%20Powerline.otf
sudo mv "Inconsolata for Powerline.otf" /usr/share/fonts
sudo fc-cache -vf

echo "Pimping Vim .."
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

echo "Oh my zsh!"
curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
mkdir -p ~/.oh-my-zsh/custom/plugins
git clone git://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

echo "Installing basics for Haskell Dev .."
cabal update && cabal install hoogle && cabal install pointfree && cabal install hlint && cabal install hdevtools

echo "Applying personal configs .."
git clone git://github.com/jetho/debian-and-xmonad-Config.git ~/setup_tmp
rsync -avh ~/setup_tmp/dotfiles/ ~
sudo chmod u+x ~/.xmonad/bin/*.sh
cd && sh .fehbg 
rm -R ~/setup_tmp

echo "Installing Vim Plugins .."
vim +BundleInstall +qall

echo "Setup finished! Please reboot!"
