# Kubernetes Python API with Monitoring 
This project sets up a Python (FastAPI) web application that works with PostgreSQL and includes monitoring configuration using Prometheus and Grafana in Kubernetes.

## Description

**This project includes:**

• FastAPI application that interacts with a PostgreSQL database. <br/>
• Docker containerization for the application. <br/>
• Kubernetes for deployment and container management. <br/>
• Monitoring setup using Prometheus and Grafana.

Install the required Python dependencies by running:
```bash
pip install -r requirements.txt
```

## Getting Started

### Step 1: Creating a cluster via kind
```
kind create cluster --name k8s-python-cluster
```
### Step 2: Create Docker File
The Dockerfile is used to build a container image for your FastAPI application. The Dockerfile should look like this:
```
ARG PYTHON_VERSION=3.8
FROM python:${PYTHON_VERSION}

WORKDIR /app

COPY app/requirements.txt .

RUN pip install --upgrade pip && \
    pip install -r requirements.txt

COPY app/ .

EXPOSE 8000

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
```
This file will:

- Install Python dependencies. <br/>
- Set the working directory inside the container. <br/>
- Expose the necessary port for FastAPI.

### Step 3: Configure Kubernetes
**1.** ConfigMaps and Secrets: Use Kubernetes `ConfigMap` to store configuration values and `Secrets` for sensitive data like database credentials.
**2.** Deploy the Application: Apply the necessary Kubernetes resources (Deployment, Service, Ingress) to run your application in the cluster. 

Run:
```
kubectl apply -f /k8s/deployment.yaml
kubectl apply -f /k8s/service.yaml
kubectl apply -f /k8s/ingress.yaml
```
Also for PostgreSQL
```
kubectl apply -f /path/to/k8s/postgres/deployment.yaml
kubectl apply -f /path/to/k8s/postgres/service.yaml
kubectl apply -f /path/to/k8s/postgres/statefulset.yaml
```

### Step 4: Run the Application
Once the deployment files are applied to Kubernetes, you can start the FastAPI application by running the following command:

### Deployment
**Build the Docker image:**
```
docker build -t k8s-python-app .
```
**Deploying container:**
```
docker run -p 8000:8000 k8s-python-app
```
### Monitoring
Monitoring is set up using Prometheus and Grafana:
• Prometheus collects metrics from your application and stores them.
• Grafana provides a dashboard to visualize the metrics.

**Apply Prometheus resources:**
```
kubectl apply -f /path/to/k8s/monitoring/prometheus/prometheus-deployment.yaml
kubectl apply -f /path/to/k8s/monitoring/prometheus/prometheus-service.yaml
kubectl apply -f /path/to/k8s/monitoring/prometheus/prometheus-configmap.yaml
```
**Apply Grafana resources:**
```
kubectl apply -f /path/to/k8s/monitoring/grafana/grafana-deployment.yaml
kubectl apply -f /path/to/k8s/monitoring/grafana/grafana-service.yaml
kubectl apply -f /path/to/k8s/monitoring/grafana/grafana-configmap.yaml
```
Access the Grafana dashboard and configure Prometheus as the data source for visualizing application metrics.

