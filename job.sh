#!/bin/bash

#SBATCH --job-name=PHI3
#SBATCH --partition=llm_group_rent
#SBATCH --nodes=2
#SBATCH --comment="Pretrain Phi-3 on Slimpajama-6B on Multiple Nodes"
#SBATCH --cpus-per-task=64
#SBATCH --ntasks-per-node=1
#SBATCH --gres=gpu:8
#SBATCH --wait-all-nodes=1
#SBATCH --exclusive
#SBATCH --output /hpc2hdd/home/qxiao183/SLM/HF/Slurm_Logs/%j.out.log
#SBATCH --error /hpc2hdd/home/qxiao183/SLM/HF/Slurm_Logs/%j.err.log

M_NODE=$(scontrol show hostnames $SLURM_JOB_NODELIST | head -n 1)
M_ADDR=$(scontrol show node=$M_NODE | grep NodeAddr | awk -F' ' '{print $1}' | awk -F'=' '{print $2}')
M_PORT=12345

echo "SLURMD_NODENAME=$SLURMD_NODENAME"

source /hpc2hdd/home/qxiao183/SLM/env.sh
export NODE=$SLURM_NNODES
export ADDR=$M_ADDR
export PORT=$M_PORT

echo "NODE=$SLURM_NNODES"
echo "ADDR=$M_ADDR"
echo "PORT=$M_PORT"

srun bash train.sh 8