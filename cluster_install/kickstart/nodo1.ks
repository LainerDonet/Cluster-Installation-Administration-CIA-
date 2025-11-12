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

network --device=eth0 --onboot=yes --bootproto=static --ip=172.17.1.1 --netmask=255.255.0.0 --nodns  --hostname=nodo1

zerombr
clearpart --all --initlabel
part / --fstype=ext4 --size=100000  --ondisk=sda
#part /home --fstype=ext4 --size=100 --grow --ondisk=sda
part /scratch --fstype=ext4 --size=80 --grow --ondisk=sda
part swap --recommended --ondisk=sda

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

@Infiniband Support
infiniband-diags
libibcommon
mstflint
opensm
perftest
qperf
srptools
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

%post --log=/root/.ks-post.log 

mkdir /cia                                 
mount -o nolock 172.17.253.253:/usr/cia-7.6.1810 /cia  
curl -s 172.17.253.253/nodo1#CIA_POST:BEGIN+++++++++++++++ &>/dev/null 
bash -x /cia/cluster_install/bin/ci_post-install-node nodo1 172.17.1.1 255.255.0.0 0c:c4:7a:69:56:d6 /usr/cia-7.6.1810 172.17.253.253 
curl -s 172.17.253.253/nodo1#CIA_POST:END+++++++++++++++ &>/dev/null 
%end

%post --nochroot

if grep -q -w CIA.SHELL /proc/cmdline ; then touch /tmp/shell.cia ; fi 
 
while [ -f /tmp/shell.cia ] ; do sleep 5
curl -s 172.17.253.253/nodo1#CIA_POST:CIA.SHELL &>/dev/null 
done 

%end


