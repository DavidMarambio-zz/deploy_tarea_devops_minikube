locals {
  app_labels = {
    App  = var.app_name
    Tier = "frontend"
  }
}

resource "kubernetes_namespace_v1" "namespaces" {
  metadata {
    annotations = {
      name = var.name
    }

    labels = {
      namespace = var.namespace
    }

    name = var.namespace
  }
}