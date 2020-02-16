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

