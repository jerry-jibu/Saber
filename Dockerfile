FROM jibutech-registry.cn-hangzhou.cr.aliyuncs.com/ys1000/node:12 as build

COPY . /opt
WORKDIR /opt

RUN npm config set registry https://registry.npmmirror.com \
    && npm install \
    && npm run build

#FROM nginx:1.21
FROM registry.cn-shanghai.aliyuncs.com/jibutech/nginx:1.23.3-debian-11-r15

COPY docker/nginx.k8s.conf /etc/nginx/conf.d/default.conf

COPY --from=build /opt/dist /opt/dist

