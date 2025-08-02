# Etapa de build
FROM node:20 AS builder
WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

# Etapa de produção com NGINX
FROM nginx:alpine
COPY --from=builder /app/dist/simplehr-frontend /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
