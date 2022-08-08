# Metadata
variable "region" {
    type = string
    description = "Region Value: KR, etc."
    default = "KR"
}

variable "site" {
    type = string
    description = "public | gov | fin"
    default = "public"
}

variable "root_name" {
    type = string
}
##################################################

# NKS node spec
variable "node_spec" {
    type = list(string)
    default = [ 
        "C002.M008",
        "C004.M016",
        "C008.M032"
    ]
}

variable "node_tier" {
    type = number
    description = "Node Spec: 0=C2M8, 1=C4M16, 2=C8M32"
}
##################################################

# Node AutoScaling
variable "enable_auto_scaling" {
    type = bool
    description = "Enable node autoscaling"
    default = false
}

variable "node_counts" {
    type = number
    description = "Number of nodes in each pools"
    default = 2
}

variable "number_node_pools" {
    type = number
    description = "Number of NodePools"
    default = 1
}

variable "auto_scale" {
    type = map(number)
    description = "Number of nodes in NodeAutoScaling"
    default = {
        min_nodes = "1"
        max_nodes = "3"
    }
}