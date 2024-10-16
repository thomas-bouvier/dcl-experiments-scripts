#!/bin/bash -l

# Check if PMI_LOCAL_RANK is set
if [[ -z "${PMI_LOCAL_RANK}" ]]; then
    echo "PMI_LOCAL_RANK is not set. Exiting..."
    exit 1
fi

num_gpus=$(nvidia-smi -L | wc -l)
gpu=$((${PMI_LOCAL_RANK} % ${num_gpus}))

gpus=""
for i in $(seq 0 $(($num_gpus-1))); do
  gpus="$gpus$i,"
done

export CUDA_VISIBLE_DEVICES=${gpus%?}
echo “RANK=${PMI_RANK} LOCAL_RANK=${PMI_LOCAL_RANK}”

exec "$@"
