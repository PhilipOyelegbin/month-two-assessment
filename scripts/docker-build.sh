#!/bin/bash

set -e

echo ">>> Building Docker images..."

docker build -t philipoyelegbin/muchtodo-backend:latest .

echo ">>> Docker images built successfully."
