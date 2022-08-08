# Create VPC
resource "ncloud_vpc" "vpc" {
  ipv4_cidr_block = "10.0.0.0/16"
  name = "${var.root_name}-vpc"
}

# Porivison Each Subnet
resource "ncloud_subnet" "net_pub1" {
  name = "${var.root_name}-net-pub1"
  vpc_no = ncloud_vpc.vpc.vpc_no
  subnet = "10.0.0.0/24"
  zone = "KR-2"
  network_acl_no = ncloud_vpc.vpc.default_network_acl_no
  subnet_type = "PUBLIC"
  usage_type = "GEN"
}

resource "ncloud_subnet" "net_prv1" {
  name = "${var.root_name}-net-prv1"
  vpc_no = ncloud_vpc.vpc.vpc_no
  subnet = "10.0.100.0/24"
  zone = "KR-2"
  network_acl_no = ncloud_vpc.vpc.default_network_acl_no
  subnet_type = "PRIVATE"
  usage_type = "GEN"
}

resource "ncloud_subnet" "net_lb" {
  name = "${var.root_name}-net-lb"
  vpc_no = ncloud_vpc.vpc.vpc_no
  subnet = "10.0.200.0/24"
  zone = "KR-2"
  network_acl_no = ncloud_vpc.vpc.default_network_acl_no
  subnet_type = "PRIVATE"
  usage_type = "LOADB"
}

# Create NAT Gateway & NAT Rule
resource "ncloud_nat_gateway" "nat" {
  name = "${var.root_name}-nat"
  vpc_no = ncloud_vpc.vpc.vpc_no
  zone = "KR-2"
}

resource "ncloud_route" "nat-rt-table" {
  route_table_no = ncloud_vpc.vpc.default_private_route_table_no
  destination_cidr_block = "0.0.0.0/0"
  target_type = "NATGW"
  target_name = ncloud_nat_gateway.nat.name
  target_no = ncloud_nat_gateway.nat.nat_gateway_no
}