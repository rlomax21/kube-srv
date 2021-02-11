FROM alpine:3.10
RUN apk update
RUN apk add curl
RUN curl -LO "https://storage.googleapis.com/kubernetes-release/release/v1.20.2/bin/linux/amd64/kubectl"
RUN install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
RUN touch ips.txt
COPY "conf.d/scripts/entrypoint.sh" .
RUN chmod 777 entrypoint.sh
ENTRYPOINT ["./entrypoint.sh"]
