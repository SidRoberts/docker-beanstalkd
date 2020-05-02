FROM alpine

LABEL maintainer="Sid Roberts <sid@sidroberts.co.uk>"

ADD install.sh /install.sh

RUN chmod +x /install.sh && sh /install.sh && rm /install.sh

EXPOSE 11300

VOLUME ["/var/lib/beanstalkd"]

ENTRYPOINT /usr/bin/beanstalkd -b /var/lib/beanstalkd/
