LOG_ROOT=${LOG_ROOT:-'./outputs/raw'}
RAW_INFO_PATH=${RAW_INFO_PATH:-'./outputs/model_info.raw.txt'}
grep -rn "dtype_training_size" $LOG_ROOT | grep "model_name" | awk -F':{' '{print "{"$2}' > $RAW_INFO_PATH
