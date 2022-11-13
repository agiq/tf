variable "vpc_cidr_block" {
    # default = "10.0.0.0/16"
    description = "CIDR Block for the VPC"
    type = string
}

variable "web_subnet" {
    # default = "10.0.10.0/24"
    description = "Web Subnet"
    type = string
}

variable "subnet_zone" {
  
}

variable "main_vpc_name" {
  
}

variable "my_public_ip" {
  
}

variable "ssh_public_key" {
  
}

variable "web_port" {
  description = "Web Port"
  default = 80
  type = number
}

variable "aws_region" {
  description = "AWS Region"
  type = string
  default = "us-east-1"
}

variable "availability_zone" {
  description = "AWS Northern Virginia AZ"
  type = list(string)
  default = [
    "us-east-1a",
    "us-east-1b",
    "us-east-1c",
    "us-east-1d",
    "us-east-1e",
    "us-east-1f"
    ]
}

variable "enable_dns" {
  description = "DNS support for the VPC"
  type = bool
  default = true
}

variable "test_instance" {
  type = tuple([string, number, bool])
  default = ["t2.nano", 1, true]
}

variable "prod_instance" {
  type = tuple([string, number, bool])
  default = ["t2.micro", 1, true]
}


variable "egress_dsg" {
  type = object({
    from_port = number
    to_port = number
    protocol = string
    cidr_block = list(string)
  })
  default = {
    from_port = 0
    to_port = 65365
    protocol = "tcp"
    cidr_block = ["172.31.1.0/24","172.31.2.0/24"]
  }
}

variable "ingress_ports" {
  description = "List of Ingress Ports"
  type = list(number)
  default = [ 22, 80, 8080 ]
}

variable "istest" {
  type = bool
}