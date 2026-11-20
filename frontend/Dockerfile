# =========================================
# Stage 1: Build the React (Vite) Application
# =========================================
ARG NODE_VERSION=24.14.0-alpine
FROM node:${NODE_VERSION} AS builder

WORKDIR /app

# Salin file konfigurasi package terkait
COPY package.json package-lock.json ./

# Install dependencies dengan npm ci dan cache mount agar proses build berikutnya sangat cepat
RUN --mount=type=cache,target=/root/.npm npm ci

# Salin seluruh kode sumber aplikasi
COPY . .

# Proses build aplikasi React/Vite (menghasilkan folder output /app/dist)
RUN npm run build


# =========================================
# Stage 2: Serve static files with Nginx
# =========================================
FROM nginx:alpine AS runner

# Ganti marker BACKEND_URL pada saat container startup
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY docker-entrypoint.d/20-backend-url.sh /docker-entrypoint.d/20-backend-url.sh
RUN chmod 0755 /docker-entrypoint.d/20-backend-url.sh
# Salin hasil build dari tahap 'builder' ke direktori web server Nginx
COPY --from=builder /app/dist /usr/share/nginx/html

# (Opsional) Jika Anda butuh kustomisasi konfigurasi Nginx untuk React Router, letakkan file nginx.conf lalu uncomment baris di bawah:
# COPY nginx.conf /etc/nginx/conf.d/default.conf

# Buka port 80 standar web
EXPOSE 80

# Jalankan Nginx
CMD ["nginx", "-g", "daemon off;"]