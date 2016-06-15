#!/bin/bash

# Download pdf2png, extract it and add 'pdf2img' to path
mkdir $HOME/bin
cd $HOME/bin
wget https://github.com/wifiextender/pdf2png/archive/master.zip -O pdf2png.zip
unzip pdf2png.zip
cd pdf2png
chmod +x pdf2img.py
echo "export PATH="$PATH:$HOME/bin/pdf2png"" >> $HOME/.bashrc

# Install dependencies
sudo zypper --non-interactive python-qt4-utils ghostscript
