FROM golang:1.24.4

WORKDIR /app

COPY go.mod ./
RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /main main.go parcel.go

FROM alpine:latest

WORKDIR /root/

COPY --from=builder /main .
COPY tracker.db .

CMD ["./main"]
