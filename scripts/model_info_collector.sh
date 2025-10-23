#!/bin/bash
TAG=${1:-'Qwen/Qwen3-8B'}
LOG_ROOT=${LOG_ROOT:-'./output/'}
LOG_PATH=${LOG_ROOT}/$TAG
LOG_FILE=$LOG_PATH/model_estimation.txt
mkdir -p $LOG_PATH
# export HF_ENDPOINT=https://hf-mirror.com
accelerate estimate-memory ${TAG} 2>&1 | tee $LOG_FILE