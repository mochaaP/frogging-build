FROM archlinux:latest

ARG BUILD_CONFIG=wine-tkg.cfg

RUN echo "ParallelDownloads = 5" | tee -a /etc/pacman.conf && \
    echo -e "[multilib]\nInclude = /etc/pacman.d/mirrorlist" | tee -a /etc/pacman.conf && \
    pacman -Sy alsa-lib attr autoconf base-devel bison desktop-file-utils faudio flex fontconfig fontforge freetype2 gcc-libs gcc>=4.5.0-2 gettext giflib git glslang glu gnutls gst-plugins-base-libs gst-plugins-good gst-plugins-ugly gtk3 jack2 jxrlib lcms2 lib32-alsa-lib lib32-attr lib32-faudio lib32-fontconfig lib32-freetype2 lib32-gcc-libs lib32-gettext lib32-giflib lib32-glu lib32-gnutls lib32-gst-plugins-base-libs lib32-gst-plugins-good lib32-gtk3 lib32-jack2 lib32-lcms2 lib32-libcups lib32-libgl lib32-libldap lib32-libpcap lib32-libpng lib32-libpulse lib32-libsm lib32-libva lib32-libxcomposite lib32-libxcursor lib32-libxdamage lib32-libxi lib32-libxinerama lib32-libxml2 lib32-libxmu lib32-libxrandr lib32-libxslt lib32-libxxf86vm lib32-mesa lib32-mpg123 lib32-ocl-icd lib32-openal lib32-sdl2 lib32-v4l-utils lib32-vulkan-icd-loader libcups libgl libldap libpcap libpng libpulse libsm libva libxcomposite libxcursor libxdamage libxi libxinerama libxml2 libxmu libxrandr libxslt libxxf86vm mesa meson mingw-w64-gcc mpg123 ncurses ninja ocl-icd openal opencl-headers perl pkgconf samba sdl2 tk v4l-utils vulkan-icd-loader wget --noconfirm --needed && \
    pacman -S --clean --noconfirm && \
    useradd -m -d /workspace builder && \
    mkdir /dist && \
    chown builder:builder /dist

WORKDIR /workspace
USER builder

RUN git clone https://github.com/Frogging-Family/community-patches.git --depth=1

RUN wget -O- https://github.com/Frogging-Family/wine-tkg-git/archive/refs/heads/master.tar.gz | tar xzvf - && \
    mv wine-tkg-git-master wine-tkg-git

WORKDIR /workspace/wine-tkg-git/wine-tkg-git

COPY $BUILD_CONFIG /workspace/.config/frogminer/wine-tkg.cfg
COPY patch/* wine-tkg-userpatches/

RUN PKGDEST=/dist makepkg -rc

RUN if compgen -G "*.deb" > /dev/null; then mv *.deb /dist; fi # Workaround .deb packages
