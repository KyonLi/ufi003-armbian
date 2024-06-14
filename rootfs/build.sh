#/bin/bash

if [ `id -u` -ne 0 ]
  then echo "Please run as root"
  exit
fi

mkdir -p original_image build temp
losetup -P /dev/loop404 armbian.img
mount /dev/loop404p1 original_image
dd if=/dev/zero of=temp.img bs=1M count=3000
mkfs.ext4 temp.img
mount temp.img temp
rsync -aH original_image/ temp/
umount original_image
UUID=$(blkid -s UUID -o value /dev/loop404p1)
losetup -d /dev/loop404

cp ../deb-pkgs/*.deb ../kernel/linux-headers-*.deb ../kernel/linux-image-*.deb chroot.sh temp/tmp/
mount --bind /proc temp/proc
mount --bind /dev temp/dev
mount --bind /dev/pts temp/dev/pts
mount --bind /sys temp/sys
LANG=en_US.utf8 LC_ALL=en_US.utf8 chroot temp /tmp/chroot.sh
umount temp/proc
umount temp/dev/pts
umount temp/dev
umount temp/sys

rm -rf temp/tmp/{*,.*} temp/root/.bash_history
#dd if=/dev/zero of=armbian-ufi003.img bs=1M count=$(( $(du -ms temp | cut -f1) + 100 ))
dd if=/dev/zero of=armbian-ufi003.img bs=1M count=$(( $(df -m --output=used temp | tail -1 | awk '{print $1}') + 100 ))
mkfs.ext4 -L armbi_root -U $UUID armbian-ufi003.img
mount armbian-ufi003.img build
rsync -aH temp/ build/

umount temp
umount build
img2simg armbian-ufi003.img rootfs.img
rm -rf temp.img armbian-ufi003.img temp build original_image
