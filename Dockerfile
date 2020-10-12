FROM node:10.16.3-stretch
ENV SCREEPS_VERSION 4.0.4
WORKDIR /screeps
RUN yarn add screeps@"$SCREEPS_VERSION"

FROM node:10.16.3-stretch
VOLUME /screeps
WORKDIR /screeps
ENV DB_PATH=/screeps/db.json ASSET_DIR=/screeps/assets \
        MODFILE=/screeps/mods.json GAME_PORT=21025 \
        GAME_HOST=0.0.0.0 CLI_PORT=21026 CLI_HOST=0.0.0.0 \
        STORAGE_PORT=21027 STORAGE_HOST=localhost \
        DRIVER_MODULE="@screeps/driver"\
        UID=99 \
        GID=100 \
WORKDIR /screeps
#RUN apk add --no-cache git
COPY --from=0 /screeps /screeps

COPY "docker-entrypoint.sh" /

EXPOSE 21025
EXPOSE 21026
EXPOSE 21027

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["init", "run"]
