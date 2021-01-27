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
USER gitpod
RUN sudo apt-get -q update && \
    sudo apt-get install -yq libboost-all-dev && \
    sudo rm -rf /var/lib/apt/lists/*

USER root
ARG ECBUILD_VERSION=2.20.0
#RUN export PATH=$PATH:/usr/local/bin && \
RUN cd /tmp && \
    wget -q https://confluence.ecmwf.int/download/attachments/45757960/eccodes-${ECBUILD_VERSION}-Source.tar.gz && \
    tar xzf eccodes-${ECBUILD_VERSION}-Source.tar.gz && \
    mkdir build && \
    cd build && \
    cmake -DCMAKE_INSTALL_PREFIX=/usr ../eccodes-${ECBUILD_VERSION}-Source && \
    make && \
    ctest && \
    make install && \
    rm -rf /tmp/*
    

USER gitpod
#RUN export PATH="/usr/local/bin:$PATH"
#ENV PATH "$PATH:/usr/local/bin"
#RUN export PATH=$PATH:/usr/local/bin 
#RUN echo "PATH=\$PATH:/usr/local/bin"
