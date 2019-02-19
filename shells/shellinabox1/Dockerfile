FROM alpine

RUN echo "@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
    && apk update \
    && apk add --no-cache docker bash shellinabox@testing

RUN echo 'export PS1="\w \$ "' >> /root/.bashrc

EXPOSE 4200

CMD ["shellinaboxd", "-s", "/:0:0:/root:/bin/bash", "--disable-ssl"]
