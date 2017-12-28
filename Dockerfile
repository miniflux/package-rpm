FROM fedora:27
RUN dnf -y install rpm-build
RUN mkdir -p /root/rpmbuild/{BUILD,RPMS,SOURCES,SPECS,SRPMS}
RUN echo "%_topdir /root/rpmbuild" >> .rpmmacros
ADD build.sh /build.sh
ADD miniflux.spec /root/rpmbuild/SPECS/miniflux.spec
CMD ["/build.sh"]
