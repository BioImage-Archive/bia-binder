# User Guide
## Services and capabilities

| Tier |                   URL                  |          Flavour         |                          Resources                         |
|:----:|:--------------------------------------:|:------------------------:|:----------------------------------------------------------:|
|   1  | binder.bioimagearchive.org             | Public Binderhub         | 8Gb RAM, 4 vCPUs                                           |
|   1  | binder.bioimagearchive.org/sandbox     | Public Jupyterhub        | 8Gb RAM, 4 vCPUs                                           |
|   2  | binder.bioimagearchive.org/github      | Authenticated Jupyterhub | <16Gb RAM, <8 vCPUs, 15 GB Storage, Dask                   |
|   2  | gpu.beta.binder.bioimagearchive.org    | Authenticated Jupyterhub | <32Gb RAM, <8 vCPUs, (1-2) GPUs, Dask                      |
|   2  | beta.binder.bioimagearchive.org/github | Authenticated Jupyterhub | <32Gb RAM, <8 vCPUs, 15 GB Storage, (1-2) GPUs, Dask       |
|   3  | kubeflow.binder.bioimagearchive.org    | Authenticated Kubeflow   | n x (<32Gb RAM, <8 vCPUs), 15 GB Storage, (1-2) GPUs, Dask |

## Cluster(s) structure

Currently there are two Kubernetes clusters jointly (but not very intelligently) hosting the listed services on Embassy Cloud.
The CPU only cluster is limited to deploying Jupyter sessions (Kubernetes Pods) with a maximum of 8G of RAM and 4 vCPUs, however this can be scaled horizontally to meet demand.
The private-Beta cluster overall has 128Gb of RAM and 4 GPUs and 44 vCPUs, once out of private-Beta the availiable resources will increase but due to the special nature of requiring GPUs this cluster cannot currently scale to demand.
Compute is therefore shared of a first-come-first serve basis.

## BinderHub

Binderhub generates workable Jupyter environments for code and data exploration from online repositories. 
We provide a service similar to that of myBinder except with more resource provision in both the public and private Beta releases; in all deployments fast direct read-only access is provided to BioStudies and fast in-direct access is provided to the IDR.

Examples binders:

```https://binder.bioimagearchive.org/v2/gh/EBIBioStudies/biostudies-notebooks/HEAD```

```https://binder.bioimagearchive.org/v2/gh/ome/omero-guide-python/HEAD```


## JupyterHub

The authenticated JupyterHubs at ```beta.binder.bioimagearchive/github``` and ```binder.bioimagearchive/github``` both provide semi-permanent storage for installing libraries and packages as well as a generous scratch space for dumping intermediate data.
Each JupyterHub profile comes pre-installed with example notebooks for image analysis as well as Rclone for mounting external data resources such FTP drives and cloud storage drives.


## KubeFlow

# GPU Support

The BIA-Binder currently deploys the *450 nvidia driver* to all pods 

```gpu.beta.binder.org``` and on ```beta.binder.org/github``` for users who use GPU supported profiles.
In the case of ```gpu.beta.binder.org``` however users must be careful to ensure that *repo2docker* builds with the correct environment to support the *450 driver* else certain libraries (like TensorFlow and PyTorch) will not interact with the alloted GPU capabilities.
This (currently) is only viable using a Dockerfile within a repository, the following example works with tensorflow 1.x for instance installing a local requirements file too:


```
FROM tensorflow/tensorflow:1.15.5-gpu-jupyter
# FROM tensorflow/tensorflow:latest-gpu-jupyter
# --- Jupyter

# install the notebook package
RUN pip install --no-cache --upgrade pip && \
    pip install --no-cache notebook

# create user with a home directory
ARG NB_USER
ARG NB_UID
ENV USER ${NB_USER}
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}
WORKDIR ${HOME}
USER ${USER}

# RUN conda install pip --yes

COPY . .

RUN pip install --no-cache-dir -r requirements.txt
```

This Dockerfile builds from a base python environment installing the necessary CUDA drivers and Jupyter Environment

```
FROM python:3.7-slim

# --- Cuda
RUN apt-get update && apt-get install -y --no-install-recommends \
    gnupg2 curl ca-certificates && \
    curl -fsSL https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub | apt-key add - && \
    echo "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64 /" > /etc/apt/sources.list.d/cuda.list && \
    echo "deb https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64 /" > /etc/apt/sources.list.d/nvidia-ml.list && \
    apt-get purge --autoremove -y curl \
    && rm -rf /var/lib/apt/lists/*

ENV CUDA_VERSION 10.2.89
ENV CUDA_PKG_VERSION 10-2=$CUDA_VERSION-1

# For libraries in the cuda-compat-* package: https://docs.nvidia.com/cuda/eula/index.html#attachment-a
RUN apt-get update && apt-get install -y --no-install-recommends \
    cuda-cudart-$CUDA_PKG_VERSION \
    cuda-compat-10-2 \
    && ln -s cuda-10.2 /usr/local/cuda && \
    rm -rf /var/lib/apt/lists/*

# Required for nvidia-docker v1
RUN echo "/usr/local/nvidia/lib" >> /etc/ld.so.conf.d/nvidia.conf && \
    echo "/usr/local/nvidia/lib64" >> /etc/ld.so.conf.d/nvidia.conf

ENV PATH /usr/local/nvidia/bin:/usr/local/cuda/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility
ENV NVIDIA_REQUIRE_CUDA "cuda>=10.2 brand=tesla,driver>=396,driver<397 brand=tesla,driver>=410,driver<411 brand=tesla,driver>=418,driver<419 brand=tesla,driver>=440,driver<441"


# --- Jupyter

# install the notebook package
RUN pip install --no-cache --upgrade pip && \
    pip install --no-cache notebook

# create user with a home directory
ARG NB_USER
ARG NB_UID
ENV USER ${NB_USER}
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}
WORKDIR ${HOME}
USER ${USER}

# RUN conda install pip --yes

COPY . .

RUN pip install --no-cache-dir -r requirements.txt
```