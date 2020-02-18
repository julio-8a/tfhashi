variable "region" {
    description = "AWS zone"
    default     = "us-east-2"
}

variable "amis" {
    type    = "map"
    default = {
        "us-east-2" = "ami-0c55b159cbfafe1f0"
    }
}

variable "free-tier-instance" {
    description = "AWS instance type"
    default     = "t2.micro"
}

variable "instance_count" {
    description = "Total instances for this build"
    default     = 3
}

variable "instance_tags" {
    type    = "list"
    default = ["hashitraining-0", "hashitraining-1", "hashitraining-2"]
}