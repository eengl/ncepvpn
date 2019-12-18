# ncepvpn

## Synopsis

`ncepvpn` is a Bash shell script wrapper for connecting to NOAA/NCEP's VPN. The script uses `openconnect`, an open source Cisco AnyConnect SSL VPN compatible client. Normally, establishing a VPN connection via `openconnect` requires the user to have sudo access. This package will also install sudoer rules to allow the user to run `ncepvpn` and `openconnect` without sudo access.

## Motivation

Cisco's AnyConnect client for 64-bit Linux simply does not work for NOAA/NCEP's VPN.

## Supported Operating Systems

The following 64-bit Linux operating systems have been tested:

* CentOS/RHEL 6.x, 7.x
* Fedora 24+
* Ubuntu 14.04 LTS, 16.04 LTS, 18.04 LTS

The following macOS versions have been tested:

* macOS 10.14 (Mojave)
* macOS 10.15 (Catalina)

## Software Dependencies

* openconnect
* vpnc

## Installation

Clone or download `ncepvpn` package.  **NOTE:**  Installation requires sudo/root access.  The install script will perform the following:

* Install sudo rules
* Install ncepvpn

### Instructions

```shell
cd ncepvpn-X.Y.Z/
export PREFIX=/path/to/install # This is optional.  Default install path is /usr/local/bin/.
sudo ./install.sh
```

## Usage

On first connection attempt, `ncepvpn` will ask for primary and backup NCEP VPN URLs and your username.  Because this is a public repository, the NCEP VPN hostnames will not be given.  This information will be stored in `$HOME/.ncepvpn`.  Contents of `$HOME/.ncepvpn` are the following:

```
primary_url=...
backup_url=...
user=...
```

Usage:

```shell
$ ncepvpn
ncepvpn version X.Y.Z

Usage: ncepvpn ACTION [CHOICE]

   ACTION - To connect enter "c|on|nect"; to disconnect enter "d|is|connect"
   CHOICE - Connect to primary VPN URL enter "p|ri|mary" [DEFAULT] or backup enter "b|ac|kup"

Config Files:
   ncepvpn: /Users/ericengle/.ncepvpn
   openconnect: /Users/ericengle/.openconnect

State: Disconnected
```

To connect to the primary VPN:

```shell
$ ncepvpn c
```

```shell
$ ncepvpn c p
```

To connect to the backup VPN:

```shell
$ ncepvpn c b
```

To disconnect:

```shell
ncepvpn d
```

## Openconnect Configuration

`ncepvpn` v1.1.0 and newer supports a openconnect configuration file, `.openconnect`, in the user's home directory (i.e. `$HOME/.openconnect`).  This gives the user the flexibility to add openconnect flags without the need to modify the `ncepvpn` script.  The following openconnect flags will remain hardcoded in the `ncepvpn` script to maintain its intended behavior and interaction with the `ncepvpn` script.

- `-u`: User name
- `--background`: Run openconnect in the background
- `--pid-file=`: Place the process ID of openconnect in the file

Recommended openconnect configuration options for connecting to NCEP VPNs (**IMPORTANT:** Do not include "-" or "--" in the openconnect configuration file):

- `no-dtls`
- `token-mode=rsa`: If you have your RSA token configured on your workstation using [stoken](https://github.com/cernekee/stoken)

Please read the openconnect manual for proper syntax of the openconnect config file.
