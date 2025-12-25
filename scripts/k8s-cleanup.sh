#!/bin/bash

set -e

# Define variables
CLUSTER_NAME="muchtodo-cluster"

# Delete kubernetes ingress
echo ">>> Deleting kubernetes ingress..."
kubectl delete -f kubernetes/ingress.yaml

# Delete backend service
echo ">>> Deleting backend service..."
kubectl delete -f kubernetes/backend

# Delete database service
echo ">>> Deleting database service..."
kubectl delete -f kubernetes/mongodb

# Delete kubernetes namespace
echo ">>> Deleting kubernetes namespace..."
kubectl delete -f kubernetes/namespace.yaml

# Delete kind cluster
echo ">>> Deleting kind cluster..."
kind delete cluster --name $CLUSTER_NAME

echo ">>> Kubernetes cleanup completed."