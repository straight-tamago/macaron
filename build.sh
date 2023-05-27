#/bin/sh

make clean
make package
make install

make clean
make package ROOTLESS=1
make install
