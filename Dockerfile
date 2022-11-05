FROM golang:1.19-alpine AS builder

WORKDIR /src
COPY main.go go.mod go.sum /src/
RUN CGO_ENABLED=0 go build -trimpath -ldflags="-s -w"


FROM scratch
COPY --from=builder /src/HeatingMqttBridge /bin/HeatingMqttBridge

ENV BROKER=$(bashio::services 'mqtt' 'host') BROKER_USER=$(bashio::services 'mqtt' 'username') BROKER_PSW=$(bashio::services 'mqtt' 'password') HEATING=$(bashio::config 'roth.controller')
CMD /bin/HeatingMqttBridgegit BROKER=$(bashio::services 'mqtt' 'host') BROKER_USER=$(bashio::services 'mqtt' 'username') BROKER_PSW=$(bashio::services 'mqtt' 'password') HEATING=192.168.0.20
