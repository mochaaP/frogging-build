FROM archlinux:latest

ARG BUILD_CONFIG=linux-tkg.cfg

RUN echo "ParallelDownloads = 5" | tee -a /etc/pacman.conf && \
    pacman -Sy base-devel bison xmlto docbook-xsl kmod inetutils bc libelf pahole patchutils flex python-sphinx python-sphinx_rtd_theme graphviz imagemagick git cpio perl tar xz wget schedtool --noconfirm --needed && \
    pacman -S --clean --noconfirm && \
    useradd -m -d /workspace builder && \
    mkdir /dist && \
    chown builder:builder /dist

WORKDIR /workspace
USER builder

RUN wget -O- https://github.com/Frogging-Family/community-patches/archive/master.tar.gz | tar xzvf - && \
    mv community-patches-master community-patches

RUN wget -O community-patches/linux517-tkg/lru_5.17.mypatch \
      https://github.com/Frogging-Family/community-patches/raw/a99570b2c3fa85f69833cefb43997320a2894502/linux517-tkg/lru_5.17.mypatch

RUN wget -O- https://github.com/Frogging-Family/linux-tkg/archive/master.tar.gz | tar xzvf - && \
    mv linux-tkg-master linux-tkg

WORKDIR /workspace/linux-tkg

COPY $BUILD_CONFIG /workspace/.config/frogminer/linux-tkg.cfg

RUN PKGDEST=/dist makepkg -rc
