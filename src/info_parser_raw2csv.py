from argparse import ArgumentParser
import json
import pandas as pd
bytes_per_mb = 1024 * 1024
bytes_per_gb = 1024 * 1024 * 1024

def parse_line(line):
    sample = json.loads(line.replace("\'", "\""))
    size_model =        sample['dtype_training_size']['model'] / bytes_per_gb 
    size_gradients =    sample['dtype_training_size']['gradients'] / bytes_per_gb
    size_optimizer =    sample['dtype_training_size']['optimizer'] / bytes_per_gb
    size_step =         sample['dtype_training_size']['step'] / bytes_per_gb
    return [sample['model_name'], 
            sample['dtype'], 
            "{:.2f}".format(sample['dtype_largest_layer'] / bytes_per_gb), 
            "{:.2f}".format(sample['dtype_total_size'] / bytes_per_gb),
            "{:.2f}".format(max(size_model, size_gradients, size_optimizer, size_step)),
            "{:.2f}".format(sum([size_model, size_gradients, size_optimizer, size_step])),
            "{:.2f}".format(size_model) if size_model >=0 else "N/A",
            "{:.2f}".format(size_gradients) if size_gradients >=0 else "N/A",
            "{:.2f}".format(size_optimizer) if size_optimizer >=0 else "N/A",
            "{:.2f}".format(size_step) if size_step >=0 else "N/A",
            ]

def main():
    parser = ArgumentParser()
    parser.add_argument("--raw-file", type=str, default="./outputs/model_info.raw.txt", help="path to raw model info file.")
    parser.add_argument("--csv-file", type=str, default="./outputs/model_info.csv", help="path to saving csv info file.")
    args = parser.parse_args()
    print(args)

    columns = ['model_name', 
                  'dtype', 
                  'Largest layer Size(GB)', 
                  'Infer Model Size(GB)',
                  'Train Ideal Peak Size with Adam(GB)',
                  'Train Total Size w/o Offload(GB)',
                  'Train Model Size(GB)',
                  'Train Gradients(GB)',
                  'Train Backward Optimizer(GB)',
                  'Train Optimizer Step(GB)',
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
    