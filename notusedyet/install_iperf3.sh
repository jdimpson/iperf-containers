#!/bin/sh
if test -z "$VERSION"; then
	version=3.16
else
	version="$VERSION";
fi
direct="iperf-$version"
echo installing iperf3 $version
cd $HOME
# Download
git clone --single-branch  https://github.com/esnet/iperf $direct || exit 1
cd "$direct"
git checkout $version || exit 2
# Install
./configure --prefix=$HOME/iperf3 || exit 3
make || exit 4
make install || exit 5
cd ..
rm -rf "$direct"
if test -d "$HOME/bin"; then
	echo "linking $HOME/iperf3/bin/iperf3 into $HOME/bin"
	ln -s $HOME/iperf3/bin/iperf3 $HOME/bin
fi
