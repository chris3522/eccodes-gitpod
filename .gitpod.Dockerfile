FROM gitpod/workspace-full

#USER gitpod

# Install custom tools, runtime, etc. using apt-get
# For example, the command below would install "bastet" - a command line tetris clone:
#
#RUN sudo apt-get -q update && \
#     sudo apt-get install -yq libjansson-dev libjson-c-dev libgrib2c-dev && \
#     sudo rm -rf /var/lib/apt/lists/*
#
# More information: https://www.gitpod.io/docs/config-docker/

#eccodes-2.20.0-Source.tar.gz
#gfortran
USER root
RUN apt-get -q update && \
     apt-get install -yq libboost-all-dev && \
     rm -rf /var/lib/apt/lists/*
ARG ECBUILD_VERSION=2.20.0
RUN cd /tmp && \
    wget -q https://confluence.ecmwf.int/download/attachments/45757960/eccodes-${ECBUILD_VERSION}-Source.tar.gz && \
    tar xzf eccodes-${ECBUILD_VERSION}-Source.tar.gz && \
    mkdir build && \
    cd build && \
    cmake -DCMAKE_INSTALL_PREFIX=/eccodes ../eccodes-${ECBUILD_VERSION}-Source && \
    make && \
    ctest && \
    make install && \
    rm -rf /tmp/* 

USER gitpod
