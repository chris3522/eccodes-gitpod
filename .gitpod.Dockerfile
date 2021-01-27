FROM gitpod/workspace-full

USER gitpod

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
#USER root
RUN sudo apt-get -q update && \
     sudo apt-get install -yq libboost-all-dev && \
     sudo rm -rf /var/lib/apt/lists/*
ARG ECBUILD_VERSION=2.20.0
#RUN export PATH=$PATH:/usr/local/bin && \
RUN sudo cd /tmp && \
    sudo wget -q https://confluence.ecmwf.int/download/attachments/45757960/eccodes-${ECBUILD_VERSION}-Source.tar.gz && \
    sudo tar xzf eccodes-${ECBUILD_VERSION}-Source.tar.gz && \
    sudo mkdir build && \
    sudo cd build && \
    sudo cmake -DCMAKE_INSTALL_PREFIX=/usr/local ../eccodes-${ECBUILD_VERSION}-Source && \
    sudo make && \
    sudo ctest && \
    sudo make install && \
    sudo rm -rf /tmp/*
    

#USER gitpod
#RUN export PATH=$PATH:/usr/local/bin 
#RUN echo "PATH=\$PATH:/usr/local/bin"
