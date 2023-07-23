# build stage
FROM node:16 as build-env
COPY package.json /usr/src/www/package.json
WORKDIR /usr/src/www
RUN npm --registry https://registry.npm.taobao.org install
COPY . /usr/src/www/

RUN sh -c "npm run build"

# final stage
FROM nginx:1.13
COPY --from=build-env /usr/src/www/dist /usr/share/nginx/html