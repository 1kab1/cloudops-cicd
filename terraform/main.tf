
terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }
}

provider "kubernetes" {
  config_path = pathexpand("~/.kube/config")
}

resource "kubernetes_namespace_v1" "cloudops" {
  metadata {
    name = "cloudops-lab"
  }
}

resource "kubernetes_deployment_v1" "api" {
  metadata {
    name      = "cloudops-api"
    namespace = kubernetes_namespace_v1.cloudops.metadata[0].name
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "cloudops-api"
      }
    }

    template {
      metadata {
        labels = {
          app = "cloudops-api"
        }
      }

      spec {
        container {
          name              = "cloudops-api"
          image             = "ghcr.io/1kab1/cloudops-cicd:latest"
          image_pull_policy = "Always"
          port {
            container_port = 8000
          }

          readiness_probe {
            http_get {
              path = "/health"
              port = 8000
            }

            initial_delay_seconds = 3
            period_seconds        = 5
          }

          liveness_probe {
            http_get {
              path = "/health"
              port = 8000
            }

            initial_delay_seconds = 10
            period_seconds        = 10
          }
        }
      }
    }
  }
}

resource "kubernetes_service_v1" "api" {
  metadata {
    name      = "cloudops-service"
    namespace = kubernetes_namespace_v1.cloudops.metadata[0].name
  }

  spec {
    selector = {
      app = "cloudops-api"
    }

    port {
      port        = 80
      target_port = 8000
    }

    type = "ClusterIP"
  }
}
