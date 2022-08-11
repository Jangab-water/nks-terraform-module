##### General Settings #####
region = "KR"
site = "public"
node_spec = [ "C002.M008", "C004.M016" ] # STAND



##### Individual Settings #####
### Resource name prefix
root_name = "ts-rjh"


### Node spec indicator.
# 0 = 2 vCPU | 8G Memory
# 1 = 4 vCPU | 16G Memory
node_tier = 0

### Enable cluster autoscaling
# `true` of `false`
# if cluster autoscaling is enabled, `min_nodes=1` and `max_nodes=var.node_counts`
enable_auto_scaling = false

### Decide number of max nodes in each node pools
node_counts = 1

# Decide number of node pools
number_node_pools = 1