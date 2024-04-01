terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}


provider "digitalocean" {
  token = var.do_token
}

provider "kubernetes" {
  host  = data.digitalocean_kubernetes_cluster.uc-cluster-details.endpoint
  token = data.digitalocean_kubernetes_cluster.uc-cluster-details.kube_config[0].token
  cluster_ca_certificate = base64decode(
    data.digitalocean_kubernetes_cluster.uc-cluster-details.kube_config[0].cluster_ca_certificate
  )
}

data "digitalocean_kubernetes_cluster" "uc-cluster-details" {
  name = digitalocean_kubernetes_cluster.doks_cluster.name
}
