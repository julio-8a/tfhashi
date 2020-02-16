#AWS provider information
provider "aws" {
    profile = "default"
    region  = var.region
}

#Leveraging free instance using a map type variable
resource "aws_instance" "hashiTraining" {
    ami           = var.amis[var.region]
    instance_type = var.free-tier-instance
}