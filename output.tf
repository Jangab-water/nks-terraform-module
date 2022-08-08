output "cluster_uuid" {
  sensitive = false
  value = ncloud_nks_cluster.nks.uuid
}