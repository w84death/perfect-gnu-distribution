#!/bin/bash
clear
echo '========================'
echo 'Perfect GNU Distribution'
echo '  ~ The Script v1.1 ~   '
echo '========================'
echo ''

add_sources() {
    echo '1/3 Adding sources..'
    echo deb http://ftp.pl.debian.org/debian stretch-backports main contrib > /etc/apt/sources.list.d/stretch-backports.list
    echo deb http://ftp.pl.debian.org/debian strech non-free main > /etc/apt/sources.list.d/non-free.list
    apt update
    echo '1/3 Adding sources.. done'
}

install_base_pkgs() {
    yes | apt install --no-install-recommends \
        wicd wicd-daemon wicd-curses \
        mc htop git acpi wget sudo \
        wordgrinder vim nano dialog \
        woof vrms neofetch ncdu links2 \
        figlet make cowsay \
        alsa-utils linuxlogo tlp
}
install_xorg_pkgs() {
    yes | apt install --no-install-recommends \
        xserver-xorg-core \
        xserver-xorg-input-all xserver-xorg-video-fbdev \
        xserver-xorg-video-intel xinit xdm \
        icewm
}
install_extra_pkgs() {
    yes | apt install --no-install-recommends \
        pcmanfm mirage redshift gftp qmmp firefox-esr vlc

}

install_packages() {
    echo '2/3 Installing system packages..'

    echo 'System base packages will be installed.'
    echo -n '> Include X Window System (with IceWM) (y/n)?'
    read answer_xorg
    echo -n '> Include Extras (for X) (y/n)?'
    read answer_extra

    install_base_pkgs

    if [ "$answer_xorg" != "${answer_xorg#[Yy]}" ] ;then
            install_xorg_pkgs
    fi

    if [ "$answer_extra" != "${answer_extra#[Yy]}" ] ;then
            install_extra_pkgs
    fi

    echo '2/3 Installing system packages.. done.'
}


setup_terminal() {
    echo '3/3 Setup terminal..'

    linuxlogo > /etc/motd
    echo 'export PS1="> \A [\u] \w\n\\$ \[$(tput sgr0)\]"' >> ~/.bashrc
    echo 'export PS1="> \A [\u] \w\n\\$ \[$(tput sgr0)\]"' >> /home/kj/.bashrc
    echo '3/3 Setup terminal.. done.'
    finish_installation
}

abort_installation() {
    echo 'Installation aborted!'
}

finish_installation() {
    echo '-----------------------------------'
    echo 'Perfect GNU Distribution installed.'
    echo ''
    echo ' ~ You may now reboot the system ~ '
    echo ''
    echo '-----------------------------------'
}

echo '-----------------------------------'
echo 'Scenario:'
echo ' 1. Add sources'
echo ' 2. Install system packages'
echo ' 3. Setup terminal'
echo '-----------------------------------'
echo -n '> Start installation (y/n)?'
read answer

if [ "$answer" != "${answer#[Yy]}" ] ;then
add_sources && install_packages && setup_terminal
else
abort_installation
fi

