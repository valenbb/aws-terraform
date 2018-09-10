variable "aws_region" {
  description = "The AWS region to create things in."
  default     = "us-east-1"
}

variable "instance_type" {
  description = "Desired instance type for EC2"
  default = "t2.medium"
}

# CentOS 7 AMI
variable "aws_ami" {
  description = "Image Id"
  default = "ami-0eaf7f3ca4d177abb"
}

variable "key_name" {
  description = "Desired name of AWS key pair"
  default = "terraform"
}

variable "vpc_prod_id" {
  description = "Production VPC ID"
  default = "vpc-ce4b4eb5"
}

variable "subnet_id" {
  description = "Subnet ID to use"
  default = "subnet-07f4345b"
}

variable "ssh_cidr_access" {
  type = "list"
  description = "CIDR of originating traffic"
  default = ["10.0.1.244/32", "100.4.210.205/32", "165.225.38.216/32"]
}

variable "web_cidr_access" {
  type = "list"
  description = "CIDR of originating traffic"
  default = ["100.4.210.205/32", "165.225.38.216/32"]
}

variable "az_id" {
  description = "Availability Zone"
  default = "us-east-1b"
}

variable "public_ip" {
  description = "Associate ec2 instance wth Public IP"
  default = false
}

variable "tag_name" {
  description = "Name tag value"
  default = "TEST-SERVER"
}


variable "tag_owner" {
  description = "Owner tag value"
  default = "Andy Lalla"
}

variable "tag_env" {
  description = "Environment tag value"
  default = "DEV"
}

variable "tag_builder" {
  description = "Provisioning tool tag value"
  default = "Terraform"
}

variable "chef_server_url" {
  description = "Chef Server URL"
  default = "https://10.0.1.244/organizations/esn2"
}

variable "chef_server_user_name" {
  description = "Account to login to Chef Server"
  default = "terraform"
}

variable "chef_server_user_key" {
  description = "Chef user account private key"
  default = "/var/lib/jenkins/.chef/terraform.pem"
}

variable "server_user" {
  description = "User account on server"
  default = "centos"
}

variable "ssh_key_filename" {
  description = "Server user account private key"
  default = "/var/lib/jenkins/.ssh/terraform.pem"
}

variable "ssl_verify_mode" {
  description = "Verify SSL on connection to chef server"
  default = ":verify_none"
}

variable "run_list" {
  type = "list"
  description = "List of chef recipet to lay down on server"
  default = ["apache::default"]
}

variable "chef_environment" {
  description = "Chef environment"
  default = "_default"
}

variable "connection_type" {
  description = "protocol to connect to AWS server"
  default = "ssh"
}

variable "local_backend" {
  description = "use another location on local disk"
  default = "/var/lib/jenkins/terraform_states"
}
