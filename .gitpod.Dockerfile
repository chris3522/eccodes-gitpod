FROM gitpod/workspace-full

USER root
RUN apt-get -q update && \
    apt-get install -yq libboost-all-dev && \
    rm -rf /var/lib/apt/lists/*

# OpenJPEG
ENV ROOTDIR /usr/local
ENV OPENJPEG_VERSION 2.3.0
WORKDIR $ROOTDIR/
RUN mkdir -p $ROOTDIR/src
RUN wget -qO- 
    https://github.com/uclouvain/openjpeg/archive/v${OPENJPEG_VERSION}.tar.gz | 
    tar -xzC $ROOTDIR/src/
    # Compile and install OpenJPEG
    && cd src/openjpeg-${OPENJPEG_VERSION} 
    && mkdir build && cd build 
    && cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$ROOTDIR 
    && make -j3 && make -j3 install && make -j3 clean 
    && cd $ROOTDIR && rm -Rf src/openjpeg* 

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

RUN echo "/usr/local/lib" >> /etc/ld.so.conf && \
    ldconfig && \
    chmod -R 777 /usr/local/share/eccodes/definitions
    
USER gitpod

