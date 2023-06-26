# For the latest tag, see: https://hub.docker.com/r/jupyter/datascience-notebook/tags/
FROM jupyter/datascience-notebook:f2889d7ae7d6

# GPU powered ML
# ----------------------------------------
RUN conda install -c conda-forge --yes --quiet \
    tensorflow \
    cudatoolkit=10.1 && \
    conda clean -tipsy 
# fix-permissions $CONDA_DIR && \
# fix-permissions /home/$NB_USER

# Allow drivers installed by the nvidia-driver-installer to be located
ENV LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/local/nvidia/lib64
# Also, utilities like `nvidia-smi` are installed here
ENV PATH=${PATH}:/usr/local/nvidia/bin