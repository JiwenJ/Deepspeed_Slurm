#!/usr/bin/env bash

GPUS=$1
NODE=${NODE:-1}
NODE_RANK=$SLURM_NODEID
ADDR=${ADDR:-127.0.0.1}
PORT=${PORT:-12345}

echo "NODE_RANK=$NODE_RANK"
source /hpc2hdd/home/qxiao183/SLM/env.sh

string=""
for ((i=0; i<$GPUS; i++)); do
  string="$string$i,"
done
string=${string%","}
export CUDA_VISIBLE_DEVICES=$string
echo "$CUDA_VISIBLE_DEVICES"

python3 -m torch.distributed.run --nnodes=$NODE --nproc_per_node=$GPUS --master_port=$PORT --node_rank $NODE_RANK --master_addr $ADDR \
    run_clm.py \
    --deepspeed ds_mitee.json

#     --max_steps 10 \
#     --model_name_or_path decapoda-research/llama-13b-hf \
#     --data_path ./FastChat-main/playground/data/alpaca-data-conversation.json \
#     --output_dir ./checkpoints \
#     --num_train_epochs 1 \
#     --per_device_train_batch_size 1 \
#     --per_device_eval_batch_size 1 \
#     --gradient_accumulation_steps 4 \
#     --evaluation_strategy "no" \
#     --save_strategy "steps" \
#     --save_steps 1000 \
#     --save_total_limit 100 \
#     --learning_rate 2e-5 \
#     --weight_decay 0. \
#     --warmup_ratio 0.03 \
#     --lr_scheduler_type "cosine" \
#     --logging_steps 1 \
#     --model_max_length 2048 \
#     --gradient_checkpointing True \
#     --lazy_preprocess True \
#     --fp16