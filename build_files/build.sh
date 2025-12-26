#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# Add Tuxedo Computers repository
cat > /etc/yum.repos.d/tuxedo-computers.repo << 'EOF'
[tuxedo-computers]
name=TUXEDO Computers
baseurl=https://rpm.tuxedocomputers.com/fedora/$releasever/$basearch/base
enabled=1
gpgcheck=1
gpgkey=https://rpm.tuxedocomputers.com/fedora/$releasever/0x54840598.pub.asc
EOF

# this installs a package from fedora repos
dnf5 install -y tmux

# Install Tuxedo Control Center
dnf5 install -y tuxedo-control-center 

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

systemctl enable podman.socket
