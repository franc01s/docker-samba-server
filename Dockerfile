FROM alpine:latest

ENV UID 1000
ENV USERNAME samba
ENV GID 1000
ENV GROUP samba
ENV PASSWORD password
ENV CONFIG /config/smb.conf

RUN set -xe \
	&& apk add --update --no-progress samba-common-tools samba-server openssl \
	&& rm -rf /var/cache/apk/*

ENV S6_VERSION 1.18.1.5

COPY run.s6 /etc/services.d/samba/run
COPY finish.s6 /etc/services.d/samba/finish
COPY smb.conf /config/smb.conf


EXPOSE 137/udp 138/udp 139/tcp 445/tcp

CMD ["/init"]
