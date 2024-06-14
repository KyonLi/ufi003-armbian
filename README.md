# ufi003-armbian
适用于UFI003_MB_V02的Armbian构建脚本

## 本地构建
1. 克隆本仓库
2. [下载上游镜像](https://mirrors.tuna.tsinghua.edu.cn/armbian-releases/odroidn2/archive/)，解压并重命名为`armbian.img`放置到`rootfs/`
3. 安装依赖包 `rsync qemu-user-static binfmt-support android-sdk-libsparse-utils`
4. 进入rootfs目录，以root权限运行`build.sh`
5. 构建完成后会在rootfs目录得到rootfs.img
