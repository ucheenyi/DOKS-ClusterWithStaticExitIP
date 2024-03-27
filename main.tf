
data "digitalocean_kubernetes_cluster" "uc-cluster-details" {
  name = digitalocean_kubernetes_cluster.doks_cluster.name
}


resource "digitalocean_kubernetes_cluster" "doks_cluster" {
  name    = var.cluster_name
  region  = var.region
  version = var.k8s_version

  node_pool {
    name       = var.node_name
    size       = var.node_size
    node_count = var.node_count
  }

  tags = [var.uc_cluster_tag]
}

resource "kubernetes_deployment" "static_route_controller" {
  metadata {
    name = format("uc-%s", var.static_route_controller_name)

    namespace = "kube-system"
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = format("uc-%s", var.static_route_controller_name)
      }
    }

    template {
      metadata {
        labels = {
          app = format("uc-%s", var.static_route_controller_name)
        }
      }

      spec {
        container {
          name  = format("uc-%s", var.static_route_controller_name)
          image = "hashicraft/minecraft:v1.16.3"
          args  = ["--kubeconfig=/etc/kubernetes/admin.conf"]
        }
      }
    }
  }
}

resource "kubernetes_service" "egress_gateway" {
  metadata {
    name      = format("uc-%s", var.egress_gateway_name)
    namespace = "kube-system"
  }

  spec {
    selector = {
      app = format("uc-%s", var.static_route_controller_name)
    }

    port {
      port        = 80
      target_port = 80
    }

    type = "LoadBalancer"
  }
}
