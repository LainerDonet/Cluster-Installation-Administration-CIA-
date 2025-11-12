#!/bin/bash

CIA_ROOT=$(dirname $PWD)
CIA_MASTER_HOSTNAME=$(hostname)
CIA_REPO_FILE=/etc/httpd/conf.d/cia-repo.conf
CIA_KS_FILE=/etc/httpd/conf.d/cia-kickstart.conf
export CIA_ROOT 
export CI_ROOT=$CIA_ROOT/cluster_install
export CA_ROOT=$CIA_ROOT/cluster_admin  

################################################################################
. $CIA_ROOT/funciones/funciones.cia
################################################################################

[ ! -e $CIA_ROOT/cia_utils/RPMS/x86_64 ] && usage "El directorio $CIA_ROOT/cia_utils/RPMS/x86_64 no existe." 
[ ! -e $CIA_ROOT/cia_utils/RPMS/noarch ] && usage "El directorio $CIA_ROOT/cia_utils/RPMS/noarch no existe." 


echo "#!/bin/bash
export CIA_ROOT=$CIA_ROOT
export CI_ROOT=$CIA_ROOT/cluster_install
export CA_ROOT=$CIA_ROOT/cluster_admin
[ ! -f $CIA_CONFIG_FILE ] && echo "Config file not found." && exit 1

\$CA_ROOT/bin/ca_install \$*

" > /usr/local/sbin/cluster_install

###########################################

echo "#!/bin/bash
export CIA_ROOT=$CIA_ROOT
export CI_ROOT=$CIA_ROOT/cluster_install
export CA_ROOT=$CIA_ROOT/cluster_admin

[ ! -f $CIA_CONFIG_FILE ] && echo "Config file not found." && exit 1

\$CA_ROOT/bin/ca_update \$* 
" > /usr/local/sbin/cluster_update

###########################################

echo "#!/bin/bash
export CIA_ROOT=$CIA_ROOT
export CI_ROOT=$CIA_ROOT/cluster_install
export CA_ROOT=$CIA_ROOT/cluster_admin
[ ! -f $CIA_CONFIG_FILE ] && echo "Config file not found." && exit 1

\$CA_ROOT/bin/ca_ping \$*
" > /usr/local/sbin/cluster_ping
###########################################

echo "#!/bin/bash
export CIA_ROOT=$CIA_ROOT
export CI_ROOT=$CIA_ROOT/cluster_install
export CA_ROOT=$CIA_ROOT/cluster_admin
[ ! -f $CIA_CONFIG_FILE ] && echo "Config file not found." && exit 1

\$CA_ROOT/bin/ca_exec \$*
" > /usr/local/sbin/cluster_exec
###########################################

echo "#!/bin/bash
export CIA_ROOT=$CIA_ROOT
export CI_ROOT=$CIA_ROOT/cluster_install
export CA_ROOT=$CIA_ROOT/cluster_admin
[ ! -f $CIA_CONFIG_FILE ] && echo "Config file not found." && exit 1

\$CA_ROOT/bin/ca_export \$*
" > /usr/local/sbin/cluster_export

###########################################

###########################################
echo "#!/bin/bash
export CIA_ROOT=$CIA_ROOT
export CI_ROOT=$CIA_ROOT/cluster_install
export CA_ROOT=$CIA_ROOT/cluster_admin
[ ! -f $CIA_CONFIG_FILE ] && echo "Config file not found." && exit 1

\$CA_ROOT/bin/ca_ipmi \$*
" > /usr/local/sbin/cluster_ipmi

###########################################

###########################################

echo "#!/bin/bash
export CIA_ROOT=$CIA_ROOT
export CI_ROOT=$CIA_ROOT/cluster_install
export CA_ROOT=$CIA_ROOT/cluster_admin
[ ! -f $CIA_CONFIG_FILE ] && echo "Config file not found." && exit 1

\$CA_ROOT/bin/ca_power \$*
" > /usr/local/sbin/cluster_power

###########################################

###########################################

chmod 740 /usr/local/sbin/cluster_power
chmod 740 /usr/local/sbin/cluster_ipmi
chmod 740 /usr/local/sbin/cluster_install
chmod 740 /usr/local/sbin/cluster_update
chmod 740 /usr/local/sbin/cluster_export
chmod 740 /usr/local/sbin/cluster_ping 
chmod 740 /usr/local/sbin/cluster_exec 

echo "
####################
Archivos creados
####################
/usr/local/sbin/cluster_power
/usr/local/sbin/cluster_ipmi
/usr/local/sbin/cluster_install
/usr/local/sbin/cluster_update
/usr/local/sbin/cluster_dhcpd
/usr/local/sbin/cluster_export
/usr/local/sbin/cluster_ping
/usr/local/sbin/cluster_exec
"

