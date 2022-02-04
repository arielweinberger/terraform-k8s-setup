output cluster_master_password {
  value = module.db.cluster_master_password
  sensitive = true
}

output cluster_master_username {
  value = module.db.cluster_master_username
  sensitive = true
}

output cluster_endpoint {
  value = module.db.cluster_endpoint
}