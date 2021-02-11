FROM alpine:3.10
EXPOSE 80
RUN apk update
RUN apk add nginx
RUN mkdir /run/nginx
COPY "conf.d/nginx/nginx.conf" "/etc/nginx/nginx.conf"
ENTRYPOINT ["nginx"]
CMD ["-g","daemon off;"]
