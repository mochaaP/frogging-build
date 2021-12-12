FROM archlinux:latest AS build

RUN echo "ParallelDownloads = 5" | tee -a /etc/pacman.conf && \
    pacman -Sy fakeroot wget binutils --noconfirm --needed && \
    pacman -S --clean --noconfirm && \
    useradd -m -d /workspace builder && \
    mkdir /dist && \
    chown builder:builder /dist

WORKDIR /workspace
USER builder

RUN wget -O- https://github.com/Frogging-Family/nvidia-all/archive/refs/heads/master.tar.gz | tar xzvf - && \
    mv nvidia-all-master nvidia-all

WORKDIR /workspace/nvidia-all

COPY nvidia-all.cfg /workspace/.config/frogminer/

RUN PKGDEST=/dist makepkg -rc
