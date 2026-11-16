# =========================================
# Production Dockerfile untuk Backend Express
# =========================================

ARG NODE_VERSION=20-alpine
FROM node:${NODE_VERSION} AS runner

# Tentukan direktori kerja di dalam container
WORKDIR /app

# Set environment variable ke production
ENV NODE_ENV=production

# Salin file package terkait terlebih dahulu
COPY package.json package-lock.json ./

# Install dependencies khusus production (tanpa devDependencies) dengan cache mount agar build cepat
RUN --mount=type=cache,target=/root/.npm npm ci --omit=dev

# Salin seluruh sisa kode ke dalam container sekaligus berikan hak akses ke user 'node'
COPY --chown=node:node . .

# Jalankan container sebagai non-root user untuk keamanan tingkat lanjut (Security Best Practice)
USER node

# Buka port backend (sesuaikan dengan aplikasi Anda, misal 5000)
EXPOSE 5000

# Jalankan langsung file utama menggunakan node (bukan npm start) untuk graceful shutdown yang baik
CMD ["node", "src/server.js"]