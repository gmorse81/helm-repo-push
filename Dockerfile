FROM alpine:3.6 as build
RUN apk add --update --no-cache \
	ca-certificates \
	curl \
	git \
	gzip \
	tar
ARG VERSION=v3.3.1
ARG FILENAME=helm-${VERSION}-linux-amd64.tar.gz
WORKDIR /
RUN curl -L "https://get.helm.sh/${FILENAME}" | tar zxv -C /tmp


# The image we keep
FROM alpine:3.6

RUN apk add --update --no-cache git ca-certificates bash curl

COPY --from=build /tmp/linux-amd64/helm /bin/helm
COPY /repo-push.sh /repo-push.sh

ENTRYPOINT ["/repo-push.sh"]
