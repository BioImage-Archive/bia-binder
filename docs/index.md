<!-- # Welcome to MkDocs

For full documentation visit [mkdocs.org](https://www.mkdocs.org).

## Commands

* `mkdocs new [dir-name]` - Create a new project.
* `mkdocs serve` - Start the live-reloading docs server.
* `mkdocs build` - Build the documentation site.
* `mkdocs -h` - Print help message and exit.

## Project layout

    mkdocs.yml    # The configuration file.
    docs/
        index.md  # The documentation homepage.
        ...       # Other markdown pages, images and other files. -->

<!-- ## Quick start -->
<!-- 
|   |   | |
|---:|:---|:---|
| [![Binder](https://binder.bioimagearchive.org/badge_logo.svg)](https://binder.bioimagearchive.org/v2/gh/ctr26/bia-binder-rclone/HEAD) | Mounting Biostudies using rclone |  github.com/ctr26/bia-binder-rclone
| [![Binder](https://binder.bioimagearchive.org/badge_logo.svg)](https://binder.bioimagearchive.org/v2/gh/EBIBioStudies/biostudies-notebooks/HEAD) | Reading Biostudies images | github.com/EBIBioStudies/biostudies-notebooks |
|  [![Binder](https://binder.bioimagearchive.org/badge_logo.svg)](https://gpu.binder.bioimagearchive.org/v2/gh/HenriquesLab/ZeroCostDL4Mic/master?urlpath=lab/tree/ipynb)| Running ZeroCostDL4Mic | github.com/HenriquesLab/ZeroCostDL4Mic |
| [![Binder](https://binder.bioimagearchive.org/badge_logo.svg)](https://gpu.binder.bioimagearchive.org/v2/gh/HenriquesLab/ZeroCostDL4Mic/master?urlpath=lab/tree/ipynb)| ↳ with a specific notebook | 
| [![Binder](https://binder.bioimagearchive.org/badge_logo.svg)](https://binder.bioimagearchive.org/v2/gh/IDR/idr0079-hartmann-lateralline/HEAD) | Some IDR studies are availiable | github.com/IDR/idr0079-hartmann-lateralline |


|   |   | |
|---:|:---|:---|
| [![Binder](https://binder.bioimagearchive.org/badge_logo.svg)](https://binder.bioimagearchive.org/v2/gh/ctr26/bia-binder-rclone/HEAD) | Mounting Biostudies using rclone |  github.com/ctr26/bia-binder-rclone
| [![Binder](https://binder.bioimagearchive.org/badge_logo.svg)](https://binder.bioimagearchive.org/v2/gh/EBIBioStudies/biostudies-notebooks/HEAD) | Reading Biostudies images | github.com/EBIBioStudies/biostudies-notebooks |
|  [![Binder](https://binder.bioimagearchive.org/badge_logo.svg)](https://gpu.binder.bioimagearchive.org/v2/gh/HenriquesLab/ZeroCostDL4Mic/master?urlpath=lab/tree/ipynb)| Running ZeroCostDL4Mic | github.com/HenriquesLab/ZeroCostDL4Mic |
| [![Binder](https://binder.bioimagearchive.org/badge_logo.svg)](https://gpu.binder.bioimagearchive.org/v2/gh/HenriquesLab/ZeroCostDL4Mic/master?urlpath=lab/tree/ipynb)| ↳ with a specific notebook | 
| [![Binder](https://binder.bioimagearchive.org/badge_logo.svg)](https://binder.bioimagearchive.org/v2/gh/IDR/idr0079-hartmann-lateralline/HEAD) | Some IDR studies are availiable | github.com/IDR/idr0079-hartmann-lateralline |

| | | |
|-|-|-|
|  | > "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."_ | |
|
 -->

## BioImageArchive BinderHub


BinderHub allows users to share reproducible interactive computing environments from code repositories. 

## Quick start


> [![Binder](https://binder.bioimagearchive.org/badge_logo.svg)](https://binder.bioimagearchive.org/v2/gh/ctr26/bia-binder-rclone/HEAD) &emsp; Mounting Biostudies using rclone
>
> [![Binder](https://binder.bioimagearchive.org/badge_logo.svg)](https://binder.bioimagearchive.org/v2/gh/EBIBioStudies/biostudies-notebooks/HEAD) &emsp; Reading Biostudies images
>
>  [![Binder](https://binder.bioimagearchive.org/badge_logo.svg)](https://gpu.binder.bioimagearchive.org/v2/gh/HenriquesLab/ZeroCostDL4Mic/master?urlpath=lab/tree/ipynb) &emsp; Running ZeroCostDL4Mic
>
> [![Binder](https://binder.bioimagearchive.org/badge_logo.svg)](https://gpu.binder.bioimagearchive.org/v2/gh/HenriquesLab/ZeroCostDL4Mic/master?urlpath=lab/tree/ipynb) &emsp; ↳ with a specific notebook
>
> [![Binder](https://binder.bioimagearchive.org/badge_logo.svg)](https://binder.bioimagearchive.org/v2/gh/IDR/idr0079-hartmann-lateralline/HEAD) &emsp; Some [IDR](https://idr.openmicroscopy.org/) studies are availiable
>
> [![Binder](https://binder.bioimagearchive.org/badge_logo.svg)](https://binder.bioimagearchive.org/v2/gh/ctr26/basic-gpu-binder/HEAD) &emsp; Binder for machine learning using GPUs

## Services and capabilities

| Tier |URL|Flavour|Resources|
|:----:|:----:|:----:|:----:|
|   1  | [binder.bioimagearchive.org](binder.bioimagearchive.org)| Public Binderhub | 8Gb RAM, 4 vCPUs, Ephemeral|
|   2  | [login.binder.bioimagearchive.org](login.binder.bioimagearchive.org)| Persistent Binderhub | <16Gb RAM, <8 vCPUs, 15 GB Storage, Dask|
|   2  | [gpu.beta.binder.bioimagearchive.org](gpu.beta.binder.bioimagearchive.org)| Authenticated Binderhub | <32Gb RAM, <8 vCPUs, (1-2) GPUs, Ephemeral, Dask|
|   3  | [kubeflow.binder.bioimagearchive.org](kubeflow.binder.bioimagearchive.org)| Authenticated Kubeflow   | n x (<32Gb RAM, <8 vCPUs), 15 GB Storage, (1-2) GPUs, Dask |
<!-- |   1  | binder.bioimagearchive.org/sandbox     | Public Jupyterhub        | 8Gb RAM, 4 vCPUs                                           | -->
<!-- |   2  | beta.binder.bioimagearchive.org/github | Authenticated Jupyterhub | <32Gb RAM, <8 vCPUs, 15 GB Storage, (1-2) GPUs, Dask       | -->

### To request access to Tier 2/3, please contact [bioimagearchive@ebi.ac.uk](mailto:bioimagearchive@ebi.ac.uk)


<!-- - [![Binder](https://binder.bioimagearchive.org/badge_logo.svg)](https://binder.bioimagearchive.org/v2/gh/ctr26/bia-binder-rclone/HEAD) Mounting Biostudies using rclone

- [![Binder](https://binder.bioimagearchive.org/badge_logo.svg)](https://binder.bioimagearchive.org/v2/gh/EBIBioStudies/biostudies-notebooks/HEAD) Reading Biostudies images

- [![Binder](https://binder.bioimagearchive.org/badge_logo.svg)](https://gpu.binder.bioimagearchive.org/v2/gh/HenriquesLab/ZeroCostDL4Mic/master?urlpath=lab/tree/ipynb) Running ZeroCostDL4Mic

- [![Binder](https://binder.bioimagearchive.org/badge_logo.svg)](https://gpu.binder.bioimagearchive.org/v2/gh/HenriquesLab/ZeroCostDL4Mic/master?urlpath=lab/tree/ipynb) ↳ with a specific notebook

- [![Binder](https://binder.bioimagearchive.org/badge_logo.svg)](https://binder.bioimagearchive.org/v2/gh/IDR/idr0079-hartmann-lateralline/HEAD) Some IDR studies are availiable 
 -->
