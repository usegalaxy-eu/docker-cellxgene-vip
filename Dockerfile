FROM continuumio/miniconda3
LABEL maintainer="Amirhossein N. Nilchi <nilchia@informatik.uni-freiburg.de>"

RUN \
    # Fetch additional libraries
    apt-get update -y && apt-get install -y cpio libcairo2-dev libharfbuzz-dev libfribidi-dev libfreetype6-dev libpng-dev libtiff5-dev libjpeg-dev \ 
    # Clean cache
    && apt-get clean

RUN git clone https://github.com/bobermayer/cellxgene_vip.git

# Move into cellxgene_VIP directory
WORKDIR cellxgene_vip

# Switch to bash terminal to run "conda" commands
SHELL ["/bin/bash", "-c"]

RUN source /opt/conda/etc/profile.d/conda.sh && \
    conda config --set channel_priority flexible && \
    # Create and activate conda envirnment
    conda env create -n VIP --file VIP_conda_R.yml && \
    conda clean -afy && \
    conda activate VIP && \
    # Install VIP plugin
    ./config.sh && \
    export LIBARROW_MINIMAL=false && \
    # Remove unused packages
    conda clean -afy

ENV PATH /opt/conda/envs/VIP/bin:$PATH
ENV CONDA_DEFAULT_ENV VIP
