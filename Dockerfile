# Start by building the application.
FROM docker.io/library/golang:1.19-alpine as build

WORKDIR /go/src/app
COPY . .

RUN go mod download
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags="-w -s" -o /go/bin/app.bin cmd/main.go


FROM scratch
USER 1000
WORKDIR /app
VOLUME /app/uploads
COPY --chown=1000:1000 --from=build /go/bin/app.bin /app/app.bin
COPY --chown=1000:1000 uploads /app/uploads
EXPOSE 9999

# Run
ENTRYPOINT  ["/app/app.bin"]