VERSION 0.6
FROM elixir:1.13.4-slim
WORKDIR "/app"
RUN apt-get update -y && apt-get install -y build-essential && apt-get clean && rm -f /var/lib/apt/lists/*_*
RUN mix local.hex --force && mix local.rebar --force
RUN mkdir config
COPY mix.exs mix.lock ./
COPY config/config.exs config/
SAVE IMAGE --cache-hint

lint:
    ENV MIX_ENV="dev"
    RUN mkdir -p priv/plts
    COPY config/$MIX_ENV.exs config/
    RUN mix do deps.get --only $MIX_ENV, deps.compile
    # RUN mix dialyzer --plt
    COPY lib lib
    COPY .credo.exs .formatter.exs ./
    RUN mix format --check-formatted
    RUN mix credo
    # RUN mix dialyzer --format dialyxir
    RUN mix sobelow
    SAVE IMAGE --cache-hint

test:
    ENV MIX_ENV="test"
    ENV POSTGIS_VERSION="14-3.2-alpine"
    COPY config/$MIX_ENV.exs config/
    RUN mix do deps.get --only $MIX_ENV, deps.compile
    COPY lib lib
    RUN mix compile
    COPY test test
    COPY priv priv
    WITH DOCKER --pull postgis/postgis:$POSTGIS_VERSION
        RUN docker run \
         --name postgres \
         -e POSTGRES_PASSWORD=postgres \
         -p 5432:5432 \
         -d postgis/postgis:$POSTGIS_VERSION \
         && while !(docker exec postgres pg_isready --host=localhost --port=5432 --quiet); do sleep 1; done; mix test
    END
    SAVE IMAGE --cache-hint

build:
    ENV MIX_ENV="prod"
    COPY config/config.exs config/$MIX_ENV.exs config/
    RUN mix do deps.get --only $MIX_ENV, deps.compile
    COPY priv priv
    COPY lib lib
    RUN mix compile --warnings-as-errors
    COPY config/runtime.exs config/
    COPY rel rel
    RUN mix release
    SAVE ARTIFACT /app/_build/${MIX_ENV}/rel/crea_graphy
    SAVE IMAGE --cache-hint

docker:
    FROM debian:bullseye-slim
    RUN apt-get update && apt-get upgrade -y
    RUN apt-get install -y libstdc++6 openssl libncurses5 locales && apt-get clean && rm -f /var/lib/apt/lists/*_*
    RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && locale-gen
    ENV LANG="en_US.UTF-8"
    ENV LANGUAGE="en_US:en"
    ENV LC_ALL="en_US.UTF-8"
    ENV MIX_ENV="prod"
    ENV POOL_SIZE="20"
    ENV DATABASE_URL="ecto://{user}:{password}@{host}/postgres"
    ENV RELEASE_COOKIE="{secret}"
    ENV SECRET_KEY_BASE="{secret}"
    ENV PHX_HOST="{domain}"
    WORKDIR "/app"
    RUN chown nobody /app
    COPY --chown nobody:root +build/* .
    RUN chmod +x bin/migrate bin/server bin/start
    USER nobody
    EXPOSE 4000
    CMD ["/app/bin/start"]
    ARG IMAGE="royalmist/creapi"
    ARG TAG="latest"
    SAVE IMAGE --push $IMAGE:$TAG
