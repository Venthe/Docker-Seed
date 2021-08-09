FROM node:16.6.1-alpine AS builder

WORKDIR /opt/web
RUN npm install --global @angular/cli@12.2.0
COPY package.json package-lock.json ./
# --mount=type=cache,target=/home/gradle/.gradle 
RUN npm ci
# ENV PATH="./node_modules/.bin:$PATH"
COPY . ./
RUN ng build

FROM nginx:1.21.1-alpine
COPY --from=builder /opt/web/dist/client /usr/share/nginx/html

