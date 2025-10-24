LOG_ROOT=${LOG_ROOT:-'./outputs/raw'}
grep -rn authenticated $LOG_ROOT | awk -F'/model_estimation' '{print $1}' | awk -F'outputs/raw' '{print $2}'
