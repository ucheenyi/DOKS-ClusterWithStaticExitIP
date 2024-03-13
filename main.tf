provider "digitalocean" {
  token = var.do_token
}

resource "digitalocean_kubernetes_cluster" "my_cluster" {
  name     = var.cluster_name
  region   = var.region
  version  = var.k8s_version

  node_pool {
    name       = "default"
    size       = var.node_size
    node_count = var.node_count
  }
}

resource "digitalocean_floating_ip" "egress_ip" {
  droplet_id = digitalocean_kubernetes_cluster.my_cluster.id
}

resource "digitalocean_kubernetes_static_route_controller" "static_route_controller" {
  cluster_id = digitalocean_kubernetes_cluster.my_cluster.id
  egress_ip  = digitalocean_floating_ip.egress_ip.ip
}
