# Month 2 Assessment

## Assessment Scenario

You've been hired as a DevOps engineer at StartupTech, and your first task is to containerize their existing backend application **MuchTodo**. The development team has been running the application directly on servers, but they want to modernize their deployment using containers and Kubernetes for better scalability and management.

The backend application is a Golang API that connects to a MongoDB database. Your job is to:

1. Create a proper Docker setup for local development using **docker-compose**
2. Deploy the application to a local Kubernetes cluster using **Kind**

## Application Overview

Here’s the github [repository](https://github.com/Innocent9712/much-to-do/tree/feature/backend-only) containing containing:

- **Backend API:** Golang application
- **Database:** MongoDB for data storage
- **Configuration:** Environment variables for database connection
- **Dependencies:** Package.jso

**Application Requirements:**

- The backend API runs on port 8080
- Connects to MongoDB database
- Requires environment variables for configuration
- Includes health check endpoint at `/health`
- Has basic CRUD operations for user management

## Technical Requirements

**Phase 1: Docker Setup**

1. **Dockerfile Creation**
   Create an optimized Dockerfile for the backend application that:

   - Uses appropriate golang base image
   - Implements multi-stage build for optimization
   - Sets up non-root user for security
   - Copies only necessary files
   - Installs dependencies efficiently
   - Exposes correct port
   - Implements proper health check
   - Uses best practices for caching and security

2. **Docker Compose Configuration**
   Create a `docker-compose.yml` file that:

   - Runs the backend application container
   - Runs MongoDB container with persistent data
   - Sets up proper networking between containers
   - Configures environment variables
   - Implements proper dependency ordering
   - Includes volume mounts for data persistence
   - Sets up development-friendly configurations (auto-restart, etc.)

**Phase 2: Kubernetes Deployment**

1. **Kubernetes Manifests**

   Create Kubernetes YAML manifests for:

   **MongoDB Deployment:**

   - Deployment with replica count of 1
   - Persistent Volume Claim for data storage
   - ConfigMap for MongoDB configuration
   - Secret for database credentials
   - Service for internal communication

   **Backend Application Deployment:**

   - Deployment with replica count of 2
   - ConfigMap for application configuration
   - Secret for sensitive configuration
   - Resource limits and requests
   - Health check probes (liveness and readiness)
   - Service to expose the application

   **Ingress Configuration:**

   - Ingress resource to expose the backend API
   - Proper path routing to the backend service

2. **Local Kubernetes Setup**

   - Use Kind (Kubernetes in Docker) for local deployment
   - Create cluster configuration if needed
   - Deploy all components to the cluster
   - Verify application accessibility

## Submission Requirements

You would be provided with the application repository, which you will fork and make modifications to.

**Required Files Structure:**

```
container-assessment/
├── <application-code>
├── Dockerfile
├── docker-compose.yml
├── .dockerignore
├── kubernetes/
│ ├── namespace.yaml
│ ├── mongodb/
│ │ ├── mongodb-secret.yaml
│ │ ├── mongodb-configmap.yaml
│ │ ├── mongodb-pvc.yaml
│ │ ├── mongodb-deployment.yaml
│ │ └── mongodb-service.yaml
│ ├── backend/
│ │ ├── backend-secret.yaml
│ │ ├── backend-configmap.yaml
│ │ ├── backend-deployment.yaml
│ │ └── backend-service.yaml
│ └── ingress.yaml
├── scripts/
│ ├── docker-build.sh
│ ├── docker-run.sh
│ ├── k8s-deploy.sh
│ └── k8s-cleanup.sh
└── README.md
```

1. **Docker Configuration**
   - `Dockerfile`: Optimized multi-stage Dockerfile
   - `docker-compose.yml`: Complete local development setup
   - `.dockerignore`: Appropriate files and folders to ignore
2. **Kubernetes Manifests**
   - **Namespace**: Dedicated namespace for the application
   - **MongoDB Resources**: Complete MongoDB deployment with persistence
   - **Backend Resources**: Complete backend application deployment
   - **Ingress**: Proper ingress configuration for external access
3. **Automation Scripts**
   - `docker-build.sh`: Script to build Docker images
   - `docker-run.sh`: Script to run with docker-compose
   - `k8s-deploy.sh`: Script to deploy to Kubernetes
   - `k8s-cleanup.sh`: Script to clean up Kubernetes resources
4. **Documentation**
   - `README.md`: Comprehensive setup and deployment instructions
5. **Deployment Evidence**

   Create an `evidence/` folder with screenshots of:

   - Docker build process completion
   - Docker compose running successfully
   - Application responding via docker-compose
   - Kind cluster creation
   - Kubernetes deployments running
   - Application accessible through a NodePort Service type to the host or Kubernetes ingress.
   - Kubectl commands showing pod status, services, and ingress
