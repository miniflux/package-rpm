Miniflux RPM Package
====================

This project is used to build a RPM package for Miniflux inside a Docker container.

The Miniflux daemon is supervised by systemd.
Environment variables can be changed in the file `/etc/miniflux.conf`.

- Place the binary here: `sources/miniflux`
- Build the package: `make`
- The RPM package will be located into the current folder: `miniflux-2.0.0-1.0.x86_64.rpm`
- To install the package: `sudo rpm -ivh miniflux-2.0.0-1.0.x86_64.rpm`
- To start the process: `sudo systemctl start miniflux`
- Check process status: `sudo systemctl status miniflux`

This package should work on Fedora and Centos/RHEL > 7.
