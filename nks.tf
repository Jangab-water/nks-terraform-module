resource "ncloud_nks_cluster" "nks" {
  name = "${var.root_name}-cluster"
  cluster_type = "SVR.VNKS.STAND.C002.M008.NET.SSD.B050.G002"
  login_key_name = ncloud_login_key.key.key_name
  zone = "KR-2"
  vpc_no = ncloud_vpc.vpc.vpc_no
  subnet_no_list = [ ncloud_subnet.net_prv1.id ]
  lb_private_subnet_no = ncloud_subnet.net_lb.id
}

resource "ncloud_nks_node_pool" "pool" {
  count = var.number_node_pools
  node_pool_name = "${var.root_name}-pool${count.index}"
  cluster_uuid = ncloud_nks_cluster.nks.uuid
  node_count = var.enable_auto_scaling ? 1 : var.node_counts
  product_code = "SVR.VSVR.STAND.C002.M008.NET.SSD.B050.G002"
  autoscale {
    enabled = var.enable_auto_scaling
    min = var.auto_scale["min_nodes"]
    max = var.auto_scale["max_nodes"]
  }
}

resource "ncloud_nas_volume" "nas" {
  volume_name_postfix = "nksnas"
  volume_size = 500
  volume_allotment_protocol_type = "NFS"
  zone = "KR-2"
}