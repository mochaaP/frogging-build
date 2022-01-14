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

RUN wget -O- https://github.com/Frogging-Family/community-patches/archive/refs/heads/master.tar.gz | tar xzvf - && \
    mv community-patches-master community-patches


RUN wget -O- https://github.com/Frogging-Family/linux-tkg/archive/refs/heads/master.tar.gz | tar xzvf - && \
    mv linux-tkg-master linux-tkg

RUN curl https://github.com/Snoop05/linux-tkg/commit/9fff55f8b9c9d11af9102035af48bed8aea1982a.diff | patch -p1 -d linux-tkg

WORKDIR /workspace/linux-tkg

COPY $BUILD_CONFIG /workspace/.config/frogminer/linux-tkg.cfg

RUN PKGDEST=/dist makepkg -rc
