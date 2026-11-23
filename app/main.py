from datetime import datetime, timezone
from fastapi import FastAPI

app = FastAPI(title="CloudOps Lab", version="0.1.0")


@app.get("/")
def home():
    return {"service": "cloudops-lab", "message": "CloudOps Lab API is running"}


@app.get("/health")
def health():
    return {"status": "healthy"}


@app.get("/info")
def info():
    return {
        "service": "cloudops-lab",
        "version": "0.1.0",
        "timestamp": datetime.now(timezone.utc).isoformat(),
    }
