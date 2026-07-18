FROM node:22.16.0-alpine3.21 AS deps
WORKDIR /app
COPY apps/frontend/package.json ./package.json
RUN npm install

FROM node:22.16.0-alpine3.21 AS builder
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY apps/frontend .
RUN npm run build

FROM node:22.16.0-alpine3.21 AS runner
WORKDIR /app
ENV NODE_ENV=production
COPY --from=builder /app .
EXPOSE 3000
CMD ["npm", "run", "start"]
