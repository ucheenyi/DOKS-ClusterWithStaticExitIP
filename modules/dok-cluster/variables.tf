variable "do_token" {
  description = "DigitalOcean API token"
}

variable "cluster_name" {
  description = "Name of the DOKS cluster"
  type        = string
}

variable "region" {
  description = "Region where the DOKS cluster will be created"
  type        = string
}

variable "k8s_version" {
  description = "Kubernetes version for the DOKS cluster"
  type        = string
}

variable "node_size" {
  description = "Size of the worker nodes"
  type        = string
}

variable "node_count" {
  description = "Number of worker nodes in the cluster"
  type        = number
}

variable "node_name" {
  description = "Name of worker nodes in the cluster"
  type        = string
}

variable "uc_cluster_tag" {
  type        = string
  description = "Cluster Tag"
}

variable "static_route_controller_name" {
  type        = string
  description = "Static Route Controller Name"
}

variable "egress_gateway_name" {
  type        = string
  description = "Egress Gateway Name"
}

