variable "access_key" {
  description = "Enter your access key"
}
variable "secret_key" {
  description = "Enter your secret key"
}

variable "cidr_vpc" {
  description = "cidr block for VPC"
}

variable "cidr_sub" {
  description = "cidr block for subnet"
}
variable "az" {
  description = "Enter avaibility zone"
}

variable "instance_type" {
  description = "Enter Instance type"
}

variable "ami_id" {
  description = "Enter ami id"
}

variable "cidr_rt" {
  description = "cidr block for route table"
}