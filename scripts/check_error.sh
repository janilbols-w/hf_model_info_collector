LOG_ROOT=${LOG_ROOT:-'outputs/raw'}
ERROR_MODEL_FILE=${ERROR_MODEL_FILE:-'outputs/model_list.undone.txt'}

grep -rni error $LOG_ROOT | \
    awk -F'/model_estimation' '{print $1}' | \
    awk -F $LOG_ROOT '{print $2}'| sort | uniq \
    2>&1 | tee $ERROR_MODEL_FILE