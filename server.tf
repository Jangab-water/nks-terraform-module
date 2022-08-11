resource "ncloud_login_key" "key" {
  key_name = "${var.root_name}-key"
}

resource "ncloud_access_control_group" "acg_full_access" {
  vpc_no = ncloud_vpc.vpc.vpc_no
  name = "${var.root_name}-bastion-acg"
  description = "ACG For Bastion"
}

resource "ncloud_access_control_group_rule" "full-access" {
  access_control_group_no = ncloud_access_control_group.acg_full_access.id
  inbound {
    protocol = "TCP"
    ip_block = "0.0.0.0/0"
    port_range = "1-65535"
    description = "FullAccess"
  }
}

resource "ncloud_network_interface" "server_nic_default" {
  subnet_no = ncloud_subnet.net_pub1.id
  access_control_groups = [
    ncloud_access_control_group.acg_full_access.id
  ]
  name = "${var.root_name}-nic"
}

resource "ncloud_server" "init_test" {
  name = "${var.root_name}-server"
  server_image_product_code = "SW.VSVR.OS.LNX64.CNTOS.0708.B050"
  server_product_code = "SVR.VSVR.HICPU.C002.M004.NET.HDD.B050.G002"
  subnet_no = ncloud_subnet.net_pub1.id
  zone = "KR-2"
  login_key_name = ncloud_login_key.key.key_name
  init_script_no = ncloud_init_script.init.id
  network_interface {
    network_interface_no = ncloud_network_interface.server_nic_default.id
    order = 0
  }
}

resource "ncloud_public_ip" "public_ip" {
  server_instance_no = ncloud_server.init_test.id
}

resource "ncloud_init_script" "init" {
  name = "${var.root_name}-init"
  content = <<-EOF
  #!/bin/bash

  echo "root:elelats"|chpasswd
  EOF
}

output "server_public_id" {
  sensitive = false
  value = ncloud_public_ip.public_ip.public_ip
}