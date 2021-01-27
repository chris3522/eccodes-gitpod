FROM gitpod/workspace-full

USER root
RUN apt-get -q update && \
    apt-get install -yq libboost-all-dev && \
    rm -rf /var/lib/apt/lists/*

ARG ECBUILD_VERSION=2.20.0

#RUN cd /tmp && \
RUN wget -q https://confluence.ecmwf.int/download/attachments/45757960/eccodes-${ECBUILD_VERSION}-Source.tar.gz && \
    tar xzf eccodes-${ECBUILD_VERSION}-Source.tar.gz && \
    mkdir build && \
    cd build && \
    cmake ../eccodes-${ECBUILD_VERSION}-Source && \
    make && \
    ctest && \
    make install
#  rm -rf /tmp/*

RUN echo "/usr/local/lib" >> /etc/ld.so.conf && ldconfig
    
USER gitpod

