#!/bin/bash
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
# Get the Linux OS Distro.
# ---------------------------------------------------------------------------------------- 
which lsb_release 1> /dev/null 2>&1
if [ $? -eq 0 ]; then
   OSTYPE=$(lsb_release -a | grep "Distributor ID" | cut -d: -f 2 | tr -s '\t' ' ' | sed 's/ //g')
   OSVERSION=$(lsb_release -a | grep "Release" | cut -d: -f 2 | tr -s '\t' ' ' | sed 's/ //g' | cut -d"." -f1)
fi

if [ "$OSTYPE" == "CentOS" ] || [ "$OSTYPE" == "Fedora" ] || [ "$OSTYPE" == "RedHatEnterpriseServer" ]; then
   OSFAMILY="redhat"
   if [ $OSVERSION -eq 5 ]; then PATH=$PATH:/usr/sbin; fi
elif [ "$OSTYPE" == "Ubuntu" ] || [ "$OSTYPE" == "LinuxMint" ]; then
   OSFAMILY="debian"
fi

echo -e "\n\tOS Detected: $OSTYPE, $OSVERSION, $OSFAMILY\n"

# ---------------------------------------------------------------------------------------- 
# Install appropriate software packages.
# ---------------------------------------------------------------------------------------- 
if [ "$OSFAMILY" == "debian" ]; then
   apt-get install openconnect uml-utilities
elif [ "$OSFAMILY" == "redhat" ]; then
   which dnf 1> /dev/null 2>&1
   if [ $? -eq 0 ]; then
      # Use DNF
      dnf -y install openconnect vpnc
   else
      yum -y install epel-release
      yum -y install openconnect vpnc
   fi
fi

# ---------------------------------------------------------------------------------------- 
# Create sudoers rules
# ---------------------------------------------------------------------------------------- 
cat << EOF >> build/openconnect
# Allow all users to run openconnect and ncepvpn script as sudo
ALL ALL=(ALL) NOPASSWD: /usr/sbin/openconnect
ALL ALL=(ALL) NOPASSWD: $PREFIX/bin/ncepvpn
EOF

# ---------------------------------------------------------------------------------------- 
# Install openconnect rules to sudoers
# ---------------------------------------------------------------------------------------- 
if [ "$OSFAMILY" == "redhat" ] && [ $OSVERSION -eq 5 ]; then
   # System in Red Hat/CentOS and version is 5. There is no /etc/sudoers.d/ stuff
   # so we need to append to /etc/sudoers.
   cat /etc/sudoers build/openconnect > build/sudoers
   cmp build/sudoers /etc/sudoers 1> /dev/null 2>&1
   if [ $? -ne 0 ]; then
      visudo -c -f build/sudoers
      if [ $? -ne 0 ]; then exit 1; fi
      /usr/bin/install -b -v -m 440 -D build/sudoers /etc/sudoers
   fi
else
   visudo -c -f build/openconnect
   if [ $? -ne 0 ]; then exit 1; fi
   /usr/bin/install -v -m 440 -D build/openconnect /etc/sudoers.d/openconnect
fi

# ---------------------------------------------------------------------------------------- 
# Install ncepvpn
# ---------------------------------------------------------------------------------------- 
/usr/bin/install -v -m 755 -D src/ncepvpn $PREFIX/bin/ncepvpn

# ---------------------------------------------------------------------------------------- 
# Cleanup
# ---------------------------------------------------------------------------------------- 
rm -rf build/
