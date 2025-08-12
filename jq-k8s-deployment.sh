#!/bin/bash

# JQ patterns for extracting information from Kubernetes deployment

echo "JQ Patterns for Kubernetes Deployment"

# a. Extract current replica count
echo "Current replica count: $(jq '.spec.replicas' deployment.json)"

# b. Extract deployment strategy
echo "Deployment strategy: $(jq -r '.spec.strategy.type' deployment.json)"

# c. Extract service and environment labels concatenated with hyphen
echo "Service-Environment concatenation: $(jq -r '(.metadata.labels.service + "-" + .metadata.labels.environment)' deployment.json)"