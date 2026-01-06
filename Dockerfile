FROM golang:1.24-alpine

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o parcel-tracker main.go parcel.go

COPY tracker.db .

CMD ["./parcel-tracker"]
