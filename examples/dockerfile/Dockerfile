FROM golang:alpine3.7
RUN apk update && apk add --no-cache git
WORKDIR /project
RUN git clone https://github.com/jmhobbs/terminal-parrot
WORKDIR /project/terminal-parrot
RUN CGO_ENABLED=0 GOOS=linux go build -a -ldflags '-extldflags "-static"' -o /parrot parrot.go data.go draw.go
ENTRYPOINT ["/parrot"]
