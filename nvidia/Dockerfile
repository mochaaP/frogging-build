FROM archlinux:latest

ARG BUILD_CONFIG=nvidia-all.cfg

RUN echo "ParallelDownloads = 5" | tee -a /etc/pacman.conf && \
    pacman -Sy base-devel fakeroot wget binutils --noconfirm --needed && \
    pacman -S --clean --noconfirm && \
    useradd -m -d /workspace builder && \
    mkdir /dist && \
    chown builder:builder /dist

WORKDIR /workspace
USER builder

RUN wget -O- https://github.com/Frogging-Family/nvidia-all/archive/refs/heads/master.tar.gz | tar xzvf - && \
    mv nvidia-all-master nvidia-all

RUN wget -O- https://github.com/Frogging-Family/nvidia-all/commit/e9cf6473abd7855274dfdae96e36af708f70f655.diff | patch -p1 -d nvidia-all

WORKDIR /workspace/nvidia-all

COPY $BUILD_CONFIG /workspace/.config/frogminer/nvidia-all.cfg

RUN PKGDEST=/dist makepkg -rc
