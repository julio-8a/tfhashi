#AWS provider information
provider "aws" {
    profile = "default"
    region  = var.region
}

resource "aws_instance" "hashiTraining" {
    ami           = var.amis[var.region]
    instance_type = var.free-tier-instance
}