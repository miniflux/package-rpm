FROM golang:1 as build
ARG APP_VERSION
ARG APP_ARCH="amd64"
ARG APP_REPO="https://github.com/miniflux/miniflux.git"
WORKDIR /go
RUN git clone --depth 50 --branch ${APP_VERSION} ${APP_REPO} && \
    cd miniflux && \
    make linux-${APP_ARCH} VERSION=${APP_VERSION}

FROM centos:8
RUN dnf install -y rpm-build
RUN mkdir -p /root/rpmbuild/{BUILD,RPMS,SOURCES,SPECS,SRPMS}
RUN echo "%_topdir /root/rpmbuild" >> .rpmmacros
COPY --from=build /go/miniflux/miniflux-* /root/rpmbuild/SOURCES/miniflux
COPY --from=build /go/miniflux/LICENSE /root/rpmbuild/SOURCES/
COPY --from=build /go/miniflux/ChangeLog /root/rpmbuild/SOURCES/
COPY --from=build /go/miniflux/miniflux.1 /root/rpmbuild/SOURCES/
COPY miniflux.service /root/rpmbuild/SOURCES/
COPY miniflux.conf /root/rpmbuild/SOURCES/
COPY miniflux.spec /root/rpmbuild/SPECS/miniflux.spec
