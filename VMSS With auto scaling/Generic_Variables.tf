# Business division

variable "business_division" {
  description = "Business division of large organisation"
  type = string
  default = "SAP"
}

variable "environment" {
  description = "Env value used as a prefix"
  default = "dev"
}

variable "resource_group_name" {
  description = "the name of the resource group"
  default = "EastUS-RG"
}

variable "resource_group_location" {
  description = "The location of the resource group"
  default = "East US"
}