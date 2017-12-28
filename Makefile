all:
	@ rm -f *.rpm
	@ docker build -t miniflux/rpmbuild .
	@ docker run --rm -v ${PWD}/sources:/root/rpmbuild/SOURCES -v ${PWD}:/root/rpmbuild/RPMS/x86_64 miniflux/rpmbuild