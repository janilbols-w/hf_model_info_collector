SRC_PATH=${SRC_PATH:-'./outputs/raw'}
FILE_PATH=${FILE_PATH:-'./outputs/model_info.raw.txt'}
grep -rn "dtype_training_size" $SRC_PATH | grep "model_name" | awk -F':{' '{print "{"$2}' > $FILE_PATH
