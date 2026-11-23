
# CloudOps Lab — DevOps CI/CD & Kubernetes Infrastructure

[![CloudOps CI Pipeline](https://github.com/1kab1/cloudops-cicd/actions/workflows/ci.yml/badge.svg)](https://github.com/1kab1/cloudops-cicd/actions/workflows/ci.yml)

A hands-on DevOps portfolio project demonstrating automated testing, containerization, container image publishing, Kubernetes orchestration, and Infrastructure as Code using Terraform.

## Tech Stack

- Python & FastAPI — REST API
- Pytest — Automated testing
- Docker — Containerization
- GitHub Actions — Continuous Integration
- GitHub Container Registry (GHCR) — Container image storage
- Kubernetes — Container orchestration and self-healing
- Terraform — Infrastructure as Code

## Architecture

Developer
   |
   v
GitHub Repository
   |
   v
GitHub Actions
   |-- Install dependencies
   |-- Run automated tests
   |-- Build Docker image
   |
   v
GitHub Container Registry
   |
   v
Terraform (manual apply)
   |
   v
Local Kubernetes Cluster
   |-- FastAPI Pod 1
   |-- FastAPI Pod 2
   |
   v
Kubernetes Service

## Features

### Automated CI Pipeline
Every push to the main branch triggers GitHub Actions to:
1. Set up Python.
2. Install dependencies.
3. Run automated tests.
4. Build a Docker image.
5. Publish the image to GHCR.

Images are tagged with both `latest` and the Git commit SHA.

### Kubernetes Deployment
- Two FastAPI replicas.
- Kubernetes Service for internal networking.
- Readiness and liveness health checks.
- Automatic replacement of deleted pods.

### Terraform Infrastructure
Terraform manages:
- Kubernetes namespace
- FastAPI Deployment
- Kubernetes Service

## Run Locally

Install dependencies:

```powershell
python -m pip install -r requirements.txt
```

Start the API:

```powershell
python -m uvicorn app.main:app --reload
```

Run tests:

```powershell
python -m pytest -v
```

## Docker

Build the image:

```powershell
docker build -t cloudops-lab:v1 .
```

Run the container:

```powershell
docker run --rm -p 8000:8000 cloudops-lab:v1
```

## Kubernetes Deployment

Apply the Kubernetes manifests:

```powershell
kubectl apply -f kubernetes/
```

Check the pods:

```powershell
kubectl get pods
```

## Terraform Deployment

Navigate to the Terraform directory:

```powershell
cd terraform
terraform init
terraform plan
terraform apply
```

Verify the deployment:

```powershell
kubectl get pods -n cloudops-lab
```

Access the application:

```powershell
kubectl port-forward -n cloudops-lab service/cloudops-service 8082:80
```

Visit http://localhost:8082/health.

## Self-Healing Demonstration

Delete a running pod:

```powershell
kubectl delete pod <pod-name> -n cloudops-lab
```

Check the pods again:

```powershell
kubectl get pods -n cloudops-lab
```

Kubernetes automatically creates a replacement pod to maintain two replicas.

## CI/CD Scope

Continuous Integration and container image publishing are automated through GitHub Actions.

Kubernetes infrastructure deployment is currently performed manually using Terraform on a local Docker Desktop cluster.

## Future Improvements

- Automated deployment to a cloud Kubernetes cluster
- Monitoring and observability with Prometheus and Grafana
- Security scanning for container images
- Automated rollback strategies
