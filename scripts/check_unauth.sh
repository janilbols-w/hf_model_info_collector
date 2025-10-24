LOG_ROOT=${LOG_ROOT:-'outputs/raw'}
UNAUTH_MODEL_FILE=${UNAUTH_MODEL_FILE:-'outputs/model_list.unauth.txt'}
grep -rn authenticated $LOG_ROOT | \
    awk -F'/model_estimation' '{print $1}' | \
    awk -F'outputs/raw' '{print $2}'