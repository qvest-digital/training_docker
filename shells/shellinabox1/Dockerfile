FROM alpine

ARG GATEWAY
RUN echo "@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
    && apk update \
    && apk add --no-cache docker bash shellinabox@testing

RUN echo 'export PS1="\w \$ "' >> /root/.bashrc
RUN echo "export DOCKER_HOST=tcp://${GATEWAY}:2375" >> /root/.bashrc
RUN echo "alias dockerps='docker ps --format \"table {{.ID}}\\t{{.Image}}\\t{{.Status}}\\t{{.Ports}}\\t{{.Names}}\"'" >> /root/.bashrc

ADD styles.css /data/

EXPOSE 4200

CMD ["shellinaboxd", "--css", "/data/styles.css", "-s", "/:0:0:/root:/bin/bash", "--disable-ssl"]

