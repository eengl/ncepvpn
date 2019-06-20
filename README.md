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

## Notes

`ncepvpn` v1.1.0+ will create an openconnect config file, `.openconnect`, in the user's home directory.  This gives the user the flexibility to add openconnect flags without the need to modify the `ncepvpn` script.  The required flags will remain statically typed in the script in order for `ncepvpn` to maintain its intended behavior.  The flags are: `-u`, `--background`, and `--pid-file=`.

Please read the openconnect manual for proper syntax of the openconnect config file.
