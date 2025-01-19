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
### Directory Structure
```
k8s-python-api/
│
├── app/                 
│   ├── main.py          
│   └── db.py             
├── k8s/                  
│   ├── postgres/        
│   ├── monitoring/       
│   ├── deployment.yaml   
│   ├── service.yaml      
│   ├── hpa.yaml         
│   ├── ingress.yaml      
│   ├── secret.yaml      
│   └── configmap.yaml  
├── Dockerfile            
├── requirements.txt     
└── README.md            
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

COPY bootstrap.sh /app/bootstrap.sh
RUN chmod +x /app/bootstrap.sh

EXPOSE 8000

CMD ["/bin/bash", "-c", "/app/bootstrap.sh && uvicorn main:app --host 0.0.0.0 --port 8000"]
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
Monitoring is set up using Prometheus and Grafana:<br/>
• Prometheus collects metrics from your application and stores them.<br/>
• Grafana provides a dashboard to visualize the metrics.

### Configuring Prometheus to collect metrics
**Prometheus installation using Helm:**
```
helm install prometheus prometheus-community/kube-prometheus-stack --namespace monitoring --create-namespace
```
**Checking if Prometheus works:**
Make sure all Prometheus components are running:
```
kubectl get pods -n monitoring
```

**Access to Prometheus:**

To access the Prometheus interface through a browser, use port-forwarding:
```
kubectl port-forward -n monitoring svc/prometheus-kube-prometheus-prometheus 9090:9090
```
For grafana we doing same steps of instalation and port-forwarding:
```
helm install grafana prometheus-community/grafana --namespace monitoring
kubectl get pods -n monitoring
kubectl port-forward -n monitoring svc/grafana 3000:80
```
Now you can go to http://localhost:3000 to get into Grafana.

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

