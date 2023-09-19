FROM --platform=linux/amd64 golang:1.19

WORKDIR /app
COPY go.mod ./
RUN go mod download

COPY *.go ./

RUN CGO_ENABLED=0 GOOS=linux go build -o /migrate-images

CMD ["/migrate-images"]

EXPOSE 8080