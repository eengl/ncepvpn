# ncepvpn

## Introduction

`ncepvpn` is a Bash shell script wrapper for [OpenConnect](https://www.infradead.org/openconnect/) for the purposes of connecting to NOAA/NCEP's VPN.  The script provides an easy-to-use interface rather then using OpenConnect directly.  Since OpenConnect requires `sudo` access, this package also includes sudo rules that allow user's to run openconnect without directly invoking sudo.

**IMPORTANT:** NCEP VPN hostname information is purposely excluded from this package as it is not for public knowledge.

## Supported Operating Systems

The following Linux operating systems have been tested:

* CentOS/RHEL/Rocky 8.x, 9.x
* Fedora 35+
* Ubuntu 20.04 LTS+

The following macOS versions have been tested:

* macOS 11 (Big Sur)
* macOS 12 (Monterey) **_(x86_64 and arm64 are supported as of v2.0.1)_**
* macOS 13 (Ventura)

## Software Dependencies

* openconnect
* vpnc

## Installation

Clone or download `ncepvpn` package.  **NOTE:**  Installation requires `sudo` access.  The script will install the sudo rules to the appropriate directory and ncepvpn to `$PREFIX`.

### Instructions

```shell
cd ncepvpn-X.Y.Z/
export PREFIX=/path/to/install # This is optional.  Default install path is /usr/local/bin/.
sudo ./install.sh
```

## Usage

On first connection attempt, `ncepvpn` will ask for primary and backup NCEP VPN URLs and your NCEP VPN username.  This information will be stored in `$HOME/.ncepvpn` and have the following format:

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

## OpenConnect Configuration

`ncepvpn` uses an OpenConnect configuration file, `$HOME/.openconnect`.  This gives the user the flexibility to modify the OpenConnect connection behavior without the need to modify the `ncepvpn` script.  The following OpenConnect flags will remain hardcoded in the `ncepvpn` script to maintain its intended behavior and interaction with the `ncepvpn` script.

* `-u`: Username
* `--background`: Tells OpenConnect to run in the background
* `--pid-file=`: Place the process ID of openconnect in the file

Recommended OpenConnect configuration options for connecting to NCEP VPNs (**IMPORTANT:** Do not include "-" or "--" in the OpenConnect configuration file):

* `no-dtls`
* `token-mode=rsa`: If you have your RSA token configured on your workstation using [stoken](https://github.com/cernekee/stoken)

Please consult the OpenConnect manual for proper syntax.
