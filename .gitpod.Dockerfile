FROM gitpod/workspace-full

USER root
RUN apt-get -q update && \
    apt-get install -yq libboost-all-dev && \
    rm -rf /var/lib/apt/lists/*

# OpenJPEG
ARG OPENJPEG_VERSION=2.4.0

RUN wwget -c https://github.com/uclouvain/openjpeg/archive/v2.4.0.tar.gz  -O openjpeg-2.4.0.tar.gz && \
    tar xzf openjpeg-2.4.0.tar.gz && \
    mkdir build && \
    cd build && \
    # Compile and install OpenJPEG
    cmake ../openjpeg-2.4.0 -DCMAKE_BUILD_TYPE=Release && \
    make && \
    make install && \
    make clean
    #&& make -j3 && make -j3 install && make -j3 clean 
    #&& cd $ROOTDIR && rm -Rf src/openjpeg* 



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

