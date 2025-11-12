#!/bin/bash 
 [ $UID == 0 ] && return 
 [ ! -e /data/$USER ] && mkdir -p /data/$USER 
 [ ! -e /scratch/$USER ] && mkdir  -p /scratch/$USER 

