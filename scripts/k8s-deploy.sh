#!/bin/bash

set -e

# Define variables
CLUSTER_NAME="muchtodo-cluster"
NAMESPACE="muchtodo"

# Create kubernetes namespace
echo ">>> Creating kubernetes namespace..."
kubectl apply -f kubernetes/namespace.yaml

# Deploy database service
echo ">>> Deploying database service..."
kubectl apply -f kubernetes/mongodb

echo ">>> Checking MongoDB status..."
kubectl get pods -n $NAMESPACE -l app=mongodb

echo ">>> Waiting for MongoDB to be ready..."
kubectl wait --namespace=$NAMESPACE --for=condition=ready pod -l app=mongodb --timeout=600s || true

# Build backend docker image
echo ">>> Building backend docker image..."
./scripts/docker-build.sh

# Load docker image into kind cluster
echo ">>> Loading docker image into kind cluster..."
kind load docker-image much-to-do:latest --name $CLUSTER_NAME

# Deploy backend service
echo ">>> Deploying backend service..."
kubectl apply -f kubernetes/backend

echo ">>> Checking Backend status..."
kubectl get pods -n $NAMESPACE -l app=backend-app

echo ">>> Waiting for Backend to be ready..."
kubectl wait --namespace=$NAMESPACE --for=condition=ready pod -l app=backend-app --timeout=600s || true

# Install ingress controller
echo ">>> Installing ingress controller..."
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.11.3/deploy/static/provider/kind/deploy.yaml

echo ">>> Waiting for Ingress controller to be ready..."
kubectl wait --namespace=ingress-nginx --for=condition=ready pod -l app.kubernetes.io/component=controller --timeout=600s || true

echo ">>> Verifying webhook configuration exists..."
kubectl get validatingwebhookconfiguration ingress-nginx-admission

echo ">>> Checking Ingress controller status..."
kubectl get pods -n ingress-nginx -l app.kubernetes.io/component=controller

# Create kubernetes ingress
echo ">>> Creating kubernetes ingress..."
kubectl apply -f kubernetes/ingress.yaml

echo ">>> Checking Ingress status..."
kubectl get pods -n ingress-nginx -l app.kubernetes.io/component=controller

echo ">>> Waiting for Ingress to be ready..."
kubectl wait --namespace=ingress-nginx --for=condition=ready pod -l app.kubernetes.io/component=controller --timeout=1800s || true

echo ">>> Checking ingress status..."
kubectl get ingress -n muchtodo
kubectl describe ingress muchtodo-ingress -n muchtodo

echo ">>> Kubernetes deployment completed."