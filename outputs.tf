# output "ec2_public_ip" {
#     value = aws_instance.my_instance[*].public_ip
#     description = "The public IP address of the EC2 instance"
# }

# output "ec2_public_dns" {
#     value = aws_instance.my_instance[*].public_dns
#     description = "The public DNS name of the EC2 instance" 
# }

# output "ec2_private_ip" {
#     value = aws_instance.my_instance[*].private_ip
#     description = "The private IP address of the EC2 instance"
# }


output "ec2_public_ip" {
    value = [
        for key in aws_instance.my_instance : key.public_ip
    ]
}

output "ec2_public_dns" {
    value = [
        for instance in aws_instance.my_instance : instance.public_dns
    ]
}

output "ec2_private_ip" {
    value = [
        for instance in aws_instance.my_instance : instance.private_ip
    ]
}