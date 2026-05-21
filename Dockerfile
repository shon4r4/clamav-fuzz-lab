FROM debian:stable-slim

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /opt

RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    ca-certificates \
    curl \
    wget \
    build-essential \
    make \
    cmake \
    ninja-build \
    pkg-config \
    clang \
    clang-tools \
    llvm \
    llvm-dev \
    lld \
    libclang-dev \
    automake \
    autoconf \
    libtool \
    flex \
    bison \
    cargo \
    rustc \
    python3 \
    python3-dev \
    python3-pip \
    python3-setuptools \
    zlib1g-dev \
    libbz2-dev \
    libssl-dev \
    libxml2-dev \
    libpcre2-dev \
    libjson-c-dev \
    libcurl4-openssl-dev \
    libmilter-dev \
    libncurses-dev \
    check \
    valgrind \
    gdb \
 && rm -rf /var/lib/apt/lists/*

# Install AFL++
RUN git clone --branch stable --depth 1 https://github.com/AFLplusplus/AFLplusplus.git \
 && cd AFLplusplus \
 && make distrib \
 && make install

# Clone ClamAV source
RUN git clone --depth 1 https://github.com/Cisco-Talos/clamav.git

# Create working directories
RUN mkdir -p \
    /work/corpus \
    /work/out \
    /work/findings \
    /work/build-clamav

WORKDIR /work

# AFL++ runtime environment
ENV AFL_SKIP_CPUFREQ=1
ENV AFL_I_DONT_CARE_ABOUT_MISSING_CRASHES=1

CMD ["/bin/bash"]
