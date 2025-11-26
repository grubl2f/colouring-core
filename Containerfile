ARG NODE_IMAGE_VERSION="22-slim"
ARG NPM_CONFIG_REGISTRY=""
ARG NODE_OPTIONS="--max-old-space-size=4096"


FROM node:${NODE_IMAGE_VERSION}

ARG NPM_CONFIG_REGISTRY
ARG NODE_OPTIONS

ENV NODE_OPTIONS="${NODE_OPTIONS}"

USER node
WORKDIR /app

COPY --chown=node:node app/package.json ./
RUN rm -rf node_modules/.cache razzle-build-cache
RUN npm install --verbose
RUN npm install "cors" --legacy-peer-dep

COPY --chown=node:node app/ ./
RUN npm run build -- --noninteractive

ENV PGDATABASE=
ENV PGUSER=
ENV PGPASSWORD=
ENV PGHOST=
ENV PGPORT=
ENV APP_COOKIE_SECRET=
ENV TILECACHE_PATH=tilecache

EXPOSE 3000
CMD ["npm", "run", "start:prod"]
