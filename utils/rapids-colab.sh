#!/bin/bash

set -eu

RAPIDS_VERSION="${1:-0.10}"
XGBOOST_VERSION="${2:-1.0.0_SNAPSHOT}"

wget -nc https://github.com/gumdropsteve/bsql-demos/raw/getting_started/utils/env-check.py
echo "Checking for GPU type:"
python env-check.py

if [ ! -f Miniconda3-4.5.4-Linux-x86_64.sh ]; then
    echo "Removing conflicting packages, will replace with RAPIDS compatible versions"
    # remove existing xgboost and dask installs
    pip uninstall -y xgboost dask distributed

    # intall miniconda
    echo "Installing conda"
    wget https://repo.continuum.io/miniconda/Miniconda3-4.5.4-Linux-x86_64.sh
    chmod +x Miniconda3-4.5.4-Linux-x86_64.sh
    bash ./Miniconda3-4.5.4-Linux-x86_64.sh -b -f -p /usr/local

    echo "Installing RAPIDS $RAPIDS_VERSION packages"
    echo "Please standby, this will take a few minutes..."
    # install RAPIDS packages
    conda install -y --prefix /usr/local \
      -c rapidsai-nightly/label/xgboost -c rapidsai-nightly -c nvidia -c conda-forge \
      python=3.6 cudatoolkit=10.0 \
      cudf=$RAPIDS_VERSION cuml cugraph gcsfs pynvml \
      dask-cudf

    pip install https://xgboost-ci.net/job/xgboost/job/master/lastSuccessfulBuild/artifact/python-package/dist/xgboost-$XGBOOST_VERSION-py2.py3-none-any.whl
      
    echo "Copying shared object files to /usr/lib"
    # copy .so files to /usr/lib, where Colab's Python looks for libs
    cp /usr/local/lib/libcudf.so /usr/lib/libcudf.so
    cp /usr/local/lib/librmm.so /usr/lib/librmm.so
    cp /usr/local/lib/libnccl.so /usr/lib/libnccl.so
fi

echo ""
echo "*********************************************"
echo "Your Google Colab instance is RAPIDS ready!"
echo "*********************************************"
