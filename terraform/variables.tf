variable "project" {
  default  = "api-gateway"
}
variable "cluster_name" {
  default = "gw-cluster"
}
variable "region" {
  default = "asia-southeast1"
}
variable "zone" {
  default = "asia-southeast1-a"
}
variable "network" {
  default = "default"
}
variable "initial_node_count"{
  default = "3"
}
variable "machine_type" {
  # default = "n1-standard-1"
  default = "g1-small"
}
variable "disk_size" {
  default = "30"
}
variable "master_auth_username" {
  default = "tamanyan"
}
variable "master_auth_password" {
  default= "_1_love_bangkok_"
}
variable "description" {
  default = "Terraform build"
}
variable "min_master_version" {
  default = "1.10.7-gke.2"
}
variable "node_version" {
  default = "1.10.7-gke.2"
}
