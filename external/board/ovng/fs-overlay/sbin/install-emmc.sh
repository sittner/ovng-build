#!/bin/sh

SRC_DEVICE=/dev/mmcblk0
MMC_DEVICE=/dev/mmcblk1

if [ ! -b $MMC_DEVICE ]; then
  echo "ERROR: device $MMC_DEVICE not found"
  exit 1
fi

set -e

MNTDIR=`mktemp -d`

cleanup () {
  if fgrep -q " $MNTDIR " /proc/mounts; then
    sync
    umount $MNTDIR
  fi
  rm -rf $MNTDIR
}
trap cleanup EXIT

grep "^$MMC_DEVICE" /proc/mounts | while read dev mp fs opts; do
 umount $mp
done

echo "Creating partitions..."
dd if=/dev/zero of="$MMC_DEVICE" bs=512 count=2048
sfdisk $MMC_DEVICE << EOF
,10MiB,c,*
,512MiB,83
,512MiB,83
,,83
EOF

sleep 1

dd if=/dev/zero of="$MMC_DEVICE"p1 bs=512 count=1

echo "Creating file systems..."
mkfs.fat -n BOOT "$MMC_DEVICE"p1
mkfs.ext4 -F -L root1 "$MMC_DEVICE"p2
mkfs.ext4 -F -L root2 "$MMC_DEVICE"p3
mkfs.ext4 -F -L data "$MMC_DEVICE"p4

mkdir -p $MNTDIR/src
mkdir -p $MNTDIR/dst

echo "Installing boot files..."
mount -o ro "$SRC_DEVICE"p1 $MNTDIR/src
mount "$MMC_DEVICE"p1 $MNTDIR/dst
cp -a $MNTDIR/src/* $MNTDIR/dst
echo "$MNTDIR/dst/uboot.env 0x0000 0x20000" >$MNTDIR/fw_env.config
fw_setenv -c $MNTDIR/fw_env.config mmcdev 1
sync
umount $MNTDIR/dst
umount $MNTDIR/src

echo "Installing root file system..."
mount -o ro / $MNTDIR/src
mount "$MMC_DEVICE"p2 $MNTDIR/dst
cp -a $MNTDIR/src/* $MNTDIR/dst
sync
umount $MNTDIR/dst
umount $MNTDIR/src

echo "Installing xcsoar basic data"
mount "$MMC_DEVICE"p4 $MNTDIR/dst
mkdir -p $MNTDIR/dst/dropbear
chmod 700 $MNTDIR/dst/dropbear
mkdir -p $MNTDIR/dst/xcsoar
zcat /xcsdata.tar.gz | tar xvf - -C $MNTDIR/dst/xcsoar
sync
umount $MNTDIR/dst

