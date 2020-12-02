#!/bin/sh

set -u
set -e

BOARD_DIR="$(dirname $0)"

(cd $BINARIES_DIR && ln -sf uboot-env.bin uboot.env)

