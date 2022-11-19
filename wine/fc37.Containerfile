FROM fedora:37

ARG BUILD_CONFIG=wine-tkg-fedora.cfg

RUN dnf install -y git make ccache gcc-c++ mingw32-gcc mingw64-gcc SDL2-devel openal-soft-devel opencl-headers ocl-icd-devel libFAudio-devel libvkd3d-devel icoutils vulkan-devel lcms2-devel gstreamer1-devel gstreamer1-plugins-base-devel libmpg123-devel gtk3-devel libva-devel fontforge fontpackages-devel gsm-devel libjpeg-turbo-devel libudev-devel libv4l-devel pulseaudio-libs-devel lzma audiofile-devel giflib-devel ImageMagick-devel libpcap-devel libXxf86dga-devel mesa-libOSMesa-devel libgphoto2-devel alsa-lib-devel autoconf bison coreutils cups-devel dbus-devel desktop-file-utils flex fontconfig-devel freetype-devel freeglut-devel gawk xz gettext-devel gnutls-devel krb5-devel libattr-devel libieee1284-devel libpng-devel librsvg2 librsvg2-devel libstdc++-devel libtiff-devel libX11-devel libXcomposite-devel libXcursor-devel libXext-devel libXi-devel libXinerama-devel libxml2-devel libXmu-devel libXrandr-devel libXrender-devel libxslt-devel libXxf86vm-devel mesa-libGL-devel mesa-libGLU-devel ncurses-devel openldap-devel sane-backends-devel unixODBC-devel unzip util-linux zlib-devel fonttools wget python-pefile rust cargo glslang patch libpng-static.x86_64 libgcrypt-devel libXpresent-devel yasm libusb-devel pkgconf.i686 gcc-c++.i686 glibc-devel.i686 libX11-devel.i686 libXcomposite-devel.i686 libXcursor-devel.i686 libXext-devel.i686 libXi-devel.i686 libXinerama-devel.i686 libxml2-devel.i686 libXmu-devel.i686 libXrandr-devel.i686 libXrender-devel.i686 libxslt-devel.i686 libXxf86vm-devel.i686 mesa-libGL-devel.i686 mesa-libGLU-devel.i686 ncurses-devel.i686 openldap-devel.i686 freetype-devel.i686 SDL2-devel.i686 openal-soft-devel.i686 ocl-icd-devel.i686 libFAudio-devel.i686 libvkd3d-devel.i686 lcms2-devel.i686 gstreamer1-devel.i686 gstreamer1-plugins-base-devel.i686 gtk3-devel.i686 libva-devel.i686 giflib-devel.i686 libpcap-devel.i686 libXxf86dga-devel.i686 mesa-libOSMesa-devel.i686 libgphoto2-devel.i686 alsa-lib-devel.i686 cups-devel.i686 dbus-devel.i686 fontconfig-devel.i686 libpng-devel.i686 libjpeg-turbo-devel.i686 pulseaudio-libs-devel.i686 gnutls-devel.i686 krb5-devel.i686 krb5-libs.i686 libstdc++-devel.i686 libtiff-devel.i686 vulkan-loader-devel.i686 libv4l-devel.i686 gsm-devel.i686 sane-backends-devel.i686 libXfixes-devel.i686 libpng-static.i686 rust-std-static.i686 libgcrypt-devel.i686 libXpresent-devel.i686 libusb-devel.i686

RUN useradd -m -d /workspace -s /bin/bash builder && mkdir /dist && chown builder:builder /dist

WORKDIR /workspace
USER builder

RUN git clone https://github.com/Frogging-Family/community-patches.git --depth=1

RUN wget -O- https://github.com/Frogging-Family/wine-tkg-git/archive/master.tar.gz | tar xzvf - && \
    mv wine-tkg-git-master wine-tkg-git

WORKDIR /workspace/wine-tkg-git/wine-tkg-git

RUN touch tarplz

COPY $BUILD_CONFIG /workspace/.config/frogminer/wine-tkg.cfg
COPY patch/* wine-tkg-userpatches/

RUN ./non-makepkg-build.sh
