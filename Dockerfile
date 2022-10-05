FROM golang:1.19-alpine AS builder

WORKDIR /src
COPY main.go go.mod go.sum /src/
RUN CGO_ENABLED=0 go build -trimpath -ldflags="-s -w"


FROM scratch
COPY --from=builder /src/HeatingMqttBridge /bin/HeatingMqttBridge

ENV BROKER=$server HEATING=$controller
CMD ["/bin/HeatingMqttBridge", "-env"]
