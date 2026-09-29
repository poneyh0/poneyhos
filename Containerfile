ARG BASE_IMAGE=quay.io/fedora/fedora-kinoite:44

# Allow build scripts to be referenced without being copied into the final image
FROM scratch AS ctx
COPY build_files /
COPY system_files /system_files

# Build Glass effect
FROM ${BASE_IMAGE} AS kinoite-glass-builder
RUN --mount=type=cache,dst=/var/cache \
    dnf -y install git cmake extra-cmake-modules gcc-c++ \
        kwin-devel kdecoration-devel "cmake(KDecoration3)" \
        plasma-workspace-devel libplasma-devel \
        qt6-qtbase-devel qt6-qtbase-private-devel \
        kf6-kwindowsystem-devel kf6-knotifications-devel kf6-kio-devel \
        kf6-kcrash-devel kf6-ki18n-devel kf6-kguiaddons-devel \
        kf6-kglobalaccel-devel kf6-kcmutils-devel kf6-kconfigwidgets-devel \
        kf6-kdeclarative-devel kf6-kcolorscheme-devel kf6-kiconthemes-devel \
        kf6-kirigami-devel kf6-frameworkintegration-devel \
        libepoxy-devel wayland-devel libdrm-devel

WORKDIR /src

# kwin-effects-glass, version-tag 20260620-1
RUN git clone https://github.com/4v3ngR/kwin-effects-glass && \
    cd kwin-effects-glass && git checkout e8ab991af172c4b2429856acd60bbcacf0e4e976 && \
    cd .. && \
    cmake -S kwin-effects-glass -B kwin-effects-glass/build -DCMAKE_INSTALL_PREFIX=/usr && \
    cmake --build kwin-effects-glass/build -j"$(nproc)" && \
    DESTDIR=/out cmake --install kwin-effects-glass/build

# Glass decoration/style, pinned commit
RUN git clone https://github.com/4v3ngR/Glass.git && \
    cd Glass && git checkout 2ec67bf2d28094d629bf3fe9bc55c7a8a393cfb1 && \
    cd .. && \
    cmake -S Glass -B Glass/build -DCMAKE_INSTALL_PREFIX=/usr -DBUILD_TESTING=OFF \
            -DKDE_INSTALL_USE_QT_SYS_PATHS=ON -DBUILD_QT6=ON -DBUILD_QT5=OFF && \
    cmake --build Glass/build -j"$(nproc)" && \
    DESTDIR=/out cmake --install Glass/build

FROM ${BASE_IMAGE}

COPY --from=kinoite-glass-builder /out/usr /usr

### [IM]MUTABLE /opt
## Some bootable images, like Fedora, have /opt symlinked to /var/opt, in order to
## make it mutable/writable for users. However, some packages write files to this directory,
## thus its contents might be wiped out when bootc deploys an image, making it troublesome for
## some packages. Eg, google-chrome, docker-desktop.
##
## Uncomment the following line if one desires to make /opt immutable and be able to be used
## by the package manager.

RUN rm /opt && mkdir /opt

### MODIFICATIONS
## make modifications desired in your image and install packages by modifying the build.sh script
## the following RUN directive does all the things required to run "build.sh" as recommended.

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    /ctx/build.sh

### LINTING
## Verify final image and contents are correct.
RUN bootc container lint
