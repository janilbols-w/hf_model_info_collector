from argparse import ArgumentParser
import json
import pandas as pd
bytes_per_mb = 1024 * 1024
bytes_per_gb = 1024 * 1024 * 1024

def parse_line(line):
    sample = json.loads(line.replace("\'", "\""))
    return [sample['model_name'], 
                        sample['dtype'], 
                        sample['dtype_largest_layer'] / bytes_per_gb, 
                        sample['dtype_total_size'] / bytes_per_gb,
                        sample['dtype_training_size']['model'] / bytes_per_gb if sample['dtype_training_size']['model'] >=0 else -1,
                        sample['dtype_training_size']['optimizer'] / bytes_per_gb if sample['dtype_training_size']['optimizer'] >=0 else -1,
                        sample['dtype_training_size']['gradients'] / bytes_per_gb if sample['dtype_training_size']['gradients'] >=0 else -1,
                        sample['dtype_training_size']['step'] / bytes_per_gb if sample['dtype_training_size']['step'] >=0 else -1,
                        ]

def main():
    parser = ArgumentParser()
    parser.add_argument("--raw-file", type=str, default="./outputs/model_info.raw.txt", help="path to raw model info file.")
    parser.add_argument("--csv-file", type=str, default="./outputs/model_info.csv", help="path to saving csv info file.")
    args = parser.parse_args()
    print(args)

    columns = ['model_name', 
                  'dtype', 
                  'largest_layer(GB)', 
                  'infer_model(GB)',
                  'train_model(GB)',
                  'train_optimizer(GB)',
                  'train_gradients(GB)',
                  'train_step(GB)',
                  ]
    with open(args.raw_file, "r") as f:
        data_raw = f.readlines()
    
    data = [parse_line(line) for line in data_raw]
    df = pd.DataFrame(data=data, columns=columns)
    df.to_csv(args.csv_file)
    print("done parsing, saving to", args.csv_file)
    return

if __name__ == '__main__':
    main()
    