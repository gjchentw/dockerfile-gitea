FROM gjchen/alpine:3.6
MAINTAINER gjchen <gjchen.tw@gmail.com>

RUN	apk --no-cache --no-progress upgrade -f && \
	apk --no-cache --no-progress add \
	su-exec \
	ca-certificates \
	sqlite \
	bash \
	git \
	linux-pam \
	s6 \
	curl \
	openssh \
	tzdata \
	gitea

COPY	gitea/docker /
ADD	app.ini /etc/templates/app.ini
ADD	setup /etc/s6/gitea/setup

RUN	addgroup -S -g 1000 git && \
	adduser -S -H -D -h /data/git -s /bin/bash -u 1000 -G git git && \
	echo "git:$(date +%s | sha256sum | base64 | head -c 32)" | chpasswd && \
	chmod 775 /etc/s6/gitea/setup && \
	ln -s /data/gitea/conf/app.ini /var/lib/gitea/conf/app.ini && \
	ln -s /usr/bin/gitea /var/lib/gitea/gitea && \
	sed -i -e 's/\/app\/gitea/\/var\/lib\/gitea/g' /etc/s6/gitea/*

ENV	GITEA_CUSTOM=/var/lib/gitea USER=git
VOLUME	["/data"]

ENTRYPOINT ["/usr/bin/entrypoint"]
#CMD	/bin/s6-svscan /etc/s6
