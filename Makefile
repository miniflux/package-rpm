.PHONY: clean run package

clean:
	@ rm -f *.rpm sources/miniflux sources/miniflux.1 sources/miniflux-linux-amd64 sources/LICENSE sources/ChangeLog

run: clean
	@ docker run -it --rm -v ${PWD}/sources:/root/rpmbuild/SOURCES -v ${PWD}:/root/rpmbuild/RPMS/x86_64 miniflux/rpmbuild bash

package: clean
	@ docker build -t miniflux/rpmbuild .
	@ docker run --rm -v ${PWD}/sources:/root/rpmbuild/SOURCES -v ${PWD}:/root/rpmbuild/RPMS/x86_64 miniflux/rpmbuild
