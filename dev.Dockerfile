FROM elixir:1.9.1

# install build dependencies and postgres
RUN apt-get update && apt-get install -y \
    git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV MIX_ENV dev
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
# Create DB and seed test data
RUN mix ecto.setup

EXPOSE 4000

CMD ["mix", "phx.server"]