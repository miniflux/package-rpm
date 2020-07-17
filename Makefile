DOCKER_IMAGE=miniflux_rpmbuilder
VERSION=2.0.22

.PHONY: clean package

clean:
	@ rm -f *.rpm

package: clean
	@ docker build \
		-t $(DOCKER_IMAGE) \
		--build-arg APP_VERSION=$(VERSION) \
		.
	@ docker run --rm \
		-v ${PWD}:/root/rpmbuild/RPMS/x86_64/ $(DOCKER_IMAGE) \
		rpmbuild -bb --define "_miniflux_version $(VERSION)" /root/rpmbuild/SPECS/miniflux.spec