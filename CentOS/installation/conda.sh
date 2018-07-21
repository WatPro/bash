#!/bin/bash
 
CONDA_URL='https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh'
CONDA_FILE=${CONDA_URL##*/}

yum --assumeyes install bzip2

curl --remote-name "${CONDA_URL}" 
bash "$CONDA_FILE" -b
rm --force "${CONDA_FILE}"
 
#PATH="~/miniconda3/bin:$PATH"
#conda install --yes jupyter
 

