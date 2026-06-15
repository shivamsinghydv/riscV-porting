#!/usr/bin/env bash
set -e
docker stop riscv-dev 2>/dev/null || true
docker rm riscv-dev 2>/dev/null || true
echo "Tore down riscV dev."