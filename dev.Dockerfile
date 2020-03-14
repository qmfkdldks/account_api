FROM elixir:1.9.1

# install build dependencies and postgres
RUN apt-get update && apt-get install -y \
    git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ARG DB_HOST
ENV DB_HOST $DB_HOST

ARG DB_USER
ENV DB_USER $DB_USER

ARG DB_PASSWORD
ENV DB_PASSWORD $DB_PASSWORD

ENV MIX_ENV dev
ENV APP_HOME /app

RUN mix do local.hex --force, local.rebar --force

# Create app folder
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME
COPY . /app

# Add wait-for-it
RUN chmod +x ./wait-for-it.sh

# Clone account core dependency
RUN git submodule update --init --recursive

# Install dependencies
RUN mix deps.get
# Compile all dependencies
RUN mix deps.compile
# Compile the entire project
RUN mix compile

EXPOSE 4000

CMD ["mix", "phx.server"]