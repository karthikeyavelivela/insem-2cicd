 # ---------- Build stage ----------
 FROM node:18-alpine AS build
 WORKDIR /app
 
 COPY package*.json ./
 RUN npm ci --silent
 
 COPY . .
 RUN npm run build
 
 # ---------- Runtime stage ----------
 FROM nginx:alpine
 
 # Copy build output
 COPY --from=build /app/dist /usr/share/nginx/html
 
 # Expose port
 EXPOSE 80
 
 # Default nginx start
 CMD ["nginx", "-g", "daemon off;"]

