
# Change vairable for vpc region
variable "region-name" {
description = "name-of-region"
default     = "eu-west-2"
type        = string
}

# Change cidr for vpc
variable "cidr-for-vpc" {
description = "the-cidr-for-vpc"
default     = "10.0.0.0/16"
type        = string
}

# Change cidr for public subnet 1
variable "cidr-for-public-sub-1" {
description = "the cidr for pub subnet 1"
default     = "10.0.1.0/24"
type        = string
}

# Change cidr for public subnet 2
variable "cidr-for-public-sub-2" {
description = "the cidr for pub subnet 2"
default     = "10.0.2.0/24"
type        = string
}

# Change cidr for private subnet 1
variable "cidr-for-private-sub-1" {
description = "the cidr for pub subnet 2"
default     = "10.0.3.0/24"
type        = string
}

# Change cidr for private subnet 2
variable "cidr-for-private-sub-2" {
description = "the cidr for pub subnet 2"
default     = "10.0.4.0/24"
type        = string
}

# Change availability zone for eu-west-2a 
variable "avaialibility-zone-1" {
description = "availability zone for eu-west-2a"
default     = "eu-west-2a"
type        = string
}

# Change availability zone for eu-west-2b 
variable "avaialibility-zone-2" {
description = "availability zone for eu-west-2b"
default     = "eu-west-2b"
type        = string
}

# Change availability zone for eu-west-2c 
variable "avaialibility-zone-3" {
description = "availability zone for eu-west-2c"
default     = "eu-west-2c"
type        = string
}