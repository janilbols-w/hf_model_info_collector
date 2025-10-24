#!/bin/bash
bash ./scripts/install_all.sh

MODEL_LIST_FILE=${1:-'./model_list.clean.txt'}
export LOG_ROOT=${LOG_ROOT:-'outputs/raw/'}
echo ">> collecting model info"
cat $MODEL_LIST_FILE | xargs -I {} bash ./scripts/model_info_collector.sh {}
echo "done collecting model info"

set +x 
export LOG_ROOT=${LOG_ROOT:-'outputs/raw/'}
export RAW_INFO_PATH=${RAW_INFO_PATH:-'./outputs/model_info.raw.txt'}
echo ">> collecting info from $LOG_ROOT"
bash ./scripts/collect_info.sh
echo "saving to $RAW_INFO_PATH"

# export LOG_ROOT=${LOG_ROOT:-'outputs/raw/'}
# export UNAUTH_MODEL_FILE=${UNAUTH_MODEL_FILE:-'./outputs/model_list.unauth.txt'}
# echo ">> generating failed case from $LOG_ROOT"
# bash ./scripts/check_unauth.sh
# echo "saving to $UNAUTH_MODEL_FILE"

export LOG_ROOT=${LOG_ROOT:-'outputs/raw/'}
export ERROR_MODEL_FILE=${ERROR_MODEL_FILE:-'outputs/model_list.undone.txt'}
echo ">> generating failed case from $LOG_ROOT"
bash ./scripts/check_error.sh
echo "saving to $ERROR_MODEL_FILE"

CSV_FILE_PATH=${CSV_FILE_PATH:-"./outputs/model_info.`date +%Y%m%d`.csv"}
echo ">> parsing info to csv"
python3 ./src/info_parser_raw2csv.py --raw-file $RAW_INFO_PATH --csv-file $CSV_FILE_PATH
echo "saving to $CSV_FILE_PATH"