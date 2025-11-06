 # Hospital Management System - Kubernetes (Helm)
 
 This chart deploys the HMS frontend (Nginx) and backend (Spring Boot) with optional Ingress.
 
 ## Prerequisites
 - Kubernetes cluster
 - Ingress controller (e.g., NGINX Ingress)
 - Container registry access
 - Helm 3
 
 ## Build and push images
 Update the image repositories or export a REGISTRY variable.
 
 ```bash
 # From repo root
 REGISTRY="YOUR_REGISTRY"
 
 # Backend
 docker build -t $REGISTRY/hms-backend:latest hospital-management-system/backend
 docker push $REGISTRY/hms-backend:latest
 
 # Frontend
 docker build -t $REGISTRY/hms-frontend:latest hospital-management-system/frontend
 docker push $REGISTRY/hms-frontend:latest
 ```
 
 ## Install the chart
 
 ```bash
 helm upgrade --install hms ./deploy/helm/hms \
   --set image.backend.repository=$REGISTRY/hms-backend \
   --set image.frontend.repository=$REGISTRY/hms-frontend \
   --set ingress.enabled=true \
   --set ingress.className=nginx \
   --set ingress.host=hms.local
 ```
 
 If using TLS, also set:
 
 ```bash
 --set ingress.tls.enabled=true --set ingress.tls.secretName=hms-tls
 ```
 
 ## Access
 - Add DNS entry (or /etc/hosts) for `hms.local` to your ingress controller IP.
 - Frontend: `http://hms.local/`
 - Backend (proxied): `http://hms.local/api`
 
 ## Values
 - `replicaCount.backend|frontend`: number of pods
 - `image.*`: image repository/tag/pullPolicy
 - `service.*.type|port`: service configuration
 - `ingress.*`: ingress settings
 - `env.backend|frontend`: environment variables passed to containers

