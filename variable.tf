# Metadata
variable "region" {
    type = string
    description = "Region Value: KR, etc."
}

variable "site" {
    type = string
    description = "public | gov | fin"
}

variable "root_name" {
    type = string
    description = "Resource name prefix"
}

##################################################

# NKS node spec
variable "node_spec" {
    type = list(string)
    default = [ 
        "C002.M008",
        "C004.M016"
    ]
}

variable "node_tier" {
    type = number
    description = "Node Spec: 0=C2M8, 1=C4M16"
}

##################################################

# Node AutoScaling
variable "enable_auto_scaling" {
    type = bool
    description = ""
}

variable "node_counts" {
    type = number
    description = "Number of nodes in each pools"
}

variable "number_node_pools" {
    type = number
    description = "Number of NodePools"
}