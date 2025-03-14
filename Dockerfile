FROM golang:1.24-alpine

RUN apk update && apk upgrade && apk --no-cache add ca-certificates fdupes

COPY . /go/src/github.com/github.com/get-got/discord-downloader-go
WORKDIR /go/src/github.com/github.com/get-got/discord-downloader-go

RUN go mod download
RUN CGO_ENABLED=0 GODEBUG=http2client=0 GOOS=linux GOARCH=amd64 go build -a -o app .

FROM scratch
WORKDIR /root/
COPY /go/src/github.com/github.com/get-got/discord-downloader-go/app .

ENTRYPOINT ["./app"]
