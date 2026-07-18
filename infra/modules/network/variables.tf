variable "name_prefix" {
  type        = string
  description = "Prefix applied to network resources"
}

variable "vpc_cidr" {
  type        = string
  description = "Primary CIDR for VPC"
}

variable "azs" {
  type        = list(string)
  description = "Availability zones for subnet placement"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "CIDR blocks for public subnets"
}

variable "private_app_subnet_cidrs" {
  type        = list(string)
  description = "CIDR blocks for private app subnets"
}

variable "private_db_subnet_cidrs" {
  type        = list(string)
  description = "CIDR blocks for private db subnets"
}

variable "single_nat_gateway" {
  type        = bool
  description = "Use a single NAT gateway (cost optimization for non-prod)"
  default     = true
}

variable "tags" {
  type        = map(string)
  description = "Common tags"
  default     = {}
}
