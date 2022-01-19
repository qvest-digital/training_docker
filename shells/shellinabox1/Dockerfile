FROM docker:latest

ARG GATEWAY
RUN echo "@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
    && apk update \
    && apk add --no-cache curl bash vim shellinabox@testing

RUN echo 'export PS1="\w \$ "' >> /root/.bashrc
RUN echo "alias dps='docker ps --format \"table {{.ID}}\\t{{.Image}}\\t{{.Status}}\\t{{.Ports}}\\t{{.Names}}\"'" >> /root/.bashrc
RUN echo "alias dpss='docker ps --format \"table {{.ID}} {{.Image}}\\t{{.Status}}\\t{{.Ports}}\\t{{.Names}}\"'" >> /root/.bashrc
RUN echo "alias dockerps='docker ps --format \"table {{.ID}}\\t{{.Image}}\\t{{.Status}}\\t{{.Ports}}\\t{{.Names}}\"'" >> /root/.bashrc
RUN echo "set bg=dark" > /root/.vimrc

ADD styles.css /data/

COPY dbash /usr/local/bin/dbash

EXPOSE 4200

CMD ["shellinaboxd", "--css", "/data/styles.css", "-s", "/:0:0:/root:/usr/local/bin/dbash", "--disable-ssl"]
