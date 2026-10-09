# key pair 
resource "aws_key_pair" "my_key" {
    key_name = "my_key"
    public_key = file("terra-key-ec2.pub")
}



# VPC & Security Grooup
resource "aws_default_vpc" "default" {
    tags = {
        name = "default-vpc"
    }
}

resource "aws_security_group" "my_security_group" {
    name        = "automatic_security_group"
    description = "This will add a TF Generated Security Group"
    vpc_id      = aws_default_vpc.default.id

    #inbound rules
    ingress {
        from_port  = 22
        to_port    = 22
        protocol   = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow SSH access from anywhere"
    }
    ingress {
        from_port  = 80
        to_port    = 80
        protocol   = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allow HTTP access from anywhere"
    }

    ingress {
        from_port = 8000
        to_port = 8000
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Allows access to port 8000 from anywhere"
    }


    #outbound rules
    egress {
        from_port  = 0
        to_port    = 0
        protocol   = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "automatic_security_group"
    }
}


#EC2 Instance

resource "aws_instance" "my_instance" {
    for_each = tomap({
        automate-micro = "t3.micro"
        automate-small = "t3.small"
    })
    # count = var.ec2_instance_count
    key_name = aws_key_pair.my_key.key_name
    # security_groups = [aws_security_group.my_security_group.name]
    vpc_security_group_ids = [aws_security_group.my_security_group.id]
    instance_type = each.value
    ami = var.ec2_ami_id

    user_data = file("install_nginx.sh")    

    root_block_device {
        volume_size = var.aws_root_storage_size
        volume_type = "gp3"
    }

    tags = {
        Name = each.key
    }
}