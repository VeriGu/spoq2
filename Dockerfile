###################  builder  ###################
FROM ubuntu:22.04 AS builder
ENV DEBIAN_FRONTEND=noninteractive

# core tool-chain & libs 
RUN set -eux; \
    # 1) first update may fail; ignore its exit status
    apt-get update || true; \
    # 2) bring in the current keyring + gpg helpers
    apt-get install -y --no-install-recommends \
        ubuntu-keyring gnupg ca-certificates; \
    # 3) now signatures verify correctly
    apt-get update; \
    apt-get install -y --no-install-recommends \
        build-essential cmake ninja-build git wget curl \
        python3 python3-pip unzip pkg-config \
        llvm-14 llvm-14-dev clang-14 lld-14 clang \
        libboost-all-dev; \
    rm -rf /var/lib/apt/lists/*

# ARM64 cross-toolchain
RUN apt-get update && \
		DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
		crossbuild-essential-arm64   \  
		libc6-dev-arm64-cross          
RUN python3 -m pip install --no-cache-dir --upgrade pip && \
    python3 -m pip install --no-cache-dir numpy matplotlib

# Z3 4.12.5
ARG Z3_VER=z3-4.12.5
WORKDIR /opt
RUN git clone --depth 1 --branch ${Z3_VER} https://github.com/Z3Prover/z3.git z3 && \
    cd z3 && mkdir build && cd build && \
    cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/opt/z3 && \
    make -j$(nproc) && make install
ENV Z3_DIR=/opt/z3/lib/cmake/z3


# Z3 4.13.4 (pre-built binary)
RUN wget -q https://github.com/Z3Prover/z3/releases/download/z3-4.13.4/z3-4.13.4-x64-glibc-2.35.zip && \
    unzip -q z3-4.13.4-x64-glibc-2.35.zip -d /opt && \
    mv /opt/z3-4.13.4*/ /opt/z3-4.13.4 && \
    ln -s /opt/z3-4.13.4/bin/z3 /usr/local/bin/z3-4.13.4 && \
    rm z3-4.13.4-x64-glibc-2.35.zip

#  - 4.12.5 remains the default “z3”
#  - run `z3-4.13.4` to use the newer binary

# Spoq build
WORKDIR /opt/spoq2
COPY . .
RUN cmake -S . -B build -G Ninja -DCMAKE_BUILD_TYPE=Debug -DZ3_DIR=${Z3_DIR} && \
    cmake --build build -j$(nproc) && \
    mkdir -p /opt/spoq2/bin /opt/spoq2/lib && \
    cp build/spoq /opt/spoq2/bin/ && \
    find build -name '*.so' -exec cp {} /opt/spoq2/lib/ \;

ENV PATH="/opt/spoq2/build:/opt/z3/bin/:$PATH" \
    Z3_PATH="/opt/z3-4.13.4/bin/z3" \
    Z3_DIR=/opt/z3/lib/cmake/z3 
CMD ["bash"]

###################  runtime  ###################
FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    libstdc++6 llvm-14 libboost-program-options1.74.0 && \
    rm -rf /var/lib/apt/lists/*

COPY --from=builder /opt/z3            /opt/z3
COPY --from=builder /opt/z3-4.13.4           /opt/z3-4.13.4
COPY --from=builder /opt/spoq2/lib     /opt/spoq2/lib
COPY --from=builder /opt/spoq2/build/spoq      /opt/spoq2/build/spoq  

ENV PATH="/opt/spoq2/build:/opt/z3/bin/:$PATH" \
    Z3_DIR=/opt/z3/lib/cmake/z3

WORKDIR /workspace
CMD ["bash"]
