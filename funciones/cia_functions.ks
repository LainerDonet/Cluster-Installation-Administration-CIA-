#!/bin/bash 


setupExtras7(){
cat <<END
rrdtool-devel
apr-devel
libart_lgpl-devel
libconfuse-devel
libmemcached-devel
python-virtualenv

END
}

setupMainKickstart(){
cat <<END
#CIA MASTER Kickstart Configurator

firewall --disabled
selinux --disabled
skipx
firstboot --disable

lang en_US.UTF-8
keyboard us
rootpw ironman
authconfig --enableshadow --passalgo=sha512 
timezone --utc America/Mexico_City
#timezone America/Tijuana

bootloader --location=mbr --append="elevator=deadline rdblacklist=nouveau nouveau.modeset=0 console=ttyS1,115200 console=tty0 "

services --disabled opensmd,ibacm,openibd,abrt-ccpp,abrt-oops,avahi-daemon,certmonger,cups,jexec,kdump,irqbalance,iptables,ip6tables,postfix,abrtd,libvirt-guests,portreserve,nvidia,lustre,lnet,libvirtd,hypervkvpd,bluetooth,bmc-watchdog,cachefilesd,openct,pcscd,cpuspeed,bluetooth,iscsi,iscsid,ksm,ksmtuned,ipmidetectd,shellinaboxd

services --enabled rsh,rlogin,ntpd,ipmi,rdma,cpuspeed
 
reboot

logging --host=172.17.253.253 --level=debug

#poweroff
unsupported_hardware

END
}


setupNetworkKickstart(){
NODE_IP=$1
NODE_NETMASK=$2
NODE_DNS=$3
NODE_NAME=$4

cat <<END
network --device=eth0 --onboot=yes --bootproto=static --ip=$NODE_IP --netmask=$NODE_NETMASK --nodns  --hostname=$NODE_NAME

END
}

setupPartMinimal(){

cat <<END
zerombr
clearpart --all --initlabel
part / --fstype=ext4 --size=400000  --ondisk=sda
part swap --recommended --ondisk=sda
#part /scratch --fstype=ext4 --size=80 --grow --ondisk=sda

END
}

setupPartDesktop(){
cat <<END
zerombr
clearpart --all --initlabel
part / --fstype=ext4 --size=10000  --ondisk=sda
part /home --fstype=ext4 --size=10000 --grow --ondisk=sda
part swap --recommended --ondisk=sda

END

}

setupPartMaster(){
cat <<END
zerombr
clearpart --all --initlabel
part /boot/efi --fstype=efi --size=100 --ondisk=sda --label=EFI
part / --fstype=ext4 --size=50000  --ondisk=sda --label=ROOT
part /opt --fstype=ext4 --size=50000 --grow  --ondisk=sda --label=OPT
part /home --fstype=ext4 --size=50000 --grow --ondisk=sda --label=HOME
part swap --fstype=swap --recommended --label=SWAP --ondisk=sda
part /scratch --fstype=ext4 --size=70000 --grow --ondisk=sda

END
}

setupPartMaster_NOEFI(){
cat <<END
zerombr
clearpart --all --initlabel
part / --fstype=ext4 --size=50000  --ondisk=sda
part /opt --fstype=ext4 --size=50000  --ondisk=sda
part /home --fstype=ext4 --size=100 --grow --ondisk=sda
part swap --recommended --ondisk=sda

END
}


setupPartNode(){
cat <<END
zerombr
clearpart --all --initlabel
part / --fstype=ext4 --size=100000  --ondisk=sda
#part /home --fstype=ext4 --size=100 --grow --ondisk=sda
part /scratch --fstype=ext4 --size=80 --grow --ondisk=sda
part swap --recommended --ondisk=sda

END

}

setupPackDesktop(){
cat <<END
%packages --ignoremissing
@base
@core
@desktop

%end 
END
}

setupPackMinimal(){
cat <<END
%packages --ignoremissing
@base

%end
END

}

setupPackOfed(){
cat <<ENDIB
@Infiniband Support
infiniband-diags
libibcommon
mstflint
opensm
perftest
qperf
srptools
ENDIB

#dapl-devel        
#ibacm-devel       
#ibutils-devel     
#libibcm-devel     
#libibcommon-devel 
#libibmad-devel    
#libibumad-devel   
#libibverbs-devel  
#librdmacm-devel   
#opensm-devel      
#libibcommon 
#opensm 
#infiniband-diags 
#mstflint         
#qperf            
#srptools         

}

setupPackNode(){
cat <<END
%packages --ignoremissing
@ backup-server
@ base
@ console-internet
@ core
@ debugging
@ development
@ emacs
@ hardware-monitoring
@ identity-management-server
@ infiniband
@ legacy-unix
@ network-server
@ network-file-system-client
@ network-tools
@ performance
@ php
@ perl-runtime
@ scalable-file-systems
@ scientific
@ server-platform-devel
@ server-policy
@ spanish-support
@ system-admin-tools
@ technical-writing

END
}

setupPackMaster(){

cat <<END
%packages --ignoremissing
@additional-devel
@backup-server
@base
@cifs-file-server
@client-mgmt-tools
@compat-libraries
@console-internet
@core
@debugging
@desktop
@desktop-debugging
@desktop-platform
@desktop-platform-devel
@development
@emacs
@fonts
@general-desktop
@graphical-admin-tools
@graphics
@hardware-monitoring
@identity-management-server
@input-methods
@internet-browser
@java-platform
@large-systems
@legacy-unix
@legacy-x
@mail-server
@network-file-system-client
@network-server
@network-tools
@performance
@perl-runtime
@php
@remote-desktop-clients
@ruby-runtime
@scalable-file-systems
@scientific
@server-platform
@server-platform-devel
@server-policy
@spanish-support
@system-admin-tools
@system-management
@system-management-messaging-server
@system-management-snmp
@technical-writing
#@Virtualization
#@Virtualization Client
#@Virtualization Platform
#@Virtualization Tools
@web-server
@x11

END
} 


setupPackList(){

cat <<END
alacarte
ant
apr-devel
asciidoc
audit-viewer
automake
babel
binutils-devel
bitmap-lucida-typewriter-fonts
boost-devel
busybox-anaconda
bzip2-devel
cachefilesd
cairo-devel 
certmonger
cmake
cmake-gui
cpupowerutils
compat-gcc-34
compat-gcc-34-c++
compat-gcc-34-g77
compat-libstdc++-33.i686
compat-libstdc++-33.x86_64
conman
crypto-utils
ctags-etags
cups-devel
dcraw
desktop-file-utils
device-mapper-multipath
dhcp
dnsmasq
docbook-utils-pdf
dos2unix
dtach
dumpet
ElectricFence
edac-utils.x86_64
elfutils-devel
e2fsprogs-devel
elfutils-libelf-devel
emacs-auctex
emacs-gnuplot
emacs-nox
environment-modules.x86_64
expat-devel
expect
finger
firstaidkit-gui
freeglut-devel
freeipmi
freeipmi-bmc-watchdog
freeipmi-ipmidetectd
fuse-devel
gcc
gcc-c++
gcc-objc
gcc-objc++
gconf-editor
gdbm-devel
gedit-plugins
genisoimage
glade3
glib2-devel 
glibc.i686
gmp-devel
gnome-common
gnome-devel-docs
gnutls-devel
gpm
gtk2-devel-docs
gtk2.i686
hardlink
hmaccalc
httpd-devel
hunspell-devel
ImageMagick
imake
inkscape
ipmitool
iptables-devel
iptraf
jpackage-utils
kernel-doc
ksh
libacl-devel
libaio-devel
libattr-devel
libblkid-devel
libbonobo-devel
libcap-devel
libdrm-devel
libevent-devel
libgcrypt-devel
libglade2-devel
libgnomeui-devel
libgudev1-devel
libhugetlbfs-devel
libotf
libpciaccess-devel
libnl-devel
libselinux-devel
libSM.i686
libstdc++-devel.i686
libstdc++-devel.x86_64
libstdc++-docs
libstdc++.i686
libstdc++.x86_64
libsysfs-devel
libtiff-devel
libtopology-devel
libudev-devel
libusb-devel
libuuid-devel
libX11.i686
libXau-devel
libXau.i686
libXaw-devel
libxcb.i686
libXcomposite-devel
libXdamage-devel
libXext.i686
libXi-devel
libXi.i686
libXinerama-devel
libxml2-devel
libXmu
libXmu-devel
libXp
libXp-devel
libXpm-devel
libXp.x86_64
libXrandr-devel
libXScrnSaver-devel
libxslt-devel
libXt.i686
libXtst.i686
libXvMC-devel
libXxf86vm
libXxf86vm.i686
libyaml-devel.x86_64 
lm_sensors
logwatch
lua-devel
make
mc
mercurial
mesa-libGLU
mesa-libGLw-devel
mesa-libOSMesa-devel
mgetty
mod_dav_svn
mtools
mutt
nasm
ncurses-term
netpbm-progs
net-snmp-devel
net-snmp-perl
net-snmp-python
newt-devel
nmap
numactl-devel
numpy
oddjob
openhpi
openhpi-subagent
OpenIPMI
openmotif
openmotif22
openmotif-devel
openmotif.x86_64
oprofile-gui
pango-devel 
papi
papi-devel
patchutils
pax
pciutils-devel
pcre-devel 
perftest
perl-CGI
perl-Compress-Zlib
perl-Date-Manip
perl-DBD-SQLite
perl-ExtUtils-Embed
perl-Test-Pod
perl-Test-Pod-Coverage
perltidy
pexpect
php-gd
planner
popt-devel
python-devel
python-dmidecode
python-docs
python-docutils
python-imaging
rdesktop
rrdtool.x86_64            
rrdtool-devel.x86_64
rdist
readline-devel
redhat-rpm-config
rpm-build
rpmdevtools
rpmlint
rsh
rsh-server
ruby-devel 
samba
screen
scrub
SDL-devel
sgpio
slang-devel
spice-client
spice-xpi
squashfs-tools
startup-notification-devel
stunnel
symlinks
syslinux
system-config-kickstart
system-config-lvm
taskjuggler
tcl-devel 
tcp_wrappers
tcp_wrappers-devel
texinfo
texlive-latex
tftp
tftp-server
tigervnc
tigervnc-server
tk-devel 
tree
tsclient
tunctl
udftools
unique-devel
unix2dos
unixODBC-devel
uuidd
vim-X11
vinagre
vlock
watchdog
wireshark
wodim
xdelta
xinetd
xfig
xmlto
xmltoman
xmlto-tex
xorg-x11-fonts-75dpi
xorg-x11-fonts-cyrillic.noarch
xorg-x11-fonts-ISO8859-1-75dpi.noarch 
xorg-x11-fonts-Type1
xorg-x11-proto-devel
xorg-x11-twm
xorg-x11-xdm
xrestop
xterm
xterm.x86_64
xulrunner-devel
xz-devel
yum-plugin-changelog
yum-plugin-downloadonly
yum-presto
zlib-devel
zsh
-abrt-desktop
-anaconda 
-atlas
-hwloc 
-cups-libs.i686 
-gtk2.i686
-krb5-libs.i686
-libcom_err.i686 
-krb5-workstation
-libcxgb3
-libsdp 
-libvirt-client
-libvirt-java
-mpi-selector
-mysql-devel
-memcached
-ipa-server
-ipa-server-selinux
-NetworkManager
-NetworkManager-gnome 
-numpy
-openmpi
-openmpi-libs
-oprofile
-PackageKit
-postgresql-devel
-postgresql
-python-matplotlib
-sabayon 
-sysstat 
-seekwatcher
-spamassassin
-sysreport
-system-config-kickstart
-systemtap-sdt-devel
-systemtap-server
-virt-what

%end 
END

}

setupPostKickstart0(){

echo "
%post
# redirect the output to the log file
exec >/root/ks-post-anaconda.log 2>&1
# show the output on the 7th console
tail -f /root/ks-post-anaconda.log >/dev/tty7 &
# changing to VT 7 that we can see what's going on....
/usr/bin/chvt 7
%end
" 
}

setupPostKickstart(){
NODE_IP=$1
NODE_NAME=$2
NODE_MAC=$3
CIA_MASTER_IP=$4
echo "
%post --log=/root/.ks-post.log 

mkdir /cia                                 
mount -o nolock $CIA_MASTER_IP:$CIA_ROOT /cia  
curl -s "$CIA_MASTER_IP/$NODE_NAME#CIA_POST:BEGIN+++++++++++++++" &>/dev/null 
bash -x /cia/cluster_install/bin/ci_post-install-node $NODE_NAME $NODE_IP $NODE_NETMASK $NODE_MAC $CIA_ROOT $CIA_MASTER_IP 
curl -s "$CIA_MASTER_IP/$NODE_NAME#CIA_POST:END+++++++++++++++" &>/dev/null 
%end

%post --nochroot

if grep -q -w CIA.SHELL /proc/cmdline ; then touch /tmp/shell.cia ; fi 
 
while [ -f /tmp/shell.cia ] ; do sleep 5
curl -s "$CIA_MASTER_IP/$NODE_NAME#CIA_POST:CIA.SHELL" &>/dev/null 
done 

%end

"

}

setupPostTest(){
CIA_MASTER_IP=$1

echo "
%post --log=/root/.ks-post.log 

cd /usr/local/src
wget -nH -r $CIA_MASTER_IP/cia-hpl/.tmux 
chmod +x /usr/local/src/cia-hpl/* 
rm -f /usr/local/src/cia-hpl/index* /usr/local/src/cia-hpl/.tmux/index*

echo screen -dmS WEB /usr/local/src/cia-hpl/.tmux/rc.local >>  /etc/rc.local 


%end

%post --nochroot
cp /tmp/*.log /mnt/sysimage/root/
mkdir /cia/log/$NODE_NAME
cp /tmp/*.log /cia/log/$NODE_NAME  
%end
"
}

setupPostKickstart1(){
NODE_IP=$1
NODE_NAME=$2
NODE_MAC=$3
CIA_MASTER_IP=$4 
cat<<'ENDKS-'

#%post --nochroot
#mkdir /mnt/sysimage/root/.logs
#cp /tmp/*.log /mnt/sysimage/root/.logs

#%end 

%post --log=/root/ks-post.log

set +x
cat<<'EOFRC-'> /root/.bashrc

# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions


PS1="------------\n\033[1;37;44m{`hostname`}:\033[36m \w\033[0;0m \n\[\033[30;47m\][\[\033[31m\]\u\[\033[30;47m\]@:\W]$\[\033[00m\](\#)->" 

alias tailm='tail /var/log/messages'
alias tailmf='tailf /var/log/messages'
function ff() { find . -name '*'$1'*' ; }                 # find a file
function fe() { find . -name '*'$1'*' -exec $2 {} \; ; }  # find a file and run $2 on it 

# Store 5000 commands in history buffer
export HISTSIZE=5000
 
# Store 5000 commands in history FILE 
export HISTFILESIZE=5000      
 
# Avoid duplicates in hisotry 
export HISTIGNORE='&:[ ]*'

EOFRC-

echo "

Host *
        GSSAPIAuthentication no
	CheckHostIP	no
	StrictHostKeyChecking	no
	UsePrivilegedPort	no
        ForwardX11Trusted yes
        SendEnv LANG LC_CTYPE LC_NUMERIC LC_TIME LC_COLLATE LC_MONETARY LC_MESSAGES 
        SendEnv LC_PAPER LC_NAME LC_ADDRESS LC_TELEPHONE LC_MEASUREMENT 
        SendEnv LC_IDENTIFICATION LC_ALL

" > /etc/ssh/ssh_config

echo "
Port 22
Protocol 2
SyslogFacility AUTHPRIV
PasswordAuthentication yes
ChallengeResponseAuthentication no
GSSAPIAuthentication no
GSSAPICleanupCredentials no
UsePAM yes
AcceptEnv LANG LC_CTYPE LC_NUMERIC LC_TIME LC_COLLATE LC_MONETARY LC_MESSAGES
AcceptEnv LC_PAPER LC_NAME LC_ADDRESS LC_TELEPHONE LC_MEASUREMENT
AcceptEnv LC_IDENTIFICATION LC_ALL LANGUAGE
AcceptEnv XMODIFIERS
X11Forwarding yes
UseDNS no
Subsystem	sftp	/usr/libexec/openssh/sftp-server

" >/etc/ssh/sshd_config

[ ! -f /etc/profile.d/ssh-key.sh ] && cat<<'EOF-'> /etc/profile.d/ssh-key.sh

if [[ $INTERACTIVE != "false" ]] && [ ! -f $HOME/.ssh/id_dsa.pub ]
then
        ssh-keygen -q -t dsa -f $HOME/.ssh/id_dsa  -C '' -N ''  

        cat $HOME/.ssh/id_dsa.pub >> $HOME/.ssh/authorized_keys

        chmod 600 $HOME/.ssh/authorized_keys
        chmod g-w $HOME
fi

EOF-

[ ! -f /etc/profile.d/ssh-key.csh ] && cat<<'EOF-'> /etc/profile.d/ssh-key.csh
bash /etc/profile.d/ssh-key.sh

EOF-
chmod 755  /etc/profile.d/ssh-key.sh /etc/profile.d/ssh-key.csh

ENDKS-

cat<<EOFETC 
echo "
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
$NODE_IP $NODE_NAME" > /etc/hosts

echo "LANG=en_US.UTF-8
SYSFONT=Lat2-Terminus16.psfu.gz
" > /etc/sysconfig/i18n

echo "soporte ALL=(ALL)       ALL" >> /etc/sudoers 

%end

EOFETC


}


