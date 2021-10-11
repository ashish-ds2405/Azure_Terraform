variable "web_vmss_inbound_nsg_port" {
    description = "Inbound port allow for VMSS"
    type = list(string)
    default = [22,80,443]
  
}