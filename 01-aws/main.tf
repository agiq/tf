#Creat a VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block
  tags = {
    "Name" = "Main VPC"
  }
  enable_dns_support = var.enable_dns
}

#Create a subnet
resource "aws_subnet" "web_sn" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.web_subnet
  availability_zone = var.availability_zone[1]
  tags = {
    "Name" = "Web Subnet"
  }
}

resource "aws_subnet" "db_sn" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.db_subnet
  availability_zone = var.availability_zone[2]
  tags = {
    "Name" = "db Subnet"
  }
}

resource "aws_subnet" "frontend_sn" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.fe_subnet
  availability_zone = var.availability_zone[3]
  tags = {
    "Name" = "frontend Subnet"
  }
}

resource "aws_db_subnet_group" "db-subnet" {
  name       = "db_subnet_group"
  subnet_ids = ["${aws_subnet.db_sn.id}", "${aws_subnet.web_sn.id}"]
}


resource "aws_internet_gateway" "my_web_igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    "Name" = "${var.main_vpc_name} IGW"
  }
}

# Associate the Internet Gateway to the default Route Table (RT)
resource "aws_default_route_table" "main_vpc_default_rt" {
  default_route_table_id = aws_vpc.main.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"  # default route
    gateway_id = aws_internet_gateway.my_web_igw.id
  }
  tags = {
    "Name" = "my-default-rt"
  }
}

resource "aws_default_security_group" "default_sg" {
  vpc_id = aws_vpc.main.id
  # ingress {
  #   from_port = 22
  #   to_port = 22
  #   protocol = "tcp"
  #   cidr_blocks = [var.my_public_ip]
  # }

  # dynamic "ingress" {
  #   for_each = var.ingress_ports
  #   content {
  #     from_port = ingress.value
  #     to_port = ingress.value
  #     protocol = "tcp"
  #   }
  # }

    dynamic "ingress" {
    for_each = var.ingress_ports
    iterator = iport
    content {
      from_port = iport.value
      to_port = iport.value
      protocol = "tcp"
    }
  }

  egress {
    from_port = var.egress_dsg["from_port"]
    to_port = var.egress_dsg["to_port"]
    protocol = var.egress_dsg["protocol"]
    cidr_blocks = var.egress_dsg["cidr_block"]
  }
  tags = {
    "Name" = "Default Security Group"
  }
}

resource "aws_key_pair" "test_ssh_key" {
  key_name = "testing_ssh_key"
  public_key = file(var.ssh_public_key)
}

data "aws_ami" "latest_amazon_linux2"{
  owners = ["amazon"]
  most_recent = true
  filter {
    name = "name"
    values = ["amzn2-ami-kernel-*-x86_64-gp2"]
  }

  filter {
    name = "architecture"    
    values = ["x86_64"]
  }
}

data "aws_secretsmanager_secret_version" "creds" {
  secret_id = "db_creds"
}

locals {
  db_creds = jsondecode(data.aws_secretsmanager_secret_version.creds.secret_string)
}

resource "aws_db_instance" "default" {
  allocated_storage = 10
  engine =  "mysql"
  engine_version = "8.0.27"
  instance_class = "db.t3.micro"
  db_name = "mydb"
  username = local.db_creds.username
  password = local.db_creds.password
  skip_final_snapshot = true
  db_subnet_group_name = "${aws_db_subnet_group.db-subnet.name}"
}
# Spinning up an EC2 Instance
resource "aws_instance" "test_vm" {
  ami = data.aws_ami.latest_amazon_linux2.id
  instance_type = var.test_instance[0]
  ##cpu_core_count = var.my_instance[1]
  associate_public_ip_address = var.test_instance[2]
  user_data = file(".\\entry_script.sh") # running the script on the EC2 instance at boot

  subnet_id = aws_subnet.web_sn.id
  vpc_security_group_ids = [aws_default_security_group.default_sg.id]
  key_name = "testing_ssh_key"

  tags = {
    "Name" = "My EC2 Intance - Amazon Linux 2"
  }
  count = var.istest == true ? 1:0

}

resource "aws_instance" "prod_vm" {
  ami = data.aws_ami.latest_amazon_linux2.id
  instance_type = var.prod_instance[0]
  #cpu_core_count = var.my_instance[1]
  associate_public_ip_address = var.prod_instance[2]
  user_data = file(".\\entry_script.sh") # running the script on the EC2 instance at boot

  subnet_id = aws_subnet.web_sn.id
  vpc_security_group_ids = [aws_default_security_group.default_sg.id]
  key_name = "testing_ssh_key"

  tags = {
    "Name" = "My EC2 Intance - Amazon Linux 2"
  }
  count = var.istest == false ? 1:0
}
