#!/bin/bash

dpkg -l | grep -E "linux-image|linux-headers|linux-dtb|firmware|u-boot|odroidn2" | awk '{print $2}' | xargs apt autoremove -y --purge
rm -rf /boot/{*,.*} /initrd.img* /vmlinuz*
apt update
apt install -y rmtfs qrtr-tools libqmi-utils
apt install -y /tmp/*.deb
apt install -y dnsmasq-base

sed -i s/odroidn2/ufi003/g /etc/armbian-release
sed -i s/'Odroid N2'/UFI003_MB_V02/g /etc/armbian-release
sed -i s/meson-g12b/msm8916/g /etc/armbian-release
sed -i s/meson64/qcom/g /etc/armbian-release
sed -i s/odroidn2/ufi003/g /etc/armbian-image-release
sed -i s/'Odroid N2'/UFI003_MB_V02/g /etc/armbian-image-release
sed -i s/meson-g12b/msm8916/g /etc/armbian-image-release
sed -i s/meson64/qcom/g /etc/armbian-image-release
sed -i s/Odroidn2/UFI003/g /etc/armbian.txt
sed -i s/odroidn2/ufi003/g /etc/hostname
sed -i s/odroidn2/ufi003/g /etc/hosts

rm -rf /var/lib/apt/lists
apt clean all
exit
