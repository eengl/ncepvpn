# ncepvpn

## Synopsis

`ncepvpn` is a Bash shell script wrapper for connecting to NOAA/NCEP's VPN. The script uses `openconnect`, an open source Cisco AnyConnect SSL VPN compatible client. Normally, establishing a VPN connection via `openconnect` requires the user to have sudo access. This package will also install sudoer rules to allow the user to run `ncepvpn` and `openconnect` without sudo access.

## Motivation

Cisco's AnyConnect client for 64-bit Linux simply does not work for NOAA/NCEP's VPN.

## Requirements

* CentOS 5, 6, and 7
* RHEL 5, 6, and 7
* Fedora 24 and 25
* Ubuntu 14.04 LTS+

## Installation

Clone or download `ncepvpn` package.  **NOTE:**  Installation requires sudo/root access.

```shell
cd ncepvpn-X.Y.Z/
export PREFIX=/path/to/install # This is optional.  Default install path is /usr/local/bin/.
sudo ./install.sh
```

## Usage

On First run, `ncepvpn` will ask for your the NCEP VPN hostname and your username.  This information will be stored in `$HOME/.ncepvpn`.  Contents of `$HOME/.ncepvpn` are the following:

```
<NCEPVPN_HOSTNAME>
<NCEPVPN_USERNAME>
```

Usage:

```shell
user@computer:~$ ncepvpn

Usage: ncepvpn [c|d]

       c - Connect. Can also use "con" or "connect".
       d - Disconnect. Can also use "dis" or "disconnect".

State: Disconnected
```

To Connect:

```shell
user@computer:~$ ncepvpn c
Creating /home/user/.ncepvpn
Enter NCEP VPN Hostname: XXX.XXX.XXX.XXX
Enter your NCEP VPN Username: First.Last
...
Please enter your username and password.
PASSCODE:
```

To Disconnect:

```shell
ncepvpn d
```

## Notes

`ncepvpn` v1.1.0+ will create an openconnect config file, `.openconnect`, in the user's home directory.  This gives the user the flexibility to add openconnect flags without the need to modify the `ncepvpn` script.  The required flags will remain for `ncepvpn` to interface with openconnect properly (`-u`, `--background`, and `--pid-file=`).  Please read the openconnect manual for proper syntax of the openconnect config file.
