#!/bin/bash
LIB_PATH=`pip show accelerate| grep Location | awk '{print $2}'`

function patch_file(){
    src_file=$1
    target_file=$LIB_PATH/$src_file
    echo "patching $target_file"

    cp $src_file $target_file
}

patch_file ./accelerate/commands/estimate.py