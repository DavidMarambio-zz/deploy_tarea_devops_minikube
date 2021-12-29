resource "kubernetes_service" "app-service" {
  metadata {
    name      = "${var.app_name}-service"
    namespace = resource.kubernetes_namespace_v1.namespaces.metadata[0].name
  }
  spec {
    selector = local.app_labels
    port {
      protocol = "TCP"
      port        = 8000
      target_port = 8000
      node_port   = 31200
    }
    type = "NodePort"
  }
}
