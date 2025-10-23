LOG_ROOT=${LOG_ROOT:-'./output'}
grep -rn authenticated $LOG_ROOT | awk -F'/model_estimation' '{print $1}' | awk -F'output/' '{print $2}'