resource "kubernetes_role_v1" "role" {
  metadata {
    name      = "tiller-manager"
    namespace = resource.kubernetes_namespace_v1.namespaces.metadata[0].name
  }

  rule {
    api_groups = ["", "batch", "extensions", "apps"]
    resources  = ["*"]
    verbs      = ["*"]
  }
}
