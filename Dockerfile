FROM node:alpine

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true

RUN npm i -g reveal-md

USER 1000:1000

EXPOSE 1948

WORKDIR /reveal

CMD ["reveal-md", "slides.md", "--theme", "theme.css"]
