FROM elixir:1.9.1-alpine as build

# install build dependencies
RUN apk add --update git build-base

ENV MIX_ENV prod
ENV APP_HOME /app

RUN mix do local.hex --force, local.rebar --force

# Create app folder
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME
COPY . /app

# Clone account core dependency
RUN git submodule update --init --recursive

# Install dependencies
RUN mix deps.get

# Compile all dependencies
RUN mix deps.compile
# Compile the entire project
RUN mix compile

# build release (uncomment COPY if rel/ exists)
# COPY rel rel
RUN mix release

# prepare release image
FROM alpine:3.9 AS app
RUN apk add --update bash openssl

RUN mkdir /app
WORKDIR /app

COPY --from=build /app/_build/prod/rel/account_api ./
RUN chown -R nobody: /app
USER nobody

ENV HOME=/app

EXPOSE 4000

CMD ["/app/bin/account_api", "start"]