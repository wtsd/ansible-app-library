variable "project"   { type = string }
variable "region"    { type = string }
variable "zone"      { type = string }
variable "network"   { type = string }
variable "subnetwork"{ type = string }
variable "image"     { type = string  default = "projects/centos-cloud/global/images/centos-7-v20230912" }
variable "machine_type" { type = string default = "e2-medium" }
variable "name"      { type = string  default = "ansible-app" }
variable "env"       { type = string  default = "dev" }
variable "ssh_user"  { type = string  default = "centos" }
variable "public_key_path" { type = string }
