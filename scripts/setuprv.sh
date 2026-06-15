#!/usr/bin/env bash
set -e

if [ ! -e /proc/sys/fs/binfmt_misc/qemu-riscv64 ]; then
  echo "Registering riscv64 binfmt handler..."
  docker run --privileged --rm tonistiigi/binfmt --install riscv64
fi

if [ "$(docker ps -q -f name=riscv-dev)" ]; then
  echo "riscv-dev already running."
elif [ "$(docker ps -aq -f name=riscv-dev)" ]; then
  echo "Starting existing riscv-dev container..."
  docker start riscv-dev
else
  echo "Building custom RISC-V development image..."
  docker build -t my-riscv-env .

  echo "Creating riscv-dev container..."
  docker run -d \
    --platform=linux/riscv64 \
    --name riscv-dev \
    -v "$(cd .. && pwd)":/workspace \
    -w /workspace \
    debian:trixie \
    sleep infinity
fi
echo "Ready. Use: docker exec -it riscv-dev bash"