resource "ncloud_login_key" "key" {
  key_name = "${var.root_name}-key"
}

resource "ncloud_access_control_group" "acg-bastion" {
  vpc_no = ncloud_vpc.vpc.vpc_no
  name = "${var.root_name}-bastion-acg"
  description = "ACG For Bastion"
}

resource "ncloud_access_control_group_rule" "full-access" {
  access_control_group_no = ncloud_access_control_group.acg-bastion.id
  inbound {
    protocol = "TCP"
    ip_block = "0.0.0.0/0"
    port_range = "1-65535"
    description = "FullAccess"
  }
}