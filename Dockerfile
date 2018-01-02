FROM alpine:latest as build

RUN apk add --no-cache wget tar

WORKDIR /build
RUN wget https://cdn.rage.mp/lin/ragemp-srv.tar.gz
RUN tar -xzvf ragemp-srv.tar.gz

FROM gcc:6

WORKDIR /ragemp
COPY --from=build /build/ragemp-srv/ .
RUN chmod +x server

EXPOSE 20005
EXPOSE 22005/udp
EXPOSE 22006
CMD [ "sh", "-c", "./server" ]