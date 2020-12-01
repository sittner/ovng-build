#!/bin/sh

set -u
set -e

BOARD_DIR="$(dirname $0)"

# try to get linux version
LINUX_VERSION="$(find "$TARGET_DIR/lib/modules" -mindepth 1 -maxdepth 1 -type d -exec basename {} \; -quit)"

# generate uEnv.txt
mkdir -p "$TARGET_DIR/boot"
cat >"$TARGET_DIR/boot/uEnv.txt" <<EOF
enable_uboot_overlays=1
disable_uboot_overlay_video=1
disable_uboot_overlay_adc=1
uboot_overlay_addr0=/lib/firmware/BB-OVNG-00A0.dtbo
uboot_overlay_addr1=/lib/firmware/BB-OVNG-UART1-00A0.dtbo
uname_r=$LINUX_VERSION
EOF

# copy kernel image to boot directory
cp "$BINARIES_DIR/zImage" "$TARGET_DIR/boot/vmlinuz-$LINUX_VERSION"

# copy device tree files to boot directory
mkdir -p "$TARGET_DIR/boot/dtbs/$LINUX_VERSION"
find "$BINARIES_DIR" -name "*.dtb" -exec cp {} "$TARGET_DIR/boot/dtbs/$LINUX_VERSION" \;

