FROM node:12 as build

COPY . /opt
WORKDIR /opt

RUN npm config set registry https://registry.npmmirror.com \
    && npm install \
    && npm run build

FROM nginx:1.21

COPY docker/nginx.k8s.conf /etc/nginx/conf.d/default.conf

COPY --from=build /opt/dist /opt/dist

