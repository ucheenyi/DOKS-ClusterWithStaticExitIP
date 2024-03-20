## Required Providers
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


## Create the DOK Cluster:

resource "digitalocean_kubernetes_cluster" "doks_cluster" {
  name     = var.cluster_name
  region   = var.region
  version  = var.k8s_version
  node_pool {
    name       = var.node_name
    size       = var.node_size
    node_count = var.node_count
  }

  tags = ["doks"]
}

## Deploy the Static Route Controller:

resource "kubernetes_deployment" "static_route_controller" {
  metadata {
    name      = "uc-static-route-controller"
    namespace = "kube-system"
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "uc-static-route-controller"
      }
    }
    template {
      metadata {
        labels = {
          app = "uc-static-route-controller"
        }
      }
      spec {
        container {
          name  = "uc-static-route-controller"
          image = "quay.io/replicated/static-route-controller:latest"
          args  = ["--kubeconfig=/etc/kubernetes/admin.conf"]
        }
      }
    }
  }
}

##Configure the Static Route Controller as an Egress Gateway:

resource "kubernetes_service" "egress_gateway" {
  metadata {
    name      = "uc-egress-gateway"
    namespace = "kube-system"
  }
  spec {
    selector = {
      app = "uc-static-route-controller"
    }
    port {
      port        = 80
      target_port = 80
    }
    type = "LoadBalancer"
  }
}



