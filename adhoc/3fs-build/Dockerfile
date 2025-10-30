FROM ubuntu:22.04 AS builder

# 时区非交互安装
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
    git cmake make clang-14 clang++-14 libfuse3-dev libssl-dev pkg-config \
    curl ca-certificates wget unzip \
    # FoundationDB client library headers (可选, 也可自行下载)
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# rust
# RUN export RUSTUP_DIST_SERVER=https://mirrors.ustc.edu.cn/rust-static
# RUN export RUSTUP_UPDATE_ROOT=https://mirrors.ustc.edu.cn/rust-static/rustup
# RUN curl --proto '=https' --tlsv1.2  | sh -s -- -y
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
ENV PATH="${HOME}/.cargo/bin:${PATH}"

WORKDIR /build

# 克隆 3FS 源码
#RUN 3fs /build

# -------------------------------------------
# Stage 2: Create minimal runtime image
# -------------------------------------------
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
    libfuse3-3 libssl3 ca-certificates \
    cmake libuv1-dev liblz4-dev liblzma-dev libdouble-conversion-dev libdwarf-dev libunwind-dev \
    libaio-dev libgflags-dev libgoogle-glog-dev libgtest-dev libgmock-dev clang-format-14 clang-14 clang-tidy-14 lld-14 \
    libgoogle-perftools-dev google-perftools libssl-dev gcc-12 g++-12 libboost-all-dev \
    cmake make clang-14 clang++-14 libfuse3-dev libssl-dev pkg-config \
    curl ca-certificates wget unzip \
    # FoundationDB 客户端库 (fdb.cluster 需自行挂载)
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# 创建目录结构
RUN mkdir -p /opt/3fs/bin /opt/3fs/etc /var/log/3fs

# 从 builder 复制 3FS 可执行文件
#COPY --from=builder /build/build/bin/* /opt/3fs/bin/
COPY bin/* /opt/3fs/bin/


# entrypoint 脚本，用来根据参数启动不同角色
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

WORKDIR /opt/3fs
ENTRYPOINT ["/entrypoint.sh"]
CMD ["help"]
