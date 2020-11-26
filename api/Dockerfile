FROM golang:1.14 as builder

ENV GO111MODULE=on

WORKDIR /api

COPY go.mod .
COPY go.sum .

RUN go mod download

COPY . /api

# Building final binary
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build

FROM scratch

COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /api/api .

EXPOSE 8080
ENTRYPOINT ["/api"]
