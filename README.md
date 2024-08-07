# BIA Binder Deployment

This repository contains the materials for deploying the BIA Binder, including the codebase and relevant supplementary files. The repository is currently aimed at deploying to Embassy Cloud and has historically also worked with DeNBI Cloud.

## Usage

### Installation

1. **Clone the repository**:
    ```bash
    git clone https://github.com/yourusername/bia-binder.git
    cd bia-binder
    ```

2. **Install Helmsman**: Follow the instructions on the [Helmsman GitHub page](https://github.com/Praqma/helmsman) to install Helmsman on your system.

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
