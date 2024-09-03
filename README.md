# Relevant Links and Notebooks

- **IDR Screen Data**: [IDR Screen 2451](https://idr.openmicroscopy.org/webclient/?show=screen-2451)
- **IC50 Notebook for SARS-CoV-2 Data**: [![Binder](https://binder.bioimagearchive.org/badge_logo.svg)](https://binder.bioimagearchive.org/v2/gh/IDR/idr0094-ellinger-sarscov2/master?urlpath=notebooks%2Fnotebooks%2Fidr0094-ic50.ipynb%3FscreenId%3D2602)
- **S-BSST522 Image Gallery**: [EBI Image Gallery](https://www.ebi.ac.uk/bioimage-archive/galleries/S-BSST522.html)
- **BIA Explorer Visualisation Notebook**: [![Binder](https://binder.bioimagearchive.org/badge_logo.svg)](https://binder.bioimagearchive.org/v2/gh/BioImage-Archive/bia-explorer/HEAD?labpath=BIA-explorer-visualisation-notebook.ipynb)
- **BIA Explorer GitHub Repository**: [GitHub - BIA Explorer](https://github.com/BioImage-Archive/bia-explorer)
- **BIA Training Repository**: [GitHub - BIA Training](https://github.com/BioImage-Archive/bia-training)
- **BIA BMZ Integration**: [GitHub - BIA BMZ Integration](https://github.com/BioImage-Archive/bia-bmz-integration)
- **BioImage Archive Notebooks**: [GitHub - BioImage Archive Notebooks](https://github.com/BioImage-Archive/bioimagearchive_notebooks)


# BIA Binder Deployment

This repository contains the materials for deploying the BIA Binder, including the codebase and relevant supplementary files. The repository is currently aimed at deploying to Embassy Cloud and has historically also worked with DeNBI Cloud.

## Usage

### Installation

1. **Clone the repository**:
    ```bash
    git clone https://github.com/yourusername/bia-binder.git
    cd bia-binder
    ```

2. **Install the necessary tools**:
2.i **Install Helm**: Follow the instructions on the [Helm page](https://helm.sh/docs/intro/install/)
2.ii **Install Helmsman**: Follow the instructions on the [Helmsman GitHub page](https://github.com/Praqma/helmsman) to install Helmsman on your system.
2.iii *Install helm-diff* plugin: 

    helm plugin install https://github.com/databus23/helm-diff

### Deployment

To deploy the application to different environments, you can use the Makefile. The Makefile supports deployment to `prod`, `dev`, and `local` environments for different variants: `embassy`, `denbi`, and `minikube`.

1. **Deploy to production**:
    ```bash
    make embassy.prod
    make denbi.prod
    make minikube.prod
    ```

2. **Deploy to development**:
    ```bash
    make embassy.dev
    make denbi.dev
    make minikube.dev
    ```

3. **Deploy to local environment**:
    ```bash
    make embassy.local
    make denbi.local
    make minikube.local
    ```

4. **Generate htpassword file**:
    ```bash
    make htpassword
    ```

### Example `.env` File

Create a `.env` file in the root directory of the repository with the following structure:

```env
# Generic .env file example

# CI/CD Configuration
CI_REGISTRY_IMAGE="bioimagearchive/binder-"
CI_REGISTRY_URL="https://registry.binder.bioimagearchive.org"
HOST_NAME="binder.bioimagearchive.org"
KUBECONFIG="kube/embassy.config"
CI_REGISTRY_USER=ctr26
CI_REGISTRY_PASSWORD=4c16f763-****-****-****-80ec19d2f840

# Secret keys (values obfuscated for security)
SECRET_ELIXIR_CLIENTID=********-****-****-****-************
SECRET_ELIXIR_CLIENTSECRET=********-****-****-****-************
SECRET_HUB_PASSWORD=1e54cdb91f9c78d3f93a577b90567771ad076424ab24470192cc0776a3d45bd5
SECRET_JUPYTERHUB_PROXY_TOKEN=1e54cdb91f9c78d3f93a577b90567771ad076424ab24470192cc0776a3d45bd5
SECRET_BINDERHUB_SERVICE=569d94fdabd71bf88452db33782e4fa1881241764226e3038aedf6ec2cce1aa1
SECRET_GITHUBREPOPROVIDER=ghp_************-**********
SECRET_PROMETHEUS_AUTH_HTPASSWD=

# AAI Configuration
AAI_CLIENT_ID="cfac1c45-ab70-4596-b5b6-d1d92cf8ce3b"
AAI_CLIENT_SECRET="c064871e-****-****-****-f82b1ad6e2c6"
