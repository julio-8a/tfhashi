#AWS provider information
provider "aws" {
    profile = "default"
    region  = var.region
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