variable "ec2_instance_type" {
    description = "The type of instance to create"
    type = string
    default = "t3.micro"
  
}

variable "aws_root_storage_size" {
    description = "The size of the root storage volume in GB"
    type = number
    default = 15
}

variable "ec2_ami_id" {
    description = "The ID of the AMI to use for the EC2 instance"
    type = string
    default = "ami-0b6d9d3d33ba97d99" # Amazon Linux 2 AMI (HVM), SSD Volume Type
}


variable "ec2_instance_count" {
    description = "The number of EC2 instances to create"
    type = number
    default = 3
}