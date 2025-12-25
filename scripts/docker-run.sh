#!/bin/bash

set -e

echo ">>> Starting Docker containers..."

docker compose up --build -d

echo ">>> Docker containers are up and running."