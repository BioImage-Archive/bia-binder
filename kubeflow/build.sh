# Add kfctl to PATH, to make the kfctl binary easier to use.
# Use only alphanumeric characters or - in the directory name.
export PATH=$PATH:"<path-to-kfctl>"

# Set the following kfctl configuration file:
export CONFIG_URI="https://raw.githubusercontent.com/kubeflow/manifests/v1.2-branch/kfdef/kfctl_istio_dex.v1.2.0.yaml"

# Set KF_NAME to the name of your Kubeflow deployment. You also use this
# value as directory name when creating your configuration directory.
# For example, your deployment name can be 'my-kubeflow' or 'kf-test'.
export KF_NAME="kubeflow"

# Set the path to the base directory where you want to store one or more 
# Kubeflow deployments. For example, /opt.
# Then set the Kubeflow application directory for this deployment.
export BASE_DIR="."
export KF_DIR=${BASE_DIR}/${KF_NAME}

mkdir -p ${KF_DIR}
cd ${KF_DIR}

# Download the config file and change the default login credentials.
wget -O kfctl_istio_dex.yaml $CONFIG_URI
export CONFIG_FILE=${KF_DIR}/kfctl_istio_dex.yaml

# Credentials for the default user are admin@kubeflow.org:12341234
# To change them, please edit the dex-auth application parameters
# inside the KfDef file.
# vim $CONFIG_FILE

kfctl apply -V -f kfctl_istio_dex.yaml

# kfctl build -V -f ${CONFIG_FILE}


# if echo "$answer" | grep -iq "^y" ;then
