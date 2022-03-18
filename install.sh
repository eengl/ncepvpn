#!/usr/bin/env bash
#
# Installer script for ncepvpn package.
#
# ---------------------------------------------------------------------------------------- 
#set -x

# ---------------------------------------------------------------------------------------- 
# Set PREFIX if not already defined
# ---------------------------------------------------------------------------------------- 
PREFIX=${PREFIX:-/usr/local}

# ---------------------------------------------------------------------------------------- 
# Install must be performed as root
# ---------------------------------------------------------------------------------------- 
if [ $UID -ne 0 ]; then exit 1; fi

# ---------------------------------------------------------------------------------------- 
# Destroy then create build directory to work in
# ---------------------------------------------------------------------------------------- 
if [ -d build/ ]; then rm -rf build/; fi
mkdir build

# ---------------------------------------------------------------------------------------- 
# Create sudoers rules
# ---------------------------------------------------------------------------------------- 
cat << EOF >> build/ncepvpn
# Allow all users to ncepvpn script as sudo
ALL ALL=(ALL) NOPASSWD: $PREFIX/bin/ncepvpn
EOF

# ---------------------------------------------------------------------------------------- 
# Check syntax of sudoers rules file and install rules to /etc/sudoers.d/
# ---------------------------------------------------------------------------------------- 
visudo -c -f build/ncepvpn
if [ $? -ne 0 ]; then exit 1; fi
/usr/bin/install -v -m 440 build/ncepvpn /etc/sudoers.d/ncepvpn

# ---------------------------------------------------------------------------------------- 
# Install ncepvpn
# ---------------------------------------------------------------------------------------- 
if [ ! -d $PREFIX/bin ]; then
   mkdir -p $PREFIX/bin
   chmod -R 775 $PREFIX/bin
fi
/usr/bin/install -v -m 755 src/ncepvpn $PREFIX/bin/ncepvpn

# ---------------------------------------------------------------------------------------- 
# Cleanup
# ---------------------------------------------------------------------------------------- 
rm -rf build/
