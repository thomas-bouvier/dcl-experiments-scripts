# dcl-experiments-scripts

## Grid'5000

### Installation



### Artifacts

#### Application

On the g5k frontend, place your application in `dcl-experiments-scripts/artifacts/app`

Alternatively, you can simlimk the folder containing your app:

```console
ln -s /home/tbouvier/src/distributed-continual-learning/ /home/tbouvier/src/dcl-experiments-scripts/artifacts/app/distributed-continual-learning
```

In this repository, we use [distributed-continual-learning](https://gitlab.inria.fr/Kerdata/Kerdata-Codes/distributed-continual-learning).

#### Datasets

Place the following datasets in `/srv/storage/kerdatadatasets@storage1.lyon.grid5000.fr/datasets` (adapt to your Group Storage):

- `datasets/CIFAR10`
- `datasets/MNIST`
- `datasets/CANDLE`
- `datasets/ImageNet100`
- `datasets/ImageNet_blurred`

Simlink the Group Storage `datasets` folder to `artifacts/datasets`:

```console
cd dcl-experiments-e2clab
ln -s /srv/storage/kerdatadatasets@storage1.lyon.grid5000.fr/datasets/ artifacts/datasets
```

### Deployment

The E2Clab docs can be found here https://e2clab.gitlabpages.inria.fr/e2clab/index.html.

```console
cd e2clab
virtualenv -p python3 venv
source venv/bin/activate
pip install -U -e .

e2clab deploy src/dcl-experiments-scripts/e2clab/gemini/8 --app_conf=base src/dcl-experiments-scripts/artifacts/
```

Don't forget to install the `Horovod` service for E2Clab using [User-Defined-Services](https://gitlab.inria.fr/E2Clab/user-defined-services).

<!--
### Bare-metal

In the `layers_services.yaml` of the experiment to run, fill the required attributes:

- `docker: False`
- `g5k_pass: <pass>`
- `g5k_job_id: <id>`

The `g5k_pass` and `g5k_job_id` are needed to mount a group storage from a deployed node. The group storage should contain a Spack installation.
-->

### Deployment with Docker (not advised)

In the `layers_services.yaml` of the experiment to run, fill the required attributes:

- `docker: True`
- `registry_url: registry.gitlab.inria.fr`
- `registry_username: <username>`
- `registry_password: <pass>`
- `image: registry.gitlab.inria.fr/kerdata/kerdata-codes/horovod-images:0.26.1-spack`
- `gpu: True`

An image containing Horovod + PyTorch is required to deploy the application. If you have access to the Inria Gitlab, such an image is available at `registry.gitlab.inria.fr/kerdata/kerdata-codes/horovod-images:0.26.1-spack`. This container registry is protected by an access token, to be given in `layers_services.yml` files:

```console
cd dcl-experiments-scripts
find . \( -type d -name .git -prune \) -o -type f -name "layers_services.yaml" -print0 | xargs -0 sed -i 's/registry_password: ""/registry_password: "<token>"/g'
```

### Monitoring

#### Weights & Biases

```console
cd dcl-experiments-scripts

# If using bare-metal deployment
find . \( -type d -name .git -prune \) -o -type f -name "z20_wandb_environment.sh" -print0 | xargs -0 sed -i 's/WANDB_MODE=offline;/WANDB_MODE=run;/g'
find . \( -type d -name .git -prune \) -o -type f -name "z20_wandb_environment.sh" -print0 | xargs -0 sed -i 's/WANDB_API_KEY=;/WANDB_API_KEY=<token>;/g'

# If using Docker deployment
find . \( -type d -name .git -prune \) -o -type f -name "layers_services.yaml" -print0 | xargs -0 sed -i 's/wandb_mode: "offline"/wandb_mode: "run"/g'
find . \( -type d -name .git -prune \) -o -type f -name "layers_services.yaml" -print0 | xargs -0 sed -i 's/wandb_api_key: ""/wandb_api_key: "<token>"/g'
```

#### Grafana

To monitor system metrics (including GPU metrics) in real-time:

```console
ssh -NL 3000:127.0.0.1:3000 chetemi-9.lille.grid5000.fr
```

Open `localhost:3000` in your browser.

Some useful Grafana dashboards are hosted at https://gitlab.inria.fr/Kerdata/Kerdata-Codes/grafana-gpu-dashboard.

#### TensorBoard

To monitor deep learning training metrics in real-time in TensorBoard:

```console
ssh -NL 6006:127.0.0.1:6006 chifflot-2.lille.grid5000.fr
```

Open `localhost:6006` in your browser.

## ThetaGPU

Read the ALCF guide [here](https://docs.alcf.anl.gov/theta-gpu/queueing-and-running-jobs/job-and-queue-scheduling/).