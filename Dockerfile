FROM alpine:3.9
RUN apk add --update bash openssl

RUN mkdir /app
WORKDIR /app

COPY _build/prod/rel/account_api/ ./
RUN ls
# RUN chown -R nobody: /app
# USER nobody

# ENV HOME=/app