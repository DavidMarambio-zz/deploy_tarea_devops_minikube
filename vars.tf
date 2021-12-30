variable "name" {
  default = "python-project"
}

variable "app_name" {
  default = "python-project"
}

variable "namespace" {
  default = "python-project"
}

variable "docker_image" {
  default = "ghcr.io/davidmarambio/tarea_devops:latest"
}

variable "secret_key" {
  description = "Secret key de la aplicación"
}
