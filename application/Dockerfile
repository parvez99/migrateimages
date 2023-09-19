FROM golang

WORKDIR /app
COPY go.mod ./
RUN go mod download

COPY *.go ./
RUN go mod tidy
RUN go build -o /migrate-images

CMD ["/migrate-images"]

EXPOSE 8080