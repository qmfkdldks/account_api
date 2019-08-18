FROM elixir:1.9.1

ARG DB_USER
ARG DB_PASSWORD
ARG DB_NAME
ARG DB_HOST
ARG DB_PORT
ARG APP_PORT
ARG APP_HOSTNAME
ARG SECRET_KEY_BASE
ARG AUTH_SECRET_KEY

ENV DB_USER ${DB_USER}
ENV DB_PASSWORD ${DB_PASSWORD}
ENV DB_NAME ${DB_NAME}
ENV DB_HOST ${DB_HOST}
ENV DB_PORT ${DB_PORT}
ENV APP_PORT ${APP_PORT}
ENV APP_HOSTNAME ${APP_HOSTNAME}
ENV SECRET_KEY_BASE ${SECRET_KEY_BASE}
ENV AUTH_SECRET_KEY ${AUTH_SECRET_KEY}

ENV MIX_ENV prod
ENV APP_HOME /app

EXPOSE $APP_PORT

RUN mix do local.hex --force, local.rebar --force

# create app folder
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME
COPY . /app

# install dependencies
RUN mix deps.get --only prod
# Compile all dependencies
RUN mix deps.compile
# Compile the entire project
RUN mix compile

CMD ["mix", "phx.server"]