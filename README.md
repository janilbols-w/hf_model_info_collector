# Overview
- https://huggingface.co/docs/accelerate/usage_guides/model_size_estimator
- based on accelerate==1.10.1, collecting llm model based on its config
- auto pipe to generate csv file
```
,model_name,dtype,Largest layer Size(GB),Infer Model Size(GB),Train Ideal Peak Size with Adam(GB),Train Total Size w/o Offload(GB),Train Model Size(GB),Train Gradients(GB),Train Backward Optimizer(GB),Train Optimizer Step(GB)
0,unsloth/Meta-Llama-3.1-8B-Instruct-bnb-4bit,float32,1.96,27.96,111.83,223.66,27.96,27.96,55.92,111.83
1,unsloth/Meta-Llama-3.1-8B-Instruct-bnb-4bit,float16,0.98,13.98,55.92,181.73,27.96,41.94,55.92,55.92
2,unsloth/Meta-Llama-3.1-8B-Instruct-bnb-4bit,int8,0.49,6.99,-0.00,-0.00,N/A,N/A,N/A,N/A
3,unsloth/Meta-Llama-3.1-8B-Instruct-bnb-4bit,int4,0.24,3.49,-0.00,-0.00,N/A,N/A,N/A,N/A
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
