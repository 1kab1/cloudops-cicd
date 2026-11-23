# CloudOps Lab

A beginner-friendly cloud operations portfolio project. Phase 1 implements a FastAPI service with health and info endpoints and automated tests. Future phases add Docker, GitHub Actions, Kubernetes, and Terraform.

## Prerequisites
- Python 3.10+

## Setup

```bash
python -m venv .venv
source .venv/bin/activate  # Windows PowerShell: .venv\Scripts\Activate.ps1
python -m pip install -r requirements.txt
```

## Run

```bash
python -m uvicorn app.main:app --reload
```

Visit http://127.0.0.1:8000/docs for interactive API documentation.

## Test

```bash
python -m pytest -v
```

## Endpoints
- `GET /`: basic service response
- `GET /health`: health status
- `GET /info`: service metadata and UTC timestamp
