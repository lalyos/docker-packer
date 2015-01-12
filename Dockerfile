FROM golang:1.3.3

RUN go get github.com/mitchellh/gox

# get golang dependencies
RUN go get -d github.com/mitchellh/packer \
	&& cd /go/src/github.com/mitchellh/packer \
	&& make updatedeps

# get the patch from ekle/goamz (see: https://github.com/mitchellh/goamz/pull/154)
RUN cd /go/src/github.com/mitchellh/goamz \
	&& git config --global user.email "no@name.com" \
	&& curl -L https://github.com/mitchellh/goamz/pull/154.patch \
	| git am --signoff

WORKDIR /go/src/github.com/mitchellh/packer

# set VersionPrerelease to see the git commit in packer version output
RUN sed -i 's/VersionPrerelease = ""/VersionPrerelease = "dev"/' version.go
RUN make dev

VOLUME /data
WORKDIR /data

ENTRYPOINT [ "/go/bin/packer" ]
