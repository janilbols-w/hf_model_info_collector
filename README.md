# Overview
- https://huggingface.co/docs/accelerate/usage_guides/model_size_estimator
- based on accelerate==1.10.1, collecting llm model based on its config
- auto pipe to generate csv file
```
,model_name,dtype,largest_layer(GB),infer_model(GB),train_model(GB),train_optimizer(GB),train_gradients(GB),train_step(GB)
0,unsloth/Meta-Llama-3.1-8B-Instruct-bnb-4bit,float32,1.95703125,27.95802330970764,27.95802330970764,55.91604661941528,27.95802330970764,111.83209323883057
1,unsloth/Meta-Llama-3.1-8B-Instruct-bnb-4bit,float16,0.978515625,13.97901165485382,27.95802330970764,55.91604661941528,41.93703496456146,55.91604661941528
```
# Quickstart
- modify `model_list.clean.txt` to meet your case
```bash
./scripts/run_all.sh
```

- single model info collection
```bash
./scripts/model_info_collector.sh <modeltag>
# e.g.
./scripts/model_info_collector.sh Qwen/Qwen3-8B
```
