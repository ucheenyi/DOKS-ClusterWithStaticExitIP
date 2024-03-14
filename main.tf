

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
  region   = var.region
  

}

# Creating Static Route Controller: DigitalOcean provider does not support the resource type “digitalocean_kubernetes_static_route_controller”. This means that you cannot create a static route controller directly using the DigitalOcean provider in Terraform.
/*
Manual Configuration:
Instead of using Terraform, you can manually configure the static route controller within your Kubernetes cluster.
This involves creating the necessary Kubernetes resources (such as ConfigMaps, Deployments, or DaemonSets) 
directly using kubectl or other Kubernetes management tools.
*/

#Terraform Code for Creating Static Route Controller
/*
resource "digitalocean_kubernetes_static_route_controller" "static_route_controller" {
  cluster_id = digitalocean_kubernetes_cluster.my_cluster.id
  egress_ip  = digitalocean_floating_ip.egress_ip.ip
}
*/
