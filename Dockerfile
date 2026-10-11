FROM alpine:latest

RUN apk add --no-cache jq nginx

COPY app/init.sh /app/init.sh
RUN chmod +x /app/init.sh

CMD [ "/app/init.sh" ]
