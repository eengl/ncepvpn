# ncepvpn

## Synopsis

`ncepvpn` is a Bash shell script wrapper for connecting to NOAA/NCEP's VPN. The script uses `openconnect`, an open source Cisco AnyConnect SSL VPN compatible client. Normally, establishing a VPN connection via `openconnect` requires the user to have sudo access. This package will also install sudoer rules to allow the user to run `ncepvpn` and `openconnect` without sudo access.

## Motivation

Cisco AnyConnect client for 64-bit Linux simply does not work for NOAA/NCEP's VPN.

## Requirements

* CentOS 5, 6, and 7
* RHEL 5, 6, and 7
* Fedora 24 and 25
* Ubuntu 14.04 LTS+

## Installation

Clone or download `ncepvpn` package.  Installation does require sudo/root access.

```shell
cd ncepvpn
export PREFIX=/path/to/install
sudo ./install.sh
```

## Usage

On First run, `ncepvpn` will ask for your the NCEP VPN hostname and your username.  This information will be stored in `$HOME/.ncepvpn`.

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
