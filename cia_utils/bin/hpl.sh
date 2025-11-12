#!/bin/bash 


paquetes(){

rpm -ivh libevent-*
rpm -Uvh hwloc-* tmux-* htop-*

/bin/cp -avf  likwid-* /usr/local/sbin

}

numa_nodes(){
likwid-topology | awk '/NUMA\ domains:/{print $3}'
likwid-topology | grep -A 50 "NUMA Topology" > /tmp/.numa_topo
}

numa_node(){
NODE=$1
grep -A 3 "Domain $NODE:" /tmp/.numa_topo > /tmp/.numa_node$NODE 

}

numa_node_mem(){
NODE=$1
awk '/Memory:/{print $7}' /tmp/.numa_node$NODE | cut -d. -f1
}

numa_node_cores(){
NODE=$1

likwid-pin -p | grep S$NODE | awk -F: '{print $2 }' | xargs | tr " " \\n | wc -l

}

calcule_hpl(){
MEM=$1
VAL=$2
echo "sqrt ( ( $MEM  * 0.$VAL ) /.000008 ) " | bc

}

run_hpl_node(){

N_NODES=$(numa_nodes)
TOTAL_MEM=0
N_NODE=0
for N in $(seq 1 $N_NODES); do
numa_node $N_NODE
MEM_NODE=$(numa_node_mem $N_NODE)
CORES_NODE=$(numa_node_cores $N_NODE)

N_HPL=$(calcule_hpl $MEM_NODE 95)

#echo likwid-pin -c E:M${N_NODE}:${CORES_NODE}  ./XHPL -n $N_HPL

#logsave HPL-NODE-$N_NODE-$(date +%s) likwid-powermeter -c 0,1  

echo "
#####################################################
CORRIENDO PRUEBA EN NODO NUMA $N_NODE ($MEM_NODE MB)
#####################################################
"
sleep 3
if [ $N_NODES -eq 1 ] ;then
	logsave /tmp/.HPL-NODE-$N_NODE likwid-pin -c E:S${N_NODE}:${CORES_NODE}  ./XHPL -n $N_HPL
else
	logsave /tmp/.HPL-NODE-$N_NODE likwid-pin -c E:M${N_NODE}:${CORES_NODE}  ./XHPL -n $N_HPL
fi
let N_NODE++
let TOTAL_MEM=$TOTAL_MEM+$MEM_NODE
done 

}
run_hpl_system(){

TOTAL_MEM=$(numastat -m | awk '/MemTotal/{print $4}')
echo "
####################################################
CORRIENDO PRUEBA EN TODO EL SISTEMA ($TOTAL_MEM MB)
####################################################
"
N_HPL=$(calcule_hpl $TOTAL_MEM 40)

sleep 3

logsave /tmp/.HPL-SISTEMA ./XHPL -n $N_HPL

#grep WR .HPL* | colum -t 

#read -p Continuar[ENTER]
}

run_hpl_dimm(){
MEM=0
DIMM=1
./memconf | grep DIMM 

for mem in $(./memconf | awk  '/P/{print $3}' | tr MB " "); 
do let MEM=$MEM+$mem 
echo "
####################################################
CORRIENDO PRUEBA EN DIMM $DIMM ($MEM MB)
####################################################
"
N_HPL=$(calcule_hpl $MEM 90)

sleep 3

logsave /tmp/.HPL-DIMM-$DIMM ./XHPL -n $N_HPL

let DIMM++
done 

read 
}
./memconf 
read -p Continuar[ENTER]
run_hpl_system
run_hpl_node 

#run_hpl_dimm
#run_hpl_system

grep WR /tmp/.HPL* | column -t  
                           
read -p Continuar[ENTER]  

rm -f /tmp/.numa_node* /tmp/.numa_topo /tmp/.HPL-* /tmp/.numa*

tmux kill-session -t xhpl


