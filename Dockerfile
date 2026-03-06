FROM ghcr.io/ananda-aropa/aaropa_rootfs_base:latest

COPY template /
COPY packages /
COPY scripts /
COPY iso /iso

RUN apt update && apt full-upgrade -y --allow-unauthenticated

# Install package list
RUN grep -Ev '^#' /pkglist.cfg | xargs apt install -y --no-install-recommends --no-install-suggests --allow-unauthenticated

RUN /post-install.sh

RUN apt autoremove --purge -y

# Try to strip down the image further
RUN grep -Ev '^#' /rmlist.cfg | xargs dpkg --remove --force-depends --force-remove-essential || :

RUN rm /*.cfg

RUN /post-setup.sh
RUN rm /*.sh
