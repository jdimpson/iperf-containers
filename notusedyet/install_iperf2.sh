#!/bin/sh
if test -z "$VERSION"; then
	version=2.2.0
else
	version="$VERSION";
fi
direct="iperf-$version"
archive="$direct.tar.gz"
echo installing iperf $version
cd $HOME
# Download
wget "https://sourceforge.net/projects/iperf2/files/iperf-$version.tar.gz/download" -O "$archive" || exit 1
tar -zxvf "$archive" || exit 2
rm "$archive"
cd "$direct"
# Install
./configure --prefix=$HOME/iperf2 || exit 3
make || exit 4
make install || exit 5
cd ..
rm -r "$direct"
#majMin="${version%.*}"
if test -d "$HOME/bin"; then
	echo "linking $HOME/iperf2/bin/iperf into $HOME/bin"
	ln -s $HOME/iperf2/bin/iperf $HOME/bin
fi
