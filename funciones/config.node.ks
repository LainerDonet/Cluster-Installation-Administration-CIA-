#!/bin/bash
trap exit 1 2 5  

[ -z $CIA_ROOT ] && exit

. $CIA_ROOT/funciones/funciones.cia

NODE_NAME=$1
PART_SETUP=$2
PACK_SETUP=$3
NODE_IP=$4
NODE_MAC=$5
ROOT_DIR=$6
CONFIG=$7

[ -z $NODE_IP ] && NODE_IP=$(cia_return_ip $NODE_NAME)
[ -z $NODE_MAC ] && NODE_MAC=$(cia_return_mac $NODE_NAME)
 
[ -z $ROOT_DIR ] && ROOT_DIR=$CI_ROOT

KS_CONFIG=$ROOT_DIR/kickstart/${NODE_NAME}.ks

NODE_NETMASK=$(returnNetmaskIP $NODE_IP)
NODE_NETWORK=$(returnNetworkIP $NODE_IP)

LOCAL_DNS=$(returnLocalDns)
LOCAL_IP=$(returnDeviceIP $CIA_INSTALL_DEVICE)


#establecer directorio local

setupMainKickstart > $KS_CONFIG 
setupNetworkKickstart $NODE_IP $NODE_NETMASK $LOCAL_DNS $NODE_NAME >> $KS_CONFIG 

if [ "$PART_SETUP" == "no" ] ; then
case "$CONFIG" in 

desktop)
        setupPartDesktop >> $KS_CONFIG
;;

server)
        setupPartMaster  >> $KS_CONFIG
;;

node|"")
        setupPartNode  >> $KS_CONFIG
;;

minimal)
        setupPartMinimal  >> $KS_CONFIG
;;

test)
	setupPartMinimal >> $KS_CONFIG
;;

esac

fi
#####################################################
if [ "$PACK_SETUP" == "no" ] ; then

case "$CONFIG" in

desktop)
	setupPackDesktop >> $KS_CONFIG
	setupPackList >> $KS_CONFIG
;;

server)
	setupPackMaster  >> $KS_CONFIG
	setupPackOfed >> $KS_CONFIG 
	setupPackList >> $KS_CONFIG
	setupPostKickstart1 $NODE_IP $NODE_NAME $NODE_MAC $LOCAL_IP  >>$KS_CONFIG
;;

node|"")
	setupPackNode  >> $KS_CONFIG
	setupPackOfed >> $KS_CONFIG 
	setupPackList >> $KS_CONFIG
	setupPostKickstart $NODE_IP $NODE_NAME $NODE_MAC $LOCAL_IP >>$KS_CONFIG
;;

minimal)
	setupPackMinimal  >> $KS_CONFIG
;;

test)
	setupPackNode  >> $KS_CONFIG
	setupPackList >> $KS_CONFIG
	setupPostTest $LOCAL_IP  >> $KS_CONFIG
;;	

esac

fi
#cat $KS_CONFIG

#read 

