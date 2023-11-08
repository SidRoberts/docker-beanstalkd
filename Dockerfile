FROM alpine as builder

ENV BEANSTALKD_VERSION=1.13

WORKDIR /tmp/

RUN apk add --no-cache build-base git

RUN git clone --depth 1 --branch v${BEANSTALKD_VERSION} https://github.com/beanstalkd/beanstalkd.git

COPY vers.sh /tmp/beanstalkd/vers.sh

RUN cd /tmp/beanstalkd/ && make

################################

FROM alpine

LABEL maintainer="Sid Roberts <sid@sidroberts.co.uk>"

COPY --from=builder /tmp/beanstalkd/beanstalkd /usr/bin/

RUN mkdir /var/lib/beanstalkd/

EXPOSE 11300

VOLUME ["/var/lib/beanstalkd"]

ENTRYPOINT /usr/bin/beanstalkd -b /var/lib/beanstalkd/
