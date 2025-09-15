variable "region"        { type = string }
variable "vpc_id"        { type = string }
variable "subnet_id"     { type = string }
variable "ami_id"        { type = string }
variable "instance_type" { type = string  default = "t3.micro" }
variable "name"          { type = string  default = "ansible-app" }
variable "env"           { type = string  default = "dev" }
variable "key_name"      { type = string  default = "ansible-app-key" }
variable "public_key_path" { type = string }
variable "ansible_user"  { type = string  default = "ec2-user" }
