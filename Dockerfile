FROM continuumio/miniconda3
LABEL maintainer="Amirhossein N. Nilchi <nilchia@informatik.uni-freiburg.de>"

RUN \
    # Fetch additional libraries
    apt-get update -y && apt-get install -y cpio libcairo2-dev libharfbuzz-dev \
    libfribidi-dev libfreetype6-dev libpng-dev libtiff5-dev libjpeg-dev \
    # Clean cache
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/nilchia/cellxgene_VIP.git && \
    cd cellxgene_VIP && \
    # Fetch the commit that adds nilchia's cellxgene repo
    git checkout 7bc80bc8127166e7ba69bb05dfb257a5a8a0ed9c  # fix anndata compatibility and fixed plot error

# Move into cellxgene_VIP directory
WORKDIR cellxgene_VIP

# Switch to bash terminal to run "conda" commands
SHELL ["/bin/bash", "-c"]

# Must be set before config.sh builds the R packages
ENV LIBARROW_MINIMAL=false

RUN source /opt/conda/etc/profile.d/conda.sh && \
    conda config --set channel_priority flexible && \
    # Create and activate conda envirnment
    conda env create -n VIP --file VIP_conda_R.yml && \
    conda clean -afy && \
    conda activate VIP && \
    # Install VIP plugin
    ./config.sh && \
    conda install -y -c conda-forge -c bioconda galaxy-ie-helpers && \
    # Remove unused packages
    conda clean -afy

ENV PATH=/opt/conda/envs/VIP/bin:$PATH
ENV CONDA_DEFAULT_ENV=VIP
