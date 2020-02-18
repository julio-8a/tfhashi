#AWS provider information
provider "aws" {
    profile = "default"
    region  = var.region
}

#Create resource for ssh key-pair
resource "aws_key_pair" "aws-key" {
    key_name   = "joawskey"
    public_key = file("~/.ssh/id_rsa.pub")
}
#Leveraging free instance using a map type variable
resource "aws_instance" "hashiTraining" {
    ami           = var.amis[var.region]
    instance_type = var.free-tier-instance

    tags = {
        Name = "hashiTraining"
    }

    #Configure explicit dependency on S3 bucket creation
    depends_on = [aws_s3_bucket.tf-s3-example]

    #Configure SSH key pair
    connection {
        type        = "ssh"
        user        = "myec2-user"
        private_key = file("~/.ssh/id_rsa")
        host        = self.public_ip
    }

    #Provisioner to capture intance public IP address locally (local-exec)
    provisioner "local-exec" {
        command = "echo ${aws_instance.hashiTraining.public_ip} > ip_address.txt"
    }

    #Provisioner to configure instance
    provisioner "remote-exec" {
        inline = [
            "sudo amazon-linux-extras enable nginx1.12",
            "sudo yum -y install nginx",
            "sudo systemctl start nginx"
        ]
    }
}

#Resource to assing an elastic IP address to the EC2 instance
resource "aws_eip" "ip" {
    count    = var.instance_count
    vpc      = true
    instance = aws_instance.hashiTraining.id
}

#Create number of intances based on a variable
resource "aws_instance" "hashiTrainingCount" {
    count = var.instance_count
    ami           = var.amis[var.region]
    instance_type = var.free-tier-instance

    tags = {
        Name = element(var.instance_tags, count.index)
    }
}

#new S3 resource 
resource "aws_s3_bucket" "tf-s3-example" {
    bucket = "tf-s3-example-20200217"
    acl    = "private"
}