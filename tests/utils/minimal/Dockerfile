# For the latest tag, see: https://hub.docker.com/r/jupyter/datascience-notebook/tags/
# FROM jupyter/datascience-notebook:f2889d7ae7d6
# FROM nvidia/cuda:10.1-base-ubuntu18.04
FROM latest-gpu-jupyter
docker tensorflow/tensorflow:latest-gpu-jupyter


# # FROM python:3.7-slim
# # install the notebook package

# #### ---
# ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
# ENV PATH /opt/conda/bin:$PATH

# RUN apt-get update --fix-missing && apt-get install -y wget bzip2 ca-certificates \
#     libglib2.0-0 libxext6 libsm6 libxrender1 \
#     git mercurial subversion

# RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda2-4.5.11-Linux-x86_64.sh -O ~/miniconda.sh && \
#     /bin/bash ~/miniconda.sh -b -p /opt/conda && \
#     rm ~/miniconda.sh && \
#     ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
#     echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
#     echo "conda activate base" >> ~/.bashrc

# RUN apt-get install -y curl grep sed dpkg && \
#     TINI_VERSION=`curl https://github.com/krallin/tini/releases/latest | grep -o "/v.*\"" | sed 's:^..\(.*\).$:\1:'` && \
#     curl -L "https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini_${TINI_VERSION}.deb" > tini.deb && \
#     dpkg -i tini.deb && \
#     rm tini.deb && \
#     apt-get clean

# ENTRYPOINT [ "/usr/bin/tini", "--" ]
# CMD [ "/bin/bash" ]
# --- 
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
# GPU powered ML
# ----------------------------------------
# RUN conda install -c conda-forge --yes --quiet \
#     tensorflow-gpu \
#     cudatoolkit=9.0 && \
#     conda clean -tipsy

# # Allow drivers installed by the nvidia-driver-installer to be located
# ENV LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/local/nvidia/lib64
# # Also, utilities like `nvidia-smi` are installed here
# ENV PATH=${PATH}:/usr/local/nvidia/bin
