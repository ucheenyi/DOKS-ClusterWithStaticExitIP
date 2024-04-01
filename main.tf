module "dok-cluster" {
  source                       = "./modules/dok-cluster"
  cluster_name                 = var.cluster_name
  region                       = var.region
  k8s_version                  = var.k8s_version
  node_size                    = var.node_size
  node_count                   = var.node_count
  node_name                    = var.node_name
  uc_cluster_tag               = var.uc_cluster_tag
  static_route_controller_name = var.static_route_controller_name
  egress_gateway_name          = var.egress_gateway_name
  do_token                     = var.do_token
}




