provider "aws" {
  version = "~> 1.35"
  region = "${var.aws_region}"
}

resource "aws_security_group" "test_sg" {
  name 		= "${var.tag_name}-SG"
  description 	= "Allow inbound traffic from home only"
  vpc_id      	= "${var.vpc_prod_id}"

  ingress {
    from_port	= 22
    to_port	= 22
    protocol	= "tcp"
    cidr_blocks	= "${var.ssh_cidr_access}"
  }
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = "${var.web_cidr_access}"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = "${var.web_cidr_access}"
  }
  
  egress {
    from_port 	= 0
    to_port 	= 0
    protocol 	= "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name 	= "${var.tag_name}-SG"
    owner	= "${var.tag_owner}"
    env		= "${var.tag_env}"
    builder	= "${var.tag_builder}"
  }
}

resource "aws_instance" "test_server" {
  ami           		= "${var.aws_ami}"
  instance_type 		= "${var.instance_type}"
  vpc_security_group_ids 	= ["${aws_security_group.test_sg.id}"]
  key_name			= "${var.key_name}"  
  availability_zone 		= "${var.az_id}"
  subnet_id 			= "${var.subnet_id}" 
  associate_public_ip_address 	= "${var.public_ip}"
 
  tags {
    Name 	= "${var.tag_name}-${var.tag_env}"
    owner	= "${var.tag_owner}"
    env		= "${var.tag_env}"
    builder	= "${var.tag_builder}"
  }

  provisioner "chef"  {
    connection {
      type = "${var.connection_type}"
      user = "${var.server_user}"
      private_key = "${file("${var.ssh_key_filename}")}"
    }
    environment = "${var.chef_environment}"
    run_list = "${var.run_list}"
    node_name = "${var.tag_name}-${var.tag_env}"
    server_url = "${var.chef_server_url}"
    recreate_client = true
    user_name = "${var.chef_server_user_name}"
    user_key = "${file(var.chef_server_user_key)}"
    ssl_verify_mode = "${var.ssl_verify_mode}"
  }
}

