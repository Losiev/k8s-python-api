#!/bin/bash

kubectl apply -f /app/k8s/postgres/deployment.yaml
kubectl apply -f /app/k8s/postgres/service.yaml
kubectl apply -f /app/k8s/postgres/statefulset.yaml
kubectl apply -f /app/k8s/deployment.yaml
kubectl apply -f /app/k8s/service.yaml
kubectl apply -f /app/k8s/ingress.yaml
kubectl apply -f /app/k8s/configmap.yaml
kubectl apply -f /app/k8s/hpa.yaml
kubectl apply -f /app/k8s/monitoring/prometheus/prometheus-deployment.yaml
kubectl apply -f /app/k8s/monitoring/prometheus/prometheus-service.yaml
kubectl apply -f /app/k8s/monitoring/prometheus/prometheus-configmap.yaml
kubectl apply -f /app/k8s/monitoring/grafana/grafana-deployment.yaml
kubectl apply -f /app/k8s/monitoring/grafana/grafana-service.yaml
kubectl apply -f /app/k8s/monitoring/grafana/grafana-configmap.yaml
