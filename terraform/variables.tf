variable "dns_server" {
  description = "Server name for the DNS server that will be updated."
}
variable "dns_key_name" {
  description = "Name of the key used for dynamic updates on the DNS server."
}
variable "dns_key_algorithm" {
  description = "The key algorithm."
}
variable "dns_key_secret" {
  description = "The key secret used to authenticate."
}

variable "vsphere_user" {
  description = "User account to login to vSphere with."
}
variable "vsphere_password" {
  description = "Password to login to vSphere with."
}
variable "vsphere_server" {
  description = "vCenter server to login to."
}
