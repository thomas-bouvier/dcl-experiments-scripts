# dcl-experiments-e2clab

## Artifacts

### Application

On the g5k frontend, place your application in `dcl-experiments-e2clab/artifacts/app`

Alternatively, you can simlimk the folder containing your app:

```
cd dcl-experiments-e2clab
ln -s ~/src/distributed-deep-learning/ artifacts/app/distributed-deep-learning
```

### Datasets

On the g5k frontend, place the following datasets in `dcl-experiments-e2clab/datasets`:

- `dcl-experiments-e2clab/artifacts/datasets/CIFAR10`
- `dcl-experiments-e2clab/artifacts/datasets/MNIST`
- `dcl-experiments-e2clab/artifacts/datasets/CANDLE`

Simlink the `datasets` folder:

```
cd dcl-experiments-e2clab
ln -s ~/datasets/ artifacts/datasets
```

## Deployment

### Images

An image containing Horovod + PyTorch is required to deploy the application.

If you have access to the Inria Gitlab, an image containing Horovod 0.23.0 + PyTorch 1.9 is available at `registry.gitlab.inria.fr/kerdata/kerdata-codes/horovod-images:0.23.0-gpu`. This container registry is protected by an access token, to be given in `layers_services.yml` files:

```
cd dcl-experiments-e2clab
find . \( -type d -name .git -prune \) -o -type f -print0 | xargs -0 sed -i 's/registry_password: ""/registry_password: "<token>"/g'

```

### E2Clab

The E2Clab docs can be found here https://e2clab.gitlabpages.inria.fr/e2clab/index.html.

```
cd e2clab
virtualenv -p python3 venv
source venv/bin/activate
pip install -U -e .
e2clab deploy ...
```

## Monitoring

### Grafana

To monitor system metrics (including GPU metrics) in real-time:

```
ssh -NL 3000:127.0.0.1:3000 chetemi-9.lille.grid5000.fr
```

Open `localhost:3000` in your browser.

Some useful Grafana dashboards are hosted at https://gitlab.inria.fr/Kerdata/Kerdata-Codes/grafana-gpu-dashboard.

### TensorBoard

To monitor deep learning training metrics in real-time in TensorBoard:

```
ssh -NL 6006:127.0.0.1:6006 chifflot-2.lille.grid5000.fr
```

Open `localhost:6006` in your browser.
### TensorWatch

To monitor deep learning training metrics in real-time in a Jupyter notebook:

```
ssh -NL 41459:chifflot-2.lille.grid5000.fr:41459 access.grid5000.fr
```

Open a notebook and connect to TensorWatch:

```python
%matplotlib notebook
import tensorwatch as tw
client = tw.WatcherClient(port=0)

# Plot training loss
s0 = client.open_stream(name='train_loss')
v0 = tw.Visualizer(stream=s0)
v0.show()
```

TensorWatch is using PyZMQ to publish training data, default port is 41459.

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
