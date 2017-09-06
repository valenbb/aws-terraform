provider "aws" {}
}

resource "aws_instance" "test" {
  ami           = "ami-4fffc834"
  instance_type = "t2.micro"
}

tags {
    Name = "test"
  }

security_groups = ["sg-ccc943b0"]
availability_zone = "us-east-1b"
subnet_id = "subnet-adbc6cf4"