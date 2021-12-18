# ipdps-experiments-e2clab

## Datasets

On the g5k frontend, place the following datasets in `~/datasets`:

- `~/datasets/CIFAR10`
- `~/datasets/MNIST`
- `~/datasets/CANDLE`

Simlink the `datasets` folder from this `ipdps-experiments-e2clab` directory:

```
cd ipdps-experiments-e2clab
ln -s ~/datasets/ datasets
```

## Containers

An image containing Horovod + PyTorch is required to deploy the application.

If you have access to the Inria Gitlab, an image containing Horovod 0.23.0 + PyTorch 1.9 is available at `registry.gitlab.inria.fr/kerdata/kerdata-codes/ipdps-experiments-e2clab:0.23.0-gpu`. This container registry is protected by an access token, to be given in `layers_services.yml` files:

```
cd ipdps-experiments-e2clab
find . \( -type d -name .git -prune \) -o -type f -print0 | xargs -0 sed -i 's/registry_password: ""/registry_password: "<token>"/g'

```

## Deployments

### E2Clab

The E2Clab docs can be found here https://e2clab.gitlabpages.inria.fr/e2clab/index.html.

```
cd e2clab
virtualenv -p python3 venv
source venv/bin/activate
pip install -U -e .
e2clab deploy ...
```

### Grafana

To monitor what's happening on the cluster in real-time:

```
ssh -NL 3000:chetemi-9.lille.grid5000.fr:3000 access.grid5000.fr
```

Open `localhost:3000` in your browser.

Some useful Grafana dashboards are hosted at https://gitlab.inria.fr/Kerdata/Kerdata-Codes/grafana-gpu-dashboard.

## Experiments

### `cifar10-icarl-resnet34`

Relies on: https://gitlab.inria.fr/Kerdata/Kerdata-Codes/distributed-deep-learning

- Type: continual learning
- Distributed framework: Horovod
- Deep learning framework: PyTorch
- Dataset: CIFAR-10
- Model: iCaRL + ResNet-34

#### Default implementation

```
python main.py --agent icarl --model resnet --model-config "{'depth': 34}" --dataset cifar10 --tasksets-config "{'scenario': 'class', 'initial_increment': 4, 'increment': 3}"
```

#### Scratch baseline

```
python main.py --agent icarl --model resnet --model-config "{'depth': 34}" --dataset cifar10 --tasksets-config "{'scenario': 'class', 'initial_increment': 4, 'increment': 3, 'concatenate_tasksets': True}"
```

|   | `chifflot` | `drac` | `drac-noib` |
|---|---|---|---|
|  Experiments | `1`, `2`, `4`, `8`, or `12` Tesla P100, or `16` GPUs including 12 Tesla P100 and 4 Tesla V100 | `1`, `2`, `4`, `8`, `16`, `32` or `48` Tesla P100  | `1`, `2`, `4`, `8`, `16`, `32` or `48` Tesla P100 |

### `cifar10-icarl-resnet101`

Relies on: https://gitlab.inria.fr/Kerdata/Kerdata-Codes/distributed-deep-learning

- Type: continual learning
- Distributed framework: Horovod
- Deep learning framework: PyTorch
- Dataset: CIFAR-10
- Model: iCaRL + ResNet-101

#### Default implementation

```
python main.py --agent icarl --model resnet --model-config "{'depth': 101}" --dataset cifar10 --tasksets-config "{'scenario': 'class', 'initial_increment': 4, 'increment': 3}"
```

#### Scratch baseline

```
python main.py --agent icarl --model resnet --model-config "{'depth': 101}" --dataset cifar10 --tasksets-config "{'scenario': 'class', 'initial_increment': 4, 'increment': 3, 'concatenate_tasksets': True}"
```

|   | `chifflot` | `drac` | `drac-noib` |
|---|---|---|---|
|  Experiments | `1`, `2`, `4`, `8`, or `12` Tesla P100, or `16` GPUs including 12 Tesla P100 and 4 Tesla V100 | `1`, `2`, `4`, `8`, `16`, `32` or `48` Tesla P100  | `1`, `2`, `4`, `8`, `16`, `32` or `48` Tesla P100 |

### `cifar10-icarl-resnet152`

Relies on: https://gitlab.inria.fr/Kerdata/Kerdata-Codes/distributed-deep-learning

- Type: continual learning
- Distributed framework: Horovod
- Deep learning framework: PyTorch
- Dataset: CIFAR-10
- Model: iCaRL + ResNet-152

#### Default implementation

```
python main.py --agent icarl --model resnet --model-config "{'depth': 152}" --dataset cifar10 --tasksets-config "{'scenario': 'class', 'initial_increment': 4, 'increment': 3}"
```

#### Scratch baseline

```
python main.py --agent icarl --model resnet --model-config "{'depth': 152}" --dataset cifar10 --tasksets-config "{'scenario': 'class', 'initial_increment': 4, 'increment': 3, 'concatenate_tasksets': True}"
```


|   | `chifflot` | `drac` | `drac-noib` |
|---|---|---|---|
|  Experiments | `1`, `2`, `4`, `8`, or `12` Tesla P100, or `16` GPUs including 12 Tesla P100 and 4 Tesla V100 | `1`, `2`, `4`, `8`, `16`, `32` or `48` Tesla P100  | `1`, `2`, `4`, `8`, `16`, `32` or `48` Tesla P100 |

### `cifar10-nil-resnet34`

Relies on: https://gitlab.inria.fr/Kerdata/Kerdata-Codes/distributed-deep-learning

- Type: continual learning
- Distributed framework: Horovod
- Deep learning framework: PyTorch
- Dataset: CIFAR-10
- Model: NIL + ResNet-34

#### Default implementation

```
python main.py --agent nil --model resnet --model-config "{'depth': 34}" --dataset cifar10 --tasksets-config "{'scenario': 'class', 'initial_increment': 4, 'increment': 3}"
```

#### Scratch baseline

```
python main.py --agent nil --model resnet --model-config "{'depth': 34}" --dataset cifar10 --tasksets-config "{'scenario': 'class', 'initial_increment': 4, 'increment': 3, 'concatenate_tasksets': True}"
```


|   | `chifflot` | `drac` | `drac-noib` |
|---|---|---|---|
|  Experiments | `1`, `2`, `4`, `8`, or `12` Tesla P100, or `16` GPUs including 12 Tesla P100 and 4 Tesla V100 | `1`, `2`, `4`, `8`, `16`, `32` or `48` Tesla P100  | `1`, `2`, `4`, `8`, `16`, `32` or `48` Tesla P100 |

### `cifar10-nil-resnet101`

Relies on: https://gitlab.inria.fr/Kerdata/Kerdata-Codes/distributed-deep-learning

- Type: continual learning
- Distributed framework: Horovod
- Deep learning framework: PyTorch
- Dataset: CIFAR-10
- Model: NIL + ResNet-101

#### Default implementation

```
python main.py --agent nil --model resnet --model-config "{'depth': 101}" --dataset cifar10 --tasksets-config "{'scenario': 'class', 'initial_increment': 4, 'increment': 3}"
```

#### Scratch baseline

```
python main.py --agent nil --model resnet --model-config "{'depth': 101}" --dataset cifar10 --tasksets-config "{'scenario': 'class', 'initial_increment': 4, 'increment': 3, 'concatenate_tasksets': True}"
```

|   | `chifflot` | `drac` | `drac-noib` |
|---|---|---|---|
|  Experiments | `1`, `2`, `4`, `8`, or `12` Tesla P100, or `16` GPUs including 12 Tesla P100 and 4 Tesla V100 | `1`, `2`, `4`, `8`, `16`, `32` or `48` Tesla P100  | `1`, `2`, `4`, `8`, `16`, `32` or `48` Tesla P100 |

### `cifar10-nil-resnet152`

Relies on: https://gitlab.inria.fr/Kerdata/Kerdata-Codes/distributed-deep-learning

- Type: continual learning
- Distributed framework: Horovod
- Deep learning framework: PyTorch
- Dataset: CIFAR-10
- Model: NIL + ResNet-152

#### Default implementation

```
python main.py --agent nil --model resnet --model-config "{'depth': 152}" --dataset cifar10 --tasksets-config "{'scenario': 'class', 'initial_increment': 4, 'increment': 3}"
```

#### Scratch baseline

```
python main.py --agent nil --model resnet --model-config "{'depth': 152}" --dataset cifar10 --tasksets-config "{'scenario': 'class', 'initial_increment': 4, 'increment': 3, 'concatenate_tasksets': True}"
```

|   | `chifflot` | `drac` | `drac-noib` |
|---|---|---|---|
|  Experiments | `1`, `2`, `4`, `8`, or `12` Tesla P100, or `16` GPUs including 12 Tesla P100 and 4 Tesla V100 | `1`, `2`, `4`, `8`, `16`, `32` or `48` Tesla P100  | `1`, `2`, `4`, `8`, `16`, `32` or `48` Tesla P100 |

### `mnist-icarl-mnistnet`

Relies on: https://gitlab.inria.fr/Kerdata/Kerdata-Codes/distributed-deep-learning

- Type: continual learning
- Distributed framework: Horovod
- Deep learning framework: PyTorch
- Dataset: MNIST
- Model: iCaRL + MNISTNet

#### Default implementation

```
python main.py --agent icarl --model mnistnet --dataset mnist --tasksets-config "{'scenario': 'class', 'initial_increment': 4, 'increment': 3}"
```

#### Scratch baseline

```
python main.py --agent icarl --model mnistnet --dataset mnist --tasksets-config "{'scenario': 'class', 'initial_increment': 4, 'increment': 3, 'concatenate_tasksets': True}"
```

|   | `chifflot` | `drac` | `drac-noib` |
|---|---|---|---|
|  Experiments | `1`, `2`, `4`, `8`, or `12` Tesla P100, or `16` GPUs including 12 Tesla P100 and 4 Tesla V100 | `1`, `2`, `4`, `8`, `16`, `32` or `48` Tesla P100  | `1`, `2`, `4`, `8`, `16`, `32` or `48` Tesla P100 |

### `mnist-nil-mnistnet`

Relies on: https://gitlab.inria.fr/Kerdata/Kerdata-Codes/distributed-deep-learning

- Type: continual learning
- Distributed framework: Horovod
- Deep learning framework: PyTorch
- Dataset: MNIST
- Model: NIL + MNISTNet

#### Default implementation

```
python main.py --agent nil --model mnistnet --dataset mnist --tasksets-config "{'scenario': 'class', 'initial_increment': 4, 'increment': 3}"
```

#### Scratch baseline

```
python main.py --agent nil --model mnistnet --dataset mnist --tasksets-config "{'scenario': 'class', 'initial_increment': 4, 'increment': 3, 'concatenate_tasksets': True}"
```

|   | `chifflot` | `drac` | `drac-noib` |
|---|---|---|---|
|  Experiments | `1`, `2`, `4`, `8`, or `12` Tesla P100, or `16` GPUs including 12 Tesla P100 and 4 Tesla V100 | `1`, `2`, `4`, `8`, `16`, `32` or `48` Tesla P100  | `1`, `2`, `4`, `8`, `16`, `32` or `48` Tesla P100 |

### `candle-nil-candlenet`

Relies on: https://gitlab.inria.fr/Kerdata/Kerdata-Codes/distributed-deep-learning

- Type: continual learning
- Distributed framework: Horovod
- Deep learning framework: PyTorch
- Dataset: CANDLE
- Model: NIL + CANDLENet

#### Default implementation

```
python main.py --agent nil --model candlenet --dataset candle --tasksets-config "{'scenario': 'class', 'initial_increment': 4, 'increment': 3}"
```

#### Scratch baseline

```
python main.py --agent nil --model candlenet --dataset candle --tasksets-config "{'scenario': 'class', 'initial_increment': 4, 'increment': 3, 'concatenate_tasksets': True}"
```

|   | `chifflot` | `drac` | `drac-noib` |
|---|---|---|---|
|  Experiments | `1`, `2`, `4`, `8`, or `12` Tesla P100, or `16` GPUs including 12 Tesla P100 and 4 Tesla V100 | `1`, `2`, `4`, `8`, `16`, `32` or `48` Tesla P100  | `1`, `2`, `4`, `8`, `16`, `32` or `48` Tesla P100 |

## Results

### InfluxDB

When an experiment finalizes, many metrics are backed up.
