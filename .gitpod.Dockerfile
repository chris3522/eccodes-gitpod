FROM gitpod/workspace-full

USER root
RUN apt-get -q update && \
    apt-get install -yq libboost-all-dev && \
    rm -rf /var/lib/apt/lists/*

# OpenJPEG
ARG OPENJPEG_VERSION=2.4.0

RUN wget -c https://github.com/uclouvain/openjpeg/archive/v2.4.0.tar.gz  -O openjpeg-2.4.0.tar.gz && \
    tar xzf openjpeg-2.4.0.tar.gz && \
    mkdir openjpegtmp && \
    cd openjpegtmp && \
    mkdir build && \
    cd build && \
    # Compile and install OpenJPEG
    cmake ../../openjpeg-2.4.0 -DCMAKE_BUILD_TYPE=Release && \
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
    
RUN mkdir /home/gitpod/.conda
# Install conda
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc
    
RUN chown -R gitpod:gitpod /opt/conda \
    && chmod -R 777 /opt/conda \
    && chown -R gitpod:gitpod /home/gitpod/.conda \
    && chmod -R 777 /home/gitpod/.conda
    

USER gitpod

