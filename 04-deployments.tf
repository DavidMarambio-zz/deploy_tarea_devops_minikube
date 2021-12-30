resource "kubernetes_deployment" "app" {
  metadata {
    name      = var.app_name
    namespace = resource.kubernetes_namespace_v1.namespaces.metadata[0].name
    labels    = local.app_labels
  }
  spec {
    replicas = 1
    selector {
      match_labels = local.app_labels
    }
    template {
      metadata {
        labels = local.app_labels
      }
      spec {
        container {
          image   = var.docker_image
          name    = var.app_name
          command = ["/bin/sh", "-c", "python manage.py runserver 0.0.0.0:8000"]
          port {
            container_port = 8000
          }
          env {
            name = "SECRET_KEY"
            value_from {
              secret_key_ref {
                name = var.app_name
                key  = "SECRET_KEY"
              }
            }
          }
        }
      }
    }
  }
}
