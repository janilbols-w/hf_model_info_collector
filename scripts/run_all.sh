#!/bin/bash
MODEL_LIST_FILE=${1:-'./model_list.clean.txt'}
cat $MODEL_LIST_FILE | xargs -I {} bash ./scripts/model_info_collector.sh {}
