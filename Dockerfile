FROM alpine
#ENV clang_version=8.0.0-r0
#LABEL description="Clang Format ${clang_version}"
#RUN apk add --no-cache clang=${clang_version} git jq bash
RUN apk add --no-cache clang git jq bash
COPY .clang-format /.clang-format
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]